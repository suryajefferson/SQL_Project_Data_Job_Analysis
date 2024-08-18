
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