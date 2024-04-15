-- top skills for data analyst based on salary
-- skills, no of jobs, avg salary

SELECT 
    skills,
    count(job_postings_fact.job_id) AS no_of_jobs,
   -- CAST(AVG(CAST(salary_year_avg as DECIMAL(8,2))) AS DECIMAL(8,2))
    AVG(salary_year_avg) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    job_location LIKE '%India'
GROUP BY skills
ORDER BY no_of_jobs DESC
LIMIT 10;