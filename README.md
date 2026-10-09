# Movie Financial Analysis

## Project Overview

This project analyzes movie financial performance using Python, SQL, and Excel. 
The goal was to explore how factors such as budget, genre, runtime, release decade,
popularity, ratings, and production company relate to revenue and return on investment (ROI).

## Tools Used

- Python / Pandas — data cleaning and preprocessing
- DuckDB / SQL — querying and aggregation
- Excel — summary tables, correlations, and visual analysis

## Dataset

The project uses a movie metadata dataset containing information such as:

- Title
- Budget
- Revenue
- Genre
- Runtime
- Release date
- Production company
- Popularity
- Ratings and vote counts

Movies with missing or unusable financial data were filtered where appropriate.

## Analysis Process

### 1. Data Preparation

Python was used to load and prepare the dataset.

Nested genre and production company fields were parsed and expanded so they could be
analyzed individually.

The cleaned DataFrames were then registered as DuckDB tables for SQL analysis.

### 2. SQL Analysis

SQL was used to analyze:

- Overall movie performance
- Highest-rated movies
- Most popular movies
- Revenue, budget, profit, and ROI
- ROI by genre
- ROI by runtime
- ROI by release decade
- ROI by production company

Both average and median ROI were used when appropriate to reduce the effect of extreme outliers.

### 3. Excel Analysis and Visualization

SQL results were exported to Excel for further analysis and presentation.

Excel was used to:

- Compare average and median ROI
- Summarize genre, runtime, decade, and company performance
- Calculate correlations between financial and popularity metrics
- Create formatted summary tables

## Key Findings

- Budget and revenue had a strong positive correlation of approximately **0.73**.
- Vote count had an even stronger relationship with revenue at approximately **0.77**.
- Horror had the highest average ROI among the analyzed genres.
- Animation had the highest median ROI among genres.
- Blumhouse Productions had the highest median ROI among the selected production companies.
- Movies between 150–180 minutes had the highest median ROI among the runtime groups analyzed.
- The 1970s had the highest average ROI among the release decades studied.

The difference between average and median ROI showed that a small number of highly successful
movies can significantly inflate average returns.

## Project Structure

- `analysis.py` — Python preprocessing and data preparation
- `analysis.sql` — SQL queries used for analysis
- `movie_financial_analysis.xlsx` — final Excel analysis workbook
- `movies_metadata.csv.zip` — raw dataset

## Skills Demonstrated

- Data cleaning
- SQL querying
- Data aggregation
- Python / Pandas
- DuckDB
- Excel
- Exploratory data analysis
- Business-focused interpretation of data
