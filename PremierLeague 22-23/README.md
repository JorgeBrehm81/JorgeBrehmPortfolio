# Premier League 2022-23 Project

In this project I worked with some Premier League datasets I found on Kaggle: https://www.kaggle.com/datasets/afnanurrahim/premier-league-2022-23 and 
used Chat GPT to act as a director of the Premier League to come up with metrics I should work on.

After downloading the 4 csv files which are in this folder:
- PLS.csv for Premier League Standings
- MDR.csv for Matchday Results
- ATS.csv for Away Team Stats
- HTS.csv for Home Team Stats

I used SSIS (SQL Server Integration Services) to Extract, transform and load the data into SQL. SSIS file is names PL_standings where all I did was fix 
the NULL values and connect the csv files to SQl so i can work on them properly.

In the SQL file (Premier_League.sql) I created the tables PLS, MDR, ATS, HTS so SSIS had somewhere to land the information collected on the csv files.
It's very importante the names of the columns are written the same as in the csv file so there is no problem when loading the data to SQL. 
Once I had the data in SQL I created the views "Standings" with some calculated columns and "Matches" were I joined the tables MDR, ATS and HTS.
After I had these views, I created a last one called "xg_standings" were clubs were now ranked by the points each of them
would have had if the matches were decided by the "Expected Goals" and not by the scoreboard.

What is Expected Goals?
- Is a football metric which allows to evaluate teams and/or players performances. In simple words, it's designed to measure the probability
of a shot resulting in a goal. It uses historical data from shots with similar characteristics to estimate the probability of a goal on a scale
from 0-1. e.g. A shot with an xG of 0.8 indicates that 8 out of 10 times that specific shot would have ended on a goal.

Why I worked with views?
- Because my main goal was to export this data to Power BI so I can create some visualizations for the metrics Chat GPT (director of the Premier League)
asked me. Computationally speaking, working with views in SQL is way better than working with tables since they require less space.

Once I imported these 3 views to Power BI I created some visualizations.
- "xGStandings.png": I add the original standings of the 2022-23 season alongisde with how it would have been if the matches were decided by Expected Goals (xG).
The column "Points Difference" is just a simple subtraction of column "xG Points" - "Points". I used conditional formatting to color code the teams that are
relegating, going to the Champions League, Europe League and the champion of the Premier League. if the matches were decided by xG Brighton would have
been the champion, Leicester would still be in the Premier League and Manchester United wouldn't be in any european tournaments the next season.

- "HomeStats.png" & "awayStats.png": Here is where I used the data from the other 2 views, "Standings" and "Matches". I just had to filter for each team to get
their at home and away stats. In these 2 visualizations we can compare how the top 4 Premier League clubs (aka. Champions League teams) performed at home
and as visiting teams. Something to look out for is that the Red Devils won 36% less games as a visiting team than at home and their goal difference
went from +26 at home to -11 as a visiting team.

You can find these 3 PNG files in the "Premier_PROJ.pbix".

Hope you like it.





