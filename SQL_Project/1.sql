WITH company_details AS(
    SELECT company_id,
        name,
        link
    FROM company_dim
),

    job_details AS (
    SELECT job_id, job_title_short,company_id, salary_year_avg 
    FROM job_postings_fact
    WHERE job_title_short = 'Data Analyst' 
        AND salary_year_avg IS NOT NULL
        AND job_work_from_home = TRUE
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT 
    job_title_short,
    company_details.name,
    salary_year_avg,
    company_details.link
FROM job_details
LEFT JOIN company_details ON company_details.company_id = job_details.company_id;
