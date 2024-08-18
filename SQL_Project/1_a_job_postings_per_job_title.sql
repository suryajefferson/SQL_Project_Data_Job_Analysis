SELECT 
    job_title_short,
    count(job_id) AS no_of_jobs
FROM 
    job_postings_fact
GROUP BY 
    job_title_short
ORDER BY 
    no_of_jobs DESC;