SELECT 
    skills, 
    count(job_postings_fact.job_id) AS no_of_jobs,
    round(avg(salary_year_avg), 0) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
    salary_year_avg IS NOT NULL
GROUP BY 
    skills
ORDER BY 
    no_of_jobs DESC,
    avg_salary DESC
LIMIT 25;
