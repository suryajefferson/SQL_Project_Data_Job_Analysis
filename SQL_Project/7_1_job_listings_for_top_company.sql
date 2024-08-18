with top_company AS (
    SELECT count(job_id) AS no_of_jobs,
    job_postings_fact.company_id AS hhh,
    name
    FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_location like '%India%'
        AND (job_title_short = 'Data Analyst' OR job_title_short = 'Data Engineer')
        AND salary_year_avg IS NOT NULL
    GROUP BY job_postings_fact.company_id,name
    ORDER BY no_of_jobs DESC
    LIMIT 1)

SELECT job_postings_fact.company_id,name, job_title, salary_year_avg, job_location 
FROM job_postings_fact
LEFT JOIN top_company ON top_company.hhh = job_postings_fact.company_id
WHERE company_id = (SELECT hhh FROM top_company)
    AND job_location like '%India%'
    AND (job_title_short = 'Data Analyst' OR job_title_short = 'Data Engineer')
    AND salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC;