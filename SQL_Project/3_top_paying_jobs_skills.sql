
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