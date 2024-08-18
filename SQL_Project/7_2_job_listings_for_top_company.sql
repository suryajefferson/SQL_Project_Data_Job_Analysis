
WITH detais AS (
    SELECT 
        COUNT(job_postings_fact.company_id) AS no_of_jobs_by_company,
        job_postings_fact.company_id
    FROM 
        job_postings_fact
    WHERE 
        job_location LIKE '%India%' 
        AND (job_title_short = 'Data Analyst' OR job_title_short = 'Data Engineer')
        AND salary_year_avg IS NOT NULL
    GROUP BY 
        job_postings_fact.company_id
),
top_company AS (
    SELECT 
        company_dim.name,
        detais.company_id,
        detais.no_of_jobs_by_company
    FROM 
        detais
    LEFT JOIN 
        company_dim ON company_dim.company_id = detais.company_id
    ORDER BY 
        detais.no_of_jobs_by_company DESC
    LIMIT 1
)
SELECT 
    company_dim.company_id,
    top_company.name,
    job_postings_fact.job_title,
    job_postings_fact.job_location,
    job_postings_fact.salary_year_avg
FROM 
    company_dim
LEFT JOIN 
    job_postings_fact ON company_dim.company_id = job_postings_fact.company_id
INNER JOIN 
    top_company ON company_dim.company_id = top_company.company_id
WHERE 
    job_postings_fact.job_location LIKE '%India%' 
    AND (job_postings_fact.job_title_short = 'Data Analyst' OR job_postings_fact.job_title_short = 'Data Engineer')
    AND salary_year_avg IS NOT NULL;