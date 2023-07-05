# Super Bowl TV Spots: Top 10 Brands
### 2000-2023

In this project I worked with data I found on Maven Analytics (https://mavenanalytics.io/data-playground) specifically with 
"Super Bowl Commercials: Super Bowl commercials for 10 popular brands from 2000 to 2021". This contained 2 CSV files which can be found in this folder as:
- data_dictionary.csv
- superbowl_commercials.csv

The purpose of this project was to find insights from this data. I used Chat GPT to act as the commissioner of the NFL and asked me for metrics "he" would be interested in. Chat GPT came up with the following:
1. **Total number of commercials per brand:** This metric provides an overview of how many commercials each brand has aired during the Super Bowl over the specified period. It helps identify which brands have
been consistent advertisers and have invested in Super Bowl ad campaigns.
2. **Average ad length per brand:** This metric calculates the average duration of commercials for each brand. It can help determine if there is a correlation between ad length and the success of the commercial.
3. **Funny commercials per brand:** This metric calculates the funny commercials for each brand. It helps identify which brands tend to use humor as a strategy in their Super Bowl ads.
4. **Cost-effectiveness analysis:** This analysis examines the relationship between the estimated cost of the TV spot and the YouTube views and likes. It helps evaluate the return on investment
for brands based on their ad spend and online engagement.
5. **Estimated Cost per TV Spot:** This metric helps understand which brands are the most invested in the NFL and which ones are the ones that would spend more money on super bowl ads.

This insights can be found in the either Power BI dashboard or in the SQL file as simple "select" statements.

## Procedure:

### Excel
I opened the "superbowl_commercials.csv" file to see how it was structured and "data_dictionary.csv" to help me understand the data. One great thing about the dictionary file was that it contained
the sources from where this data was collected. With this information I was able to search the missing data of 2022 & 2023 which I later added to the CSV file "superbowl_commercials.csv". One last thing
I did in Excel was to delete the columns that contained the URLs of the commercials since I was not going to need them for the analysis.

### SQL Server Integrated Services (SSIS)
After I had the "superbowl_commercials.csv" ready I extracted it from Excel to SQL using SSIS this file can be found as "TV_spots.sln". Where all I did was load the data to an identical SQL table I created. 
I used a flat file source to load the table into SSIS and then pass it on to an Object Linking and Embedding Database (OLE DB) Source to SQL. I mapped the columns from the CSV file to the SQL table 
I created and that's how I load the data into SQL.

### SQL Server
This file can be found as "SB_tv_spots.sql" in this folder. First I had to create the table "spots" which contained all the data I imported from Excel using SSIS. For the columns that had the 
data type as boolean (True or False) I used the "BIT" in SQL which helps identify true or false values with 1 being True and 0, False. After I had the table with the proper data, I did all the analysis 
Chat GPT asked me for.

### Power BI
I already had the analysis done but I thought the metrics would look nicer in a dashboard. I imported the data from SQL Server into Power BI, you can find this file as "SB_ads.pbix" or the dashboard as 
a PNG file "superbowls_bi.png". 3 main metrics are shown in the dasboard:
- TV Spots per Brand
- "Funny" TV spots per Brand
- Median Estimated Cost per TV Spot in Millions of Dollars

Why did I made a pie chart just for the funny tv spots? Because that was the category with the most tv spots.
Why did I used the median rather than the average: Because the data contained outliers.

## Conclusions

- Bud Light has made 64 super bowl commercials! 20 more than the next top brand (Doritos).
- The NFL is the one who spends more per TV spot because their commercials are typically the longest.
- Funny TV spot = More YT Views
  

