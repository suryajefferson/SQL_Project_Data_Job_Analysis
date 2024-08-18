# Introduction
Welcome to an in-depth exploration of the data job market, with a focus on data analyst roles. This project examines the highest-paying jobs, the most sought-after skills, and where high demand intersects with high salaries in the field of data analytics.

Interested in the SQL queries used in this project? You can find them here: [project_sql folder](/SQL_Project/)

This project was developed to help better understand the data analyst job market, with the goal of identifying top-paying and in-demand skills. The data used in this analysis provides valuable insights into job titles, salaries, locations, and essential skills, helping others streamline their job search in the data analytics field.

# The Questions
### The questions I wanted to answer through my SQL queries were:

1. **Finding the number of job postings:**
    - a. per job title
    - b. for data analyst roles in India per quarter in 2023
    - c. for data analyst roles per location

2. **What are the top-paying data analyst jobs?**

3. **What skills are required for these top-paying jobs?**

4. **What skills are most in demand for data analysts?**

5. **Which skills are associated with higher salaries?**

6. **What are the most optimal skills to learn?**

7. **Retrieving job listings from the company with the most openings for data analyst and data engineer roles**

# Tools I Used
For my detailed study of the data analyst job market, I used several important tools:

- **SQL**: The main tool for querying the database and finding key insights.
- **PostgreSQL**: The database system I used to manage the job posting data.
- **Visual Studio Code**: My preferred tool for managing the database and running SQL queries.
- **Git & GitHub**: Crucial for version control and sharing my SQL scripts and analysis, enabling collaboration and tracking.

# About the Data
The data consists of four tables:

1. **jobs_postings_fact**: This table provides information about job postings, including job name, job ID, company ID, location, annual salary, and schedule type.

2. **company_dim**: This table includes details about companies, such as company name, company ID, and company link.

3. **skills_job_dim**: This table links job IDs to skill IDs, facilitating the joining of data between the job postings table and the skills table.

4. **skills_dim**: This table contains comprehensive information about skills, including skill ID, skill name, and skill type.

# Database Setup: Schema Design and Data Insertion
## Schema Design
**Primary Keys**

1. `job_id` is the PRIMARY KEY in the **jobs_postings_fact** table.
2. `company_id` is the PRIMARY KEY in the **company_dim** table.
3. `job_id` and `skill_id` are the PRIMARY KEYS in the **skills_job_dim** table.
4. `skill_id` is the PRIMARY KEY in the **skills_dim** table.

**Foreign Keys**

1. `company_id` is the FOREIGN KEY in the **jobs_postings_fact** table.
2. `job_id` and `skill_id` are the FOREIGN KEYS in the **skills_job_dim** table.

## Creating the Database
### **Code**
``` sql
CREATE DATABASE sql_project;
```
## Creating Tables
### **Code**
<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Code</span></summary>

``` sql
-- Create company_dim table with primary key
CREATE TABLE public.company_dim
(
    company_id INT PRIMARY KEY,
    name TEXT,
    link TEXT,
    link_google TEXT,
    thumbnail TEXT
);

-- Create skills_dim table with primary key
CREATE TABLE public.skills_dim
(
    skill_id INT PRIMARY KEY,
    skills TEXT,
    type TEXT
);

-- Create job_postings_fact table with primary key
CREATE TABLE public.job_postings_fact
(
    job_id INT PRIMARY KEY,
    company_id INT,
    job_title_short VARCHAR(255),
    job_title TEXT,
    job_location TEXT,
    job_via TEXT,
    job_schedule_type TEXT,
    job_work_from_home BOOLEAN,
    search_location TEXT,
    job_posted_date TIMESTAMP,
    job_no_degree_mention BOOLEAN,
    job_health_insurance BOOLEAN,
    job_country TEXT,
    salary_rate TEXT,
    salary_year_avg NUMERIC,
    salary_hour_avg NUMERIC,
    FOREIGN KEY (company_id) REFERENCES public.company_dim (company_id)
);

-- Create skills_job_dim table with a composite primary key and foreign keys
CREATE TABLE public.skills_job_dim
(
    job_id INT,
    skill_id INT,
    PRIMARY KEY (job_id, skill_id),
    FOREIGN KEY (job_id) REFERENCES public.job_postings_fact (job_id),
    FOREIGN KEY (skill_id) REFERENCES public.skills_dim (skill_id)
);

-- Set ownership of the tables to the postgres user
ALTER TABLE public.company_dim OWNER to postgres;
ALTER TABLE public.skills_dim OWNER to postgres;
ALTER TABLE public.job_postings_fact OWNER to postgres;
ALTER TABLE public.skills_job_dim OWNER to postgres;

-- Create indexes on foreign key columns for better performance
CREATE INDEX idx_company_id ON public.job_postings_fact (company_id);
CREATE INDEX idx_skill_id ON public.skills_job_dim (skill_id);
CREATE INDEX idx_job_id ON public.skills_job_dim (job_id);
```

</details>

## Schema Diagram
![figure](/SQL_Project_Data_Job_Analysis/Images/Schema%20Diagram.png)
## Loading the Data
- In PostgresSQL > PgAdmin4 > PSQL Tool, using these commands to insert data from csv files to database
### **Code**
<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Code</span></summary>

``` sql

\copy job_postings_fact FROM 'D:\SQL\Practice\csv_files\job_postings_fact.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy company_dim FROM 'D:\SQL\Practice\csv_files\company_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_job_dim FROM 'D:\SQL\Practice\csv_files\skills_job_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy skills_dim FROM 'D:\SQL\Practice\csv_files\skills_dim.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

```

</details>

# Anslysis
## 1
### **a**. Finding the number of job postings per job title

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Detailed Question</span></summary>

- **Question:** How many job postings are there per job title?
- **Details:**
    - Count the number of job postings for each job title.
- **Why?** This provides an overview of the distribution of job postings across different job titles, helping to understand which roles are most frequently posted.
</details>

### **Code**

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Code</span></summary>

``` sql
SELECT 
    job_title_short,
    count(job_id) AS no_of_jobs
FROM 
    job_postings_fact
GROUP BY 
    job_title_short
ORDER BY 
    no_of_jobs DESC;
```
</details>

### **Results and Insights**

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Results</span></summary>

| job_title_short | no_of_jobs |
| --- | --- |
| Data Analyst | 196593 |
| Data Engineer | 186679 |
| Data Scientist | 172726 |
| Business Analyst | 49160 |
| Software Engineer | 45019 |
| Senior Data Engineer | 44692 |
| Senior Data Scientist | 37076 |
| Senior Data Analyst | 29289 |
| Machine Learning Engineer | 14106 |
| Cloud Engineer | 12346 |
</details>
<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Insights</span></summary>

**High Demand For Data Roles:**

- *Data Analyst* has the highest demand with nearly 200k jobs, followed by *Data Engineer* and *Data Scientist* roles, each exceeding 170k openings.

**Senior-Level Demand:**

- Senior roles, like *Senior Data Engineer* and *Senior Data Scientist*, have fewer openings but still significant, indicating a need for experienced professionals.

**Emerging Tech:**

- Roles like *Machine Learning Engineer* and *Cloud Engineer* are in demand, though specialized, reflecting a focus on advanced technologies.

**Business And Software:**

- *Business Analyst* and *Software Engineer* roles show the integration of business strategy and software development in data-driven environments.



</details>

### **b**. Finding the number of job postings for ‘Data Analyst’ in India per Quarter in 2023
<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Detailed Question</span></summary>


- **Question:** How many job postings for ‘Data Analyst’ were there in India per quarter in 2023?
- **Details:**
    - Find the number of job postings for *Data Analyst* in India, broken down by quarter for the year 2023.
- **Why?** This helps analyze trends in job postings for *Data Analyst* roles throughout the year, providing insights into seasonal hiring patterns.

</details>

### **Code**

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Code</span></summary>

``` sql
SELECT 
    count(job_id) AS no_of_jobs,
    CASE 
        WHEN EXTRACT(MONTH FROM job_posted_date) BETWEEN 1  AND 3  THEN 'Q1' 
        WHEN EXTRACT(MONTH FROM job_posted_date) BETWEEN 4  AND 6  THEN 'Q2' 
        WHEN EXTRACT(MONTH FROM job_posted_date) BETWEEN 7  AND 9  THEN 'Q3' 
        WHEN EXTRACT(MONTH FROM job_posted_date) BETWEEN 10 AND 12 THEN 'Q4' 
        ELSE 'others'
    END AS Quarter
FROM 
    job_postings_fact
WHERE 
        job_title_short = 'Data Analyst' 
    AND EXTRACT(YEAR FROM job_posted_date) = 2023
GROUP BY 
    Quarter;
```

</details>

### **Results and Insights**

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Results</span></summary>

| no_of_jobs | quarter |
| --- | --- |
| 56518 | Q1 |
| 44888 | Q2 |
| 49749 | Q3 |
| 44953 | Q4 |

</details>

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Insights</span></summary>

**Job distribution throughout the year:**

- *Q1* has the highest number of jobs with 56,518 openings, indicating a strong start to the year.
- *Q3* follows with 49,749 jobs, showing a notable mid-year peak.
- *Q2* and *Q4* have slightly lower job numbers, with 44,888 and 44,953 openings respectively, suggesting a decrease towards the end of the year.

</details>

### **c**. Finding the no of job postings for ‘Data Analyst’ per location

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Detailed Question</span></summary>


- **Question:** How many job postings for ‘Data Analyst’ are there per location?
- **Details:**
    - Count the number of job postings for *Data Analyst* roles by location.
- **Why?** This provides insight into geographical demand for *Data Analyst* roles, helping job seekers understand where opportunities are concentrated.

</details>

### **Code**

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Code</span></summary>

``` sql
SELECT 
    COUNT (job_id) AS no_of_jobs,
    CASE
        WHEN job_country = 'India' THEN 'India'
        WHEN job_location = 'Anywhere' THEN 'Work from Home'
        ELSE 'Foreign Country'
    END AS jobs_in
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY 
    jobs_in
ORDER BY no_of_jobs DESC;
```

</details>

### **Results and Insights**

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Results</span></summary>

| no_of_jobs | jobs_in |
| --- | --- |
| 178179 | Foreign Country |
| 12281 | Work from Home |
| 6133 | India |

</details>

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;"> Insights </span></summary>

**Job Distribution By Location:**

- *Foreign Country* has the highest number of jobs with 178,179 openings, indicating a significant demand for roles outside of India.
- *Work from Home* opportunities follow with 12,281 jobs, reflecting the growing trend of remote work.
- *India* has the lowest number of job openings with 6,133, suggesting a smaller, but still notable, demand for local positions.


</details>

## 2
### Top 10 highest paying data analyst job details with company names in India or work from home 

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.15em;">Detailed Question </span></summary>


- **Question:** What are the top-paying Data Analyst jobs?
- **Details:**
    - Identify the top 10 highest-paying *Data Analyst* roles available either in India or remotely.
    - Focus on job postings with specified salaries (remove nulls).
    - Include the company names of the top 10 roles.
- **Why?** Highlight the top-paying opportunities for *Data Analysts*, offering insights into employment options and location flexibility.

</details>

### **Code**

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Code</span></summary>

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

### **Results and Insights**

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.15em;">Results</span></summary>

| job_id | job_title | salary_year_avg | company | job_location | job_schedule_type | job_posted_date |
| --- | --- | --- | --- | --- | --- | --- |
| 226942 | Data Analyst | 650000.0 | Mantys | Anywhere | Full-time | 2023-02-20 15:13:33 |
| 547382 | Director of Analytics | 336500.0 | Meta | Anywhere | Full-time | 2023-08-23 12:04:42 |
| 552322 | Associate Director- Data Insights | 255829.5 | AT&T | Anywhere | Full-time | 2023-06-18 16:03:12 |
| 99305 | Data Analyst, Marketing | 232423.0 | Pinterest Job Advertisements | Anywhere | Full-time | 2023-12-05 20:00:40 |
| 1021647 | Data Analyst (Hybrid/Remote) | 217000.0 | Uclahealthcareers | Anywhere | Full-time | 2023-01-17 00:17:23 |
| 168310 | Principal Data Analyst (Remote) | 205000.0 | SmartAsset | Anywhere | Full-time | 2023-08-09 11:00:01 |
| 731368 | Director, Data Analyst - HYBRID | 189309.0 | Inclusively | Anywhere | Full-time | 2023-12-07 15:00:13 |
| 310660 | Principal Data Analyst, AV Performance Analysis | 189000.0 | Motional | Anywhere | Full-time | 2023-01-05 00:00:25 |
| 1749593 | Principal Data Analyst | 186000.0 | SmartAsset | Anywhere | Full-time | 2023-07-11 16:00:05 |
| 387860 | ERM Data Analyst | 184000.0 | Get It Recruit - Information Technology | Anywhere | Full-time | 2023-06-09 08:01:04 |

</details>

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.15em;">Insights </span></summary>


**Highest Salaries:**

- *Data Analyst* roles have the highest salary at 650,000, indicating premium compensation for these positions.

**Notable Positions:**

- *Director Of Analytics* at Meta offers a substantial salary of 336,500, showing a high-value role in a prominent company.
- *Associate Director - Data Insights* at AT&T also commands a high salary of 255,829.5.

**Recent Postings:**

- Most job postings are recent, with dates ranging from January 2023 to December 2023, suggesting active hiring in the data field.



</details>

## 3
### Top 10 highest paying Data Analyst jobs in India or work form home with required skills

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Detailed Question</span></summary>


- **Question:** What skills are required for the top-paying data analyst jobs?
- **Details:**
    - Use the top 10 highest-paying *Data Analyst* jobs from the first query.
    - Add the specific skills required for these roles.
- **Why?** It provides a detailed look at which high-paying jobs demand certain skills, helping job seekers understand which skills to develop that align with top salaries.

</details>

### **Code**

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Code</span></summary>

``` sql
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

### **Results and Insights**

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Results</span></summary>

| job_id | job_title | salary_year_avg | company | job_location | skills |
| --- | --- | --- | --- | --- | --- |
| 552322 | Associate Director- Data Insights | 255829.5 | AT&T | Anywhere | sql, python, r, azure, databricks, aws, pandas, pyspark, jupyter, excel, tableau, power bi, powerpoint |
| 99305 | Data Analyst, Marketing | 232423.0 | Pinterest Job Advertisements | Anywhere | sql, python, r, hadoop, tableau |
| 1021647 | Data Analyst (Hybrid/Remote) | 217000.0 | Uclahealthcareers | Anywhere | sql, crystal, oracle, tableau, flow |
| 168310 | Principal Data Analyst (Remote) | 205000.0 | SmartAsset | Anywhere | sql, python, go, snowflake, pandas, numpy, excel, tableau, gitlab |
| 731368 | Director, Data Analyst - HYBRID | 189309.0 | Inclusively | Anywhere | sql, python, azure, aws, oracle, snowflake, tableau, power bi, sap, jenkins, bitbucket, atlassian, jira, confluence |
| 310660 | Principal Data Analyst, AV Performance Analysis | 189000.0 | Motional | Anywhere | sql, python, r, git, bitbucket, atlassian, jira, confluence |
| 1749593 | Principal Data Analyst | 186000.0 | SmartAsset | Anywhere | sql, python, go, snowflake, pandas, numpy, excel, tableau, gitlab |
| 387860 | ERM Data Analyst | 184000.0 | Get It Recruit - Information Technology | Anywhere | sql, python, r |

</details>

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Insights</span></summary>


**High-Paying Skills:**

- *Associate Director - Data Insights* roles require a broad skill set including *SQL*, *Python*, *R*, and advanced tools like *Azure*, *Databricks*, *AWS*, *Pandas*, and *PySpark*.

**Common Tools:**

- *Tableau* and *Excel* are frequently listed, indicating their importance across various data analyst roles.

**Specialized Skills:**

- Roles such as *Data Analyst (Hybrid/Remote)* and *Director, Data Analyst - Hybrid* show a need for niche skills like *Crystal*, *Oracle*, *Snowflake*, and *Flow*.



</details>

## 4
### Top 5 demanded skills for Data Analyst jobs all over the world based on no of jobs

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Detailed Question</span></summary>

- **Question:** What are the most in-demand skills for data analysts?
- **Details:**
    - Join job postings to an inner join table similar to query 2.
    - Identify the top 5 in-demand skills for a *Data Analyst*.
    - Focus on all job postings.
- **Why?** Retrieves the top 5 skills with the highest demand in the job market, providing insights into the most valuable skills for job seekers.

</details>

### **Code**

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Code</span></summary>

``` sql 
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

### **Results and Insights**
<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Results</span></summary>

| skills | no_of_jobs | avg_salary |
| --- | --- | --- |
| sql | 92628 | 96435.33 |
| excel | 67031 | 86418.90 |
| python | 57326 | 101511.85 |
| tableau | 46554 | 97978.08 |
| power bi | 39468 | 92323.60 |

</details>

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Insights</span></summary>

**Top Skills For Data Analysts:**

- *SQL* is the most common skill with 92,628 job postings and an average salary of 96,435.33.
- *Excel* is also widely used with 67,031 job postings, though it has a lower average salary of 86,418.90 compared to *SQL*.
- *Python* has a high average salary of 101,511.85, despite having fewer job postings (57,326).
- *Tableau* and *Power BI* are important skills with average salaries of 97,978.08 and 92,323.60 respectively.

</details>

## 5
### Top 10 paying skills  for all jobs, all over the world  based on salary (skills with min of at least 100 jobs)

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Detailed Question</span></summary>


- **Question:** What are the top skills based on salary?
- **Details:**
    - Look at the average salary associated with each skill for all positions.
    - Focus on roles with specified salaries, particularly in India.
- **Why?** It reveals how different skills impact salary levels for different jobs and helps identify the most financially rewarding skills to acquire or improve.

</details>

### **Code**

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Code</span></summary>

``` sql
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
LIMIT 10;
```

</details>

### **Results and Insights**

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Results</span></summary>

| skills | avg_salary | no_of_jobs |
| --- | --- | --- |
| mongo | 170714.9 | 262 |
| cassandra | 154124.3 | 530 |
| neo4j | 147707.9 | 123 |
| scala | 145119.5 | 1912 |
| kafka | 144753.8 | 1642 |
| pytorch | 144470.1 | 1081 |
| shell | 143370.2 | 731 |
| golang | 143138.7 | 109 |
| airflow | 142385.8 | 1506 |
| tensorflow | 142370.3 | 1225 |

</details>

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Insights</span></summary>

**High-Paying Specialized Skills:**

- *Mongo* has the highest average salary at 170,714.9, with fewer job postings (262), indicating a premium for this skill.
- *Cassandra* also commands a high salary of 154,124.3 with 530 job postings, showing strong demand.
- *Neo4j* and *Golang* have high salaries but fewer job postings, suggesting niche areas with high compensation.

**Widely Used Skills:**

- *Scala*, *Kafka*, and *PyTorch* are in high demand with substantial job postings (1912, 1642, and 1081, respectively) and competitive salaries.
- *Airflow* and *TensorFlow* are prominent in the data space, with average salaries around 142,000 and significant job postings.


</details>

## 6
### Top 10 optimal skills for Data Analyst In india (optimal = high demand + high avg salary)
<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Detailed Question </span></summary>


- **Question:** What are the most valuable skills to learn that are both in high demand and associated with high salaries?
- **Details:**
    - Identify skills that are highly sought after and linked to high average salaries for *Data Analyst* roles.
    - Focus specifically on roles in India with defined salary ranges.
- **Why?** Understanding these skills can guide career development by ensuring job security and maximizing financial benefits in the data analysis field.

</details>

### **Code**
<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Code</span></summary>

``` sql
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

### **Results and Insights**

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Results</span></summary>

| skills | no_of_jobs | avg_salary |
| --- | --- | --- |
| sql | 46 | 92984 |
| excel | 39 | 88519 |
| python | 36 | 95933 |
| tableau | 20 | 95103 |
| r | 18 | 86609 |
| power bi | 17 | 109832 |
| azure | 15 | 98570 |
| aws | 12 | 95333 |
| spark | 11 | 118332 |
| oracle | 11 | 104260 |

</details>

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Insights </span></summary>

**High-Paying Skills With Fewer Job Postings:**

- *Spark* has the highest average salary at 118,332, despite having only 11 job postings, indicating a high demand for this skill in a smaller job market.
- *Power BI* and *Oracle* also offer high salaries with fewer job postings, suggesting that specialized skills can command higher compensation.

**Common Skills:**

- *SQL*, *Excel*, and *Python* are more common, with a decent number of job postings and competitive salaries.
- *Azure* and *AWS* have high average salaries and are important for cloud-based roles, but have fewer job postings compared to more common skills.


</details>

## 7
### Find the company with highest job postings in india for data analyst and data engineer and get the details of all job postings offered by that company

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Detailed Question </span></summary>

- **Question:** Find the company with the highest job postings in India for Data Analyst and Data Engineer roles, and get the details of all job postings offered by that company.
- **Details:**
    - Identify the company with the most job postings for *Data Analyst* and *Data Engineer* roles in India.
    - Retrieve all job postings by this company, including job title, salary, and location.
- **Why?** This provides insight into the leading employer in the data analytics and engineering field in India, helping job seekers target companies with the most opportunities in these roles.

</details>

### **Code**

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Method 1</span></summary>

``` sql
with top_company AS (
    SELECT count(job_id) AS no_of_jobs,
    job_postings_fact.company_id AS hhh,
    name
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_location like '%India%'
        AND (job_title_short = 'Data Analyst' OR job_title_short = 'Data Engineer')
        AND salary_year_avg IS NOT NULL
    GROUP BY job_postings_fact.company_id,name
    ORDER BY no_of_jobs DESC
    LIMIT 1)

SELECT job_postings_fact.company_id,name, job_title, salary_year_avg, job_location 
FROM job_postings_fact
LEFT JOIN top_company ON top_company.hhh = job_postings_fact.company_id
WHERE company_id = (SELECT hhh FROM top_company)
    AND job_location like '%India%'
    AND (job_title_short = 'Data Analyst' OR job_title_short = 'Data Engineer')
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC;
```
</details>

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Method 2</span></summary>

``` sql 
WITH detais AS (
    SELECT 
        COUNT(job_postings_fact.company_id) AS no_of_jobs_by_company,
        job_postings_fact.company_id
    FROM 
        job_postings_fact
    WHERE 
        job_location LIKE '%India%' 
        AND (job_title_short = 'Data Analyst' OR job_title_short = 'Data Engineer')
        AND salary_year_avg IS NOT NULL
    GROUP BY 
        job_postings_fact.company_id
),
top_company AS (
    SELECT 
        company_dim.name,
        detais.company_id,
        detais.no_of_jobs_by_company
    FROM 
        detais
    LEFT JOIN 
        company_dim ON company_dim.company_id = detais.company_id
    ORDER BY 
        detais.no_of_jobs_by_company DESC
    LIMIT 1
)
SELECT 
    company_dim.company_id,
    top_company.name,
    job_postings_fact.job_title,
    job_postings_fact.job_location,
    job_postings_fact.salary_year_avg
FROM 
    company_dim
LEFT JOIN 
    job_postings_fact ON company_dim.company_id = job_postings_fact.company_id
INNER JOIN 
    top_company ON company_dim.company_id = top_company.company_id
WHERE 
    job_postings_fact.job_location LIKE '%India%' 
    AND (job_postings_fact.job_title_short = 'Data Analyst' OR job_postings_fact.job_title_short = 'Data Engineer')
    AND salary_year_avg IS NOT NULL;
```
</details>

### **Results and Insights**

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Results</span></summary>

| company_id | name | job_title | salary_year_avg | job_location |
| --- | --- | --- | --- | --- |
| 210 | Visa | Sr. Data Engineer | 249000.0 | Bengaluru, Karnataka, India |
| 210 | Visa | Sr. Cybersecurity Engineer (Hadoop Data engineering-Hadoop...) | 161160.0 | Bengaluru, Karnataka, India |
| 210 | Visa | Sr Data Engineer | 156000.0 | Bengaluru, Karnataka, India |
| 210 | Visa | Sr Cybersecurity Engineer - Hadoop Data Engineering | 147500.0 | Bengaluru, Karnataka, India |
| 210 | Visa | Manager, Data Engineering | 147500.0 | Bengaluru, Karnataka, India |
| 210 | Visa | Sr Data Engineer | 147500.0 | Bengaluru, Karnataka, India |
| 210 | Visa | Staff Data Engineer (Kafka, Java) | 147500.0 | Bengaluru, Karnataka, India |
| 210 | Visa | Staff Data Engineer - Full Stack | 147500.0 | Bengaluru, Karnataka, India |
| 210 | Visa | Sr. Data Engineer | 147500.0 | Bengaluru, Karnataka, India |
| 210 | Visa | Data Engineer - Sr. Consultant level | 147500.0 | Bengaluru, Karnataka, India |
| 210 | Visa | Staff Data Engineer – Analytics | 147500.0 | Bengaluru, Karnataka, India |
| 210 | Visa | Staff Data Engineer (Spark, Python, Hadoop) | 147500.0 | Bengaluru, Karnataka, India |
| 210 | Visa | Staff Data Engineer - Big Data | 147500.0 | Bengaluru, Karnataka, India |
| 210 | Visa | Sr. Data Engineer | 147500.0 | Bengaluru, Karnataka, India |
| 210 | Visa | Sr. Data Engineer - Test Automation(QA) | 147500.0 | Bengaluru, Karnataka, India |
| 210 | Visa | Staff Data Engineer - Spark, Scala | 147500.0 | Bengaluru, Karnataka, India |
| 210 | Visa | Lead Data Engineer | 131580.0 | Bengaluru, Karnataka, India |
| 210 | Visa | Lead Data Engineer | 131580.0 | Bengaluru, Karnataka, India |
| 210 | Visa | Principal Data Engineer | 93600.0 | Bengaluru, Karnataka, India |
| 210 | Visa | Staff Data Engineer | 79200.0 | Bengaluru, Karnataka, India |
| 210 | Visa | Financial Data Analyst | 79200.0 | Bengaluru, Karnataka, India |
| 210 | Visa | Staff Data Engineer | 79200.0 | Bengaluru, Karnataka, India |

</details>

<details>
<summary style="font-size: 1.em;">click for <span style="font-size: 1.45em;">Insights</span></summary>

**High Salaries:**

- *Sr. Data Engineer* roles at *Visa* in Bengaluru offer the highest average salary of 249,000.0, reflecting the premium for this position.

**Consistent Salaries:**

- Many roles, including *Staff Data Engineer* and *Sr. Data Engineer*, show a consistent salary of 147,500.0, indicating a standard compensation level for these positions.

**Lower Salaries:**

- *Principal Data Engineer* and *Financial Data Analyst* roles have comparatively lower salaries, with the *Principal Data Engineer* earning 93,600.0 and *Financial Data Analyst* earning 79,200.0.

</details>

# Overall Insights
**Job Demand**

- **High Demand For Data Roles**
  <span style="font-size:14px;">*Data Analyst* tops demand with ~200k jobs, followed by *Data Engineer* and *Data Scientist* with 170k+ each.</span>

- **Senior-Level Demand**
  <span style="font-size:14px;">Senior roles like *Senior Data Engineer* and *Senior Data Scientist* have fewer openings but are still in demand.</span>

- **Emerging Tech**
  <span style="font-size:14px;">*Machine Learning Engineer* and *Cloud Engineer* roles are growing, focusing on advanced tech.</span>

- **Business And Software**
  <span style="font-size:14px;">*Business Analyst* and *Software Engineer* roles highlight the blend of business strategy and software development.</span>

**Job Distribution**

- **Job Distribution Throughout the Year**
  <span style="font-size:14px;">*Q1* leads with 56,518 jobs; *Q3* follows (49,749). *Q2* and *Q4* have fewer openings.</span>

- **Job Distribution By Location**
  <span style="font-size:14px;">*Foreign Countries* have the most jobs (178,179), *Work from Home* follows (12,281), while *India* has the fewest (6,133).</span>

**Salaries**

- **Highest Salaries**
  <span style="font-size:14px;">*Data Analyst* roles offer the highest salary (650,000). Notable high salaries include *Director Of Analytics* at Meta (336,500) and *Associate Director* at AT&T (255,829.5).</span>

- **High Salaries**
  <span style="font-size:14px;">*Sr. Data Engineer* at *Visa* offers the highest salary (249,000).</span>

- **Consistent Salaries**
  <span style="font-size:14px;">*Staff Data Engineer* and *Sr. Data Engineer* have a consistent salary (147,500).</span>

- **Lower Salaries**
  <span style="font-size:14px;">*Principal Data Engineer* and *Financial Data Analyst* have lower salaries (93,600 and 79,200, respectively).</span>

**Skills**

- **High-Paying Skills**
  <span style="font-size:14px;">*Associate Director - Data Insights* requires skills like *SQL*, *Python*, *R*, and advanced tools such as *Azure*, *Databricks*, *AWS*, *Pandas*, and *PySpark*.</span>

- **Top Skills For Data Analysts**
  <span style="font-size:14px;">*SQL* is most common with high salary (96,435.33). *Python* also offers a high salary (101,511.85).</span>

- **High-Paying Specialized Skills**
  <span style="font-size:14px;">*Mongo* has the highest salary (170,714.9), followed by *Cassandra* (154,124.3).</span>

- **High-Paying Skills With Fewer Job Postings**
  <span style="font-size:14px;">*Spark* has the highest average salary (118,332) but few postings. *Power BI* and *Oracle* also offer high salaries.</span>

- **Common Skills**
  <span style="font-size:14px;">*SQL*, *Excel*, and *Python* are prevalent. *Azure* and *AWS* have high salaries but fewer postings.</span>

- **Widely Used Skills**
  <span style="font-size:14px;">*Scala*, *Kafka*, and *PyTorch* are in high demand. *Airflow* and *TensorFlow* are also prominent.</span>

- **Specialized Skills**
  <span style="font-size:14px;">Niche roles need skills like *Crystal*, *Oracle*, *Snowflake*, and *Flow*.</span>

- **Common Tools**
  <span style="font-size:14px;">*Tableau* and *Excel* are widely used.</span>

# What I Learned in SQL from This Project

1. **Creating Tables**
   - Learned how to set up tables with IDs and data types.
   - Used foreign keys to link tables and keep data organized.

2. **Managing Data**
   - Inserted data into tables and changed table structures when needed.
   - Deleted tables when they were no longer needed.

3. **Improving Performance**
   - Created indexes to make data searches faster.

4. **Writing Queries**
   - Used `WHERE` to filter data based on conditions.
   - Used functions like `COUNT` and `AVG` to summarize and analyze data.
   - Extracted information from dates to sort and analyze by month or quarter.

5. **Advanced SQL**
   - Used CTEs to make complex queries easier to read.
   - Joined tables to combine information and get detailed results.

6. **Data Analysis**
   - Created tables for data from specific months and used them for reports.
   - Identified popular skills and high-paying job roles.
   - Analyzed job postings to find out which companies are hiring and where.

This project taught me how to set up and manage databases, improve query performance, and analyze data effectively with SQL.

# Conclusion
This project has significantly expanded my skills in database management, performance optimization, and data analysis using sql. 

I learned how to create tables, manage data, and improve performance by creating indexes to speed up data searches.

I also became proficient in `where` clauses, `count`, `avg`, etc., for summarizing information.

For advanced SQL: i utilized common table expressions (ctes) for clearer complex queries and joined tables to consolidate information.

I observed great insights into the data job market like job demand, job distribution, salaries, skills, etc.

This project provided a comprehensive understanding of database setup, query performance, and data-driven insights into job trends and salaries in the data industry.


`End`
---
---