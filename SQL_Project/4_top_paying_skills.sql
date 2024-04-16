/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, particurlarly in india
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/


SELECT  
    skills, 
    ROUND(AVG(salary_year_avg), 1) AS avg_salary,
    count(job_postings_fact.job_id) AS no_of_jobs
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id  = skills_job_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_location LIKE '%India' AND
    salary_year_avg IS NOT NULL
GROUP BY skills
HAVING 
    count(job_postings_fact.job_id) > 10
ORDER BY 
    avg_salary DESC
LIMIT 25;