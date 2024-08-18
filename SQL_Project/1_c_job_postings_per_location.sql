SELECT 
    COUNT (job_id) AS no_of_jobs,
    CASE
        WHEN job_country = 'India' THEN 'India'
        WHEN job_location = 'Anywhere' THEN 'Work from Home'
        ELSE 'Foreign Country'
    END AS jobs_in
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY 
    jobs_in
ORDER BY no_of_jobs DESC;