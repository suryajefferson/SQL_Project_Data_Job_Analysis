
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