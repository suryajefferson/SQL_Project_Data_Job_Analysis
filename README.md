## Introduction
📊 Dive into the data job market! Focusing on data analyst roles, this project explores 💰 top-paying jobs, 🔥 in-demand skills, and 📈 where high demand meets high salary in data analytics.

🔍 SQL queries? Check them out here: [project_sql folder](/SQL_Project/)

## Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top-paid and in-demand skills, streamlining others work to find optimal jobs.

Data hails from 
It's packed with insights on job titles, salaries, locations, and essential skills.

#### The questions I wanted to answer through my SQL queries were:

1. What are the top-paying data analyst jobs?
2. What skills are required for these top-paying jobs?
3. What skills are most in demand for data analysts?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

## Tools I Used
For my deep dive into the data analyst job market, I harnessed the power of several key tools:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis, ensuring collaboration and project tracking.

## The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market. Here’s how I approached each question:

### 1. Top Paying Data Analyst Jobs


<details>
<summary>Click to toggle contents of "Code and details"</summary>
To identify the highest-paying roles, I filtered data analyst positions by average yearly salary and location, focusing on jobs in India or Work from Home. This query highlights the high paying opportunities in the field.

``` sql
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
</details>

<details>
<summary>Click to toggle "Breakdown and Results" </summary>

#### Breakdown of the top data analyst job listings
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
</details>

### 2. Skills for Top Paying Jobs

<details>
<summary>Click to toggle contents of "Code and details"</summary>
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
</details>

<details>
<summary>Click to toggle contents of "Breakdown and Results"</summary>


#### Breakdown of Job Listings and Required Skills

1. **Associate Director- Data Insights at AT&T**
   - Salary: $255,829.5
   - Location: Anywhere
   - Skills:
     - SQL
     - Python
     - R
     - Azure
     - Databricks
     - AWS
     - Pandas
     - PySpark
     - Jupyter
     - Excel
     - Tableau
     - Power BI
     - PowerPoint

2. **Data Analyst, Marketing at Pinterest Job Advertisements**
   - Salary: $232,423.0
   - Location: Anywhere
   - Skills:
     - SQL
     - Python
     - R
     - Hadoop
     - Tableau

3. **Data Analyst (Hybrid/Remote) at Uclahealthcareers**
   - Salary: $217,000.0
   - Location: Anywhere
   - Skills:
     - SQL
     - Crystal
     - Oracle
     - Tableau
     - Flow

4. **Principal Data Analyst (Remote) at SmartAsset**
   - Salary: $205,000.0
   - Location: Anywhere
   - Skills:
     - SQL
     - Python
     - Go
     - Snowflake
     - Pandas
     - NumPy
     - Excel
     - Tableau
     - GitLab

5. **Director, Data Analyst - HYBRID at Inclusively**
   - Salary: $189,309.0
   - Location: Anywhere
   - Skills:
     - SQL
     - Python
     - Azure
     - AWS
     - Oracle
     - Snowflake
     - Tableau
     - Power BI
     - SAP
     - Jenkins
     - Bitbucket
     - Atlassian
     - Jira
     - Confluence

6. **Principal Data Analyst, AV Performance Analysis at Motional**
   - Salary: $189,000.0
   - Location: Anywhere
   - Skills:
     - SQL
     - Python
     - R
     - Git
     - Bitbucket
     - Atlassian
     - Jira
     - Confluence

7. **Principal Data Analyst at SmartAsset**
   - Salary: $186,000.0
   - Location: Anywhere
   - Skills:
     - SQL
     - Python
     - Go
     - Snowflake
     - Pandas
     - NumPy
     - Excel
     - Tableau
     - GitLab

8. **ERM Data Analyst at Get It Recruit - Information Technology**
   - Salary: $184,000.0
   - Location: Anywhere
   - Skills:
     - SQL
     - Python
     - R

</details>

### 3. In-Demand Skills for Data Analysts
<details>
<summary>Click to toggle contents of "Code and details"</summary>
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
</details>

<details>
<summary>Click to toggle contents of "Breakdown and Results"</summary>

#### Breakdown of the most demanded skills for Data Analysts
- **SQL** and **Excel** remain fundamental, emphasizing the need for strong foundational skills in data processing and spreadsheet manipulation.
- **Programming** and **Visualization Tools** like **Python**, **Tableau**, and **Power BI** are essential, pointing towards the increasing importance of technical skills in data storytelling and decision support.

| Skills   | no_of_jobs   | avg_salary |
|----------|--------------|------------|
| SQL      | 92628        | 96435.33   |
| Excel    | 67031        | 86418.90   |
| Python   | 57326        | 101511.85  |
| Tableau  | 46554        | 97978.08   |
| Power BI | 39468        | 92323.60   |
</details>


### 4. Skills Based on Salary

<details>
<summary>Click to toggle contents of "Code and details"</summary>
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
</details>

<details>
<summary>Click to toggle contents of "Breakdown and Results"</summary>

#### Breakdown of Skills, Demand, and Salary Statistics:

1. **High Demand for Database & Big Data Technologies:**
   - Skills like **MongoDB**, **Cassandra**, and **Neo4j** are in demand, with substantial numbers of job openings.
   - Technologies such as **Kafka** and **Spark** are also highly sought after, as indicated by the large number of job postings.
   - Proficiency in these database and big data technologies is reflected in the competitive average salaries.

2. **Emphasis on Programming Languages & Frameworks:**
   - **Scala** and **Python** frameworks like **PyTorch** are highly valued, with significant numbers of job openings.
   - Proficiency in programming languages such as **Golang** is also recognized, albeit with fewer job openings compared to others.

3. **Importance of Data Processing & Workflow Management:**
   - Tools like **Airflow** are essential for workflow management and automation in data processing, as indicated by the considerable number of job postings.
   - **Shell scripting** skills remain relevant, reflecting the need for automation and scripting in data-related tasks.

4. **Machine Learning & AI Frameworks:**
   - Skills in machine learning frameworks like **PyTorch** and **TensorFlow** command competitive salaries, reflecting the demand for expertise in AI and machine learning.



| Skill       | Average Salary ($) | Number of Jobs |
|-------------|--------------------|----------------|
| MongoDB     | $170,714.9         | 262            |
| Cassandra   | $154,124.3         | 530            |
| Neo4j       | $147,707.9         | 123            |
| Scala       | $145,119.5         | 1,912          |
| Kafka       | $144,753.8         | 1,642          |
| PyTorch     | $144,470.1         | 1,081          |
| Shell       | $143,370.2         | 731            |
| Golang      | $143,138.7         | 109            |
| Airflow     | $142,385.8         | 1,506          |
| TensorFlow  | $142,370.3         | 1,225          |
</details>


### 5. Most Optimal Skills to Learn

<details>
<summary>Click to toggle contents of "Code and details"</summary>

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
</details>

<details>
<summary>Click to toggle contents of "Breakdown and Results"</summary>

#### Breakdown of Skills, Demand, and Salary Statistics

1. **Proficiency in Fundamental Tools:**
   - Skills like **SQL**, **Excel**, and **Python** are foundational, with a significant number of job postings.
   - **Excel** and **Python** skills are particularly prevalent, indicating their widespread use across various industries.

2. **Visualization and Analytics Tools:**
   - Tools like **Tableau** and **Power BI** are essential for data visualization and analytics, with competitive average salaries.

3. **Programming and Database Technologies:**
   - **R** and **Spark** skills demonstrate proficiency in statistical analysis and big data processing, respectively.
   - Knowledge of **Oracle** and **SQL** databases remains valuable, with a considerable demand in the market.

4. **Cloud Platforms and Services:**
   - Proficiency in cloud platforms such as **Azure** and **AWS** is increasingly important, with higher average salaries indicating their significance in the industry.


| Skill     | Demand Count | Average Salary ($) |
|-----------|--------------|--------------------|
| SQL       | 46           | $92,984            |
| Excel     | 39           | $88,519            |
| Python    | 36           | $95,933            |
| Tableau   | 20           | $95,103            |
| R         | 18           | $86,609            |
| Power BI  | 17           | $109,832           |
| Azure     | 15           | $98,570            |
| AWS       | 12           | $195,333           |
| Spark     | 11           | $118,332           |
| Oracle    | 11           | $104,260           |
</details>

## What I Learned

Throughout this adventure, I've turbocharged my SQL toolkit with some serious firepower:

- **🧩 Complex Query Crafting:** Mastered the art of advanced SQL, merging tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- **📊 Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **💡 Analytical Wizardry:** Leveled up my real-world puzzle-solving skills, turning questions into actionable, insightful SQL queries.

## Conclusions

### Insights
From the analysis, several general insights emerged:

1. **Top-Paying Data Analyst Jobs**: The highest-paying jobs for data analysts that allow remote work offer a wide range of salaries, the highest at $650,000!
2. **Skills for Top-Paying Jobs**: High-paying data analyst jobs require advanced proficiency in SQL, suggesting it’s a critical skill for earning a top salary.
3. **Most In-Demand Skills**: SQL is also the most demanded skill in the data analyst job market, thus making it essential for job seekers.
4. **Skills with Higher Salaries**: Specialized skills, such as SVN and Solidity, are associated with the highest average salaries, indicating a premium on niche expertise.
5. **Optimal Skills for Job Market Value**: SQL leads in demand and offers for a high average salary, positioning it as one of the most optimal skills for data analysts to learn to maximize their market value.

### Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysts can better position themselves in a competitive job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continuous learning and adaptation to emerging trends in the field of data analytics.



