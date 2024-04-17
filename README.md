# Introduction
📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql folder](/SQL_Project/)

# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

Data hails from 
It's packed with insights on job titles, salaries, locations, and essential skills.

### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on jobs in India or Work from Home. This query highlights the high paying opportunities in the field.

```sql
SELECT 
    job_postings_fact.job_id,
    job_title,
    salary_year_avg,
    company_dim.name AS company,
    job_location,
    job_schedule_type,
    job_posted_date
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' AND 
    (job_location LIKE '%India' OR job_work_from_home = TRUE) AND
    salary_year_avg IS NOT NULL
ORDER BY 
    salary_year_avg DESC
LIMIT 10;
```
Here's the breakdown of the top data analyst jobs in 2023:
- **Wide Salary Range:** Top 10 paying data analyst roles span from $184,000 to $650,000, indicating significant salary potential in the field.
- **Diverse Employers:** Companies like SmartAsset, Meta, and AT&T are among those offering high salaries, showing a broad interest across different industries.
- **Job Title Variety:** There's a high diversity in job titles, from Data Analyst to Director of Analytics, reflecting varied roles and specializations within data analytics.


| job_title                       | salary_year_avg | company                     |
|---------------------------------|-----------------|-----------------------------|
| Data Analyst                    | 650000.0        | Mantys                      |
| Director of Analytics           | 336500.0        | Meta                        |
| Associate Director Data Insights| 255829.5        | AT&T                        |
| Data Analyst, Marketing         | 232423.0        | Pinterest Job Advertisements|
| Data Analyst (Hybrid/Remote)    | 217000.0        | Uclahealthcareers           |
| Principal Data Analyst (Remote) | 205000.0        | SmartAsset                  |
| Director, Data Analyst - HYBRID | 189309.0        | Inclusively                 |
| Principal Data Analyst          | 189000.0        | Motional                    |
| Principal Data Analyst          | 186000.0        | SmartAsset                  |
| ERM Data Analyst                | 184000.0        | Get It Recruit              |




### 2. Skills for Top Paying Jobs
To understand what skills are required for the top-paying jobs, I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.
```sql
WITH top_jobs AS (
    SELECT 
        job_postings_fact.job_id,
        job_title,
        salary_year_avg,
        company_dim.name AS company,
        job_location
    FROM 
        job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE 
        job_title_short = 'Data Analyst' AND 
        (job_location LIKE '%India' OR job_work_from_home = TRUE) AND
        salary_year_avg IS NOT NULL
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)
SELECT
   top_jobs. *,
   skills
FROM 
	top_jobs
INNER JOIN skills_job_dim ON skills_job_dim.job_id = top_jobs.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY 
	salary_year_avg DESC;
```
Here's the breakdown of the most demanded skills for the top 10 highest paying data analyst jobs in 2023:


### 3. In-Demand Skills for Data Analysts

This query helped identify the skills most frequently requested in job postings, directing focus to areas with high demand.

```sql
SELECT 
    skills,
    count(job_postings_fact.job_id) AS no_of_jobs,
    ROUND (AVG(salary_year_avg), 2) AS avg_salary
FROM 
		job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY 
		skills
ORDER BY 
		no_of_jobs DESC
LIMIT 5;
```
Here's the breakdown of the most demanded skills for data analysts in 2023
- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python**, **Tableau**, and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| Skills   | no_of_jobs   | avg_salary |
|----------|--------------|------------|
| SQL      | 92628        | 96435.33   |
| Excel    | 67031        | 86418.90   |
| Python   | 57326        | 101511.85  |
| Tableau  | 46554        | 97978.08   |
| Power BI | 39468        | 92323.60   |

*Table of the demand for the top 5 skills in data analyst job postings*

### 4. Skills Based on Salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.
```sql
SELECT  
    skills, 
    ROUND(AVG(salary_year_avg), 1) AS avg_salary,
    count(job_postings_fact.job_id) AS no_of_jobs
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id  = skills_job_dim.skill_id
WHERE 
    salary_year_avg IS NOT NULL
GROUP BY skills
HAVING 
    count(job_postings_fact.job_id) > 100
ORDER BY 
    avg_salary DESC
LIMIT 25;
```
Here's a breakdown of the results for top paying skills for Data Analysts:


| Skills        | Average Salary ($)  |no of jobs
|---------------|-------------------: |---------
| mongo         |            170714.9 | 262
| cassandra     |            154124.3 | 530
| neo4j         |            147707.9 | 123
| scala         |            145119.5 | 1912
| kafka         |            144753.8 | 1642
| pytorch       |            144470.1 | 1081
| shell         |            143370.2 | 731
| golang        |            143138.7 | 109
| airflow       |            142385.8 | 1506
| tensorflow    |            142370.3 | 1225
| spark         |            141733.5 | 4025

*Table of the average salary for the top 10 paying skills for data analysts*

### 5. Most Optimal Skills to Learn

Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill development.

```sql
SELECT 
    skills, 
    count(job_postings_fact.job_id) AS no_of_jobs,
    round(avg(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_location LIKE '%India' AND
    salary_year_avg IS NOT NULL
GROUP BY 
    skills
HAVING 
    count(job_postings_fact.job_id) > 10
ORDER BY 
    no_of_jobs DESC,
    avg_salary DESC
LIMIT 10;
```

| Skills     | Demand Count | Average Salary ($) |
|------------|--------------|-------------------:|
| sql        | 46           |            92984 |
| excel      | 39           |            88519 |
| python     | 36           |            95933 |
| tableau    | 20           |            95103 |
| r          | 18           |            86609 |
| power bi   | 17           |            109832|
| azure      | 15           |            98570 |
| aws        | 12           |            195333|
| spark      | 11           |            118332|
| oracle     | 11           |            104260|

*Table of the most optimal skills for data analyst sorted by salary*

Here's a breakdown of the most optimal skills for Data Analysts in 2023: 
- **High-Demand Programming Languages:** 
- **Cloud Tools and Technologies:** S
- **Business Intelligence and Visualization Tools:** 
- **Database Technologies:** 

# What I Learned

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **🧩 Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- **📊 Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **💡 Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

# Conclusions

### Insights
From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.