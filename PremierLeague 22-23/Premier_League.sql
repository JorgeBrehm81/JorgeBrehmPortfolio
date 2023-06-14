--Creating Premier League Standings table just as it is in excel to connect it through SSIS
CREATE TABLE PLS(
	rank INT,
	points INT,
	goalsDiff INT,
	team_id INT PRIMARY KEY,
	team_name VARCHAR(40),
	matches_played INT,
	wins INT,
	draws INT, 
	losses INT,
	goals_for INT,
	goals_against INT,
	home INT,
	home_wins INT,
	home_draw INT,
	home_lose INT,
	home_goals_for INT,
	home_goals_against INT,
	away INT,
	away_wins INT,
	away_draw INT,
	away_lose INT, 
	away_goals_for INT,
	away_goals_against INT
)

SELECT * FROM PLS
ORDER BY rank ASC




--Creating Matchday Results table just as it is in excel to connect it through SSIS
CREATE TABLE MDR(
	fixture_id INT PRIMARY KEY,
	teams_home_id INT,
	teams_home_name VARCHAR(40),
	teams_home_winner VARCHAR(10),
	teams_away_id INT,
	teams_away_name VARCHAR(10),
	teams_away_winner VARCHAR(10),
	goals_home INT,
	goals_away INT
)

SELECT * FROM MDR

--Creating Home team stats table just as it is in excel to connect it through SSIS

CREATE TABLE HTS(
	fixture_id INT PRIMARY KEY,
	home_team_id INT,
	home_team_name VARCHAR(40),
	shots_on_goal	INT,
	shots_off_goal INT,
	total_shots	INT,
	blocked_shots INT,
	shots_insidebox INT,
	shots_outsidebox INT,
	fouls INT,
	corner_kicks INT,
	offsides INT,
	ball_poss DECIMAL(5,2),
	yellow_cards INT,
	red_cards INT,
	gk_saves INT,
	total_passes INT,
	accurate_passes INT, 
	passes_perc DECIMAL(5,2),
	expected_goals DECIMAL(5,2)
)


SELECT * FROM HTS

--Creating Away team stats table just as it is in excel to connect it through SSIS
CREATE TABLE ATS(
	fixture_id INT PRIMARY KEY,
	away_team_id INT,
	away_team_name VARCHAR(40),
	shots_on_goal	INT,
	shots_off_goal INT,
	total_shots	INT,
	blocked_shots INT,
	shots_insidebox INT,
	shots_outsidebox INT,
	fouls INT,
	corner_kicks INT,
	offsides INT,
	ball_poss DECIMAL(5,2),
	yellow_cards INT,
	red_cards INT,
	gk_saves INT,
	total_passes INT,
	accurate_passes INT, 
	passes_perc DECIMAL(5,2),
	expected_goals DECIMAL(5,2)
)

SELECT * FROM ATS

--EXEC sp_rename 'dbo.ATS.expected_goals', 'A_expected_goals', 'COLUMN'; (Change name of columns)

--CREATE VIEW STANDINGS
CREATE VIEW standings AS
SELECT *, 
	   (goals_for - goals_against) as goals_diff, 
	   (home_goals_for - home_goals_against) as home_goals_diff, 
	   (away_goals_for - away_goals_against) as away_goals_diff,
	   (home_wins * 100 / home) as home_wins_perc,
	   (away_wins * 100 / away) as away_wins_perc
FROM PLS


--CREATE VIEW MATCHES
CREATE VIEW matches AS
SELECT  MDR.fixture_id,
		HTS.home_team_name, HTS.shots_on_goal,HTS.shots_off_goal, HTS.total_shots, HTS.blocked_shots, HTS.shots_insidebox, HTS.shots_outsidebox, HTS.fouls, HTS.corner_kicks, HTS.offsides,
		HTS.ball_poss, HTS.yellow_cards, HTS.red_cards, HTS.gk_saves, HTS.total_passes, HTS.accurate_passes, HTS.passes_perc, HTS.expected_goals,
		ATS.away_team_name, ATS.A_shots_on_goal, ATS.A_shots_off_goal, ATS.A_total_shots, ATS.A_blocked_shots, ATS.A_shots_insidebox, ATS.A_shots_outsidebox, ATS.A_fouls,
		ATS.A_corner_kicks, ATS.A_offisdes as A_offsides, ATS.A_ball_poss, ATS.A_yellow_cards, ATS.A_red_cards, ATS.A_gk_saves, ATS.A_total_passes, ATS.A_accurate_passes, ATS.A_passes_perc,
		ATS.A_expected_goals,
		MDR.goals_home, MDR.goals_away 
FROM MDR
JOIN ATS ON MDR.fixture_id = ATS.fixture_id
JOIN HTS ON ATS.fixture_id = HTS.fixture_id

 
-- STANDINGS BASED ON EXPECTED GOALS
CREATE VIEW xg_standings AS
SELECT team_name, SUM(points) AS total_points -- Calculate the total points for each team by summing up the points column
FROM (
  SELECT home_team_name AS team_name, --Query for home team
         CASE  
           WHEN ROUND(expected_goals,1) > ROUND(A_expected_goals,1) THEN 3 -- Add 3 points if home team wins
           WHEN ROUND(expected_goals,1) = ROUND(A_expected_goals,1) THEN 1 -- Add 1 point if home team ties
           ELSE 0 -- 0 points if losses
         END AS points -- NEW column name
  FROM matches -- View
  UNION ALL --  combines the results from the first and second parts of the subquery. This shows a single dataset
  SELECT away_team_name AS team_name, --query for away team
         CASE
           WHEN ROUND(expected_goals,1) < ROUND(A_expected_goals,1) THEN 3 -- Add 3 points if away team wins
           WHEN ROUND(expected_goals,1) = ROUND(A_expected_goals,1) THEN 1 -- Add 1 point if away team ties
           ELSE 0 --0 points if losses
         END AS points --NEW column name (same as for home team)
  FROM matches --View
) AS subquery --  Provides an alias to the subquery results, allowing to refer to it as a temporary table within the outer query.
GROUP BY team_name --Group the rows by team name


SELECT * FROM xg_standings
ORDER BY total_points desc
