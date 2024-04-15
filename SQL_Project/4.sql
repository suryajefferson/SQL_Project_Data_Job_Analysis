-- top paying skills
-- cloumns must have = salary_year_avg, skills,
-- coumns might not must = job_title, job_location 

SELECT  
    skills, 
    ROUND(AVG(salary_year_avg), 1) AS avg_salary
FROM 
    job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id  = skills_job_dim.skill_id
WHERE 
    salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY 
    avg_salary DESC
LIMIT 100;