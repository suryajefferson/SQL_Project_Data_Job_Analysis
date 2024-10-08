
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