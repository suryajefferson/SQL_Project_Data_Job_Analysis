SELECT 
    count(job_id) AS no_of_jobs,
    CASE 
        WHEN EXTRACT(MONTH FROM job_posted_date) BETWEEN 1  AND 3  THEN 'Q1' 
        WHEN EXTRACT(MONTH FROM job_posted_date) BETWEEN 4  AND 6  THEN 'Q2' 
        WHEN EXTRACT(MONTH FROM job_posted_date) BETWEEN 7  AND 9  THEN 'Q3' 
        WHEN EXTRACT(MONTH FROM job_posted_date) BETWEEN 10 AND 12 THEN 'Q4' 
        ELSE 'others'
    END AS Quarter
FROM 
    job_postings_fact
WHERE 
        job_title_short = 'Data Analyst' 
    AND EXTRACT(YEAR FROM job_posted_date) = 2023
GROUP BY 
    Quarter;