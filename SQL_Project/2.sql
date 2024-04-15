WITH job_company_details AS(
    SELECT 
        job_postings_fact.job_id,
        job_title_short,
        job_location,
        salary_year_avg,
        name AS company_name,
        link
    FROM 
        job_postings_fact
    LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
    WHERE 
        job_title_short = 'Data Analyst'
        AND (job_work_from_home = TRUE 
            or job_location like '%India')
        AND salary_year_avg IS NOT NULL
    ORDER BY 
        salary_year_avg DESC
    LIMIT 10
)
SELECT
    job_company_details. *,
   skills
FROM job_company_details
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_company_details.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
ORDER BY salary_year_avg DESC;