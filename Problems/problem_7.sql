--find the no of jobs available based on skills in remote category 
WITH temporay_skill_job_dim AS (
    SELECT job_id,
    skill_id 
    FROM skills_job_dim
),
    temporay_job_postings_fact AS (
    SELECT job_id,
    job_location
    FROM job_postings_fact
    WHERE job_location = 'Anywhere'
)
SELECT 
    count (temporay_job_postings_fact.job_id) AS no_of_jobs,
    skills_dim.skills,
    temporay_job_postings_fact.job_location
FROM skills_dim
LEFT JOIN temporay_skill_job_dim ON temporay_skill_job_dim.skill_id = skills_dim.skill_id
LEFT JOIN temporay_job_postings_fact ON temporay_job_postings_fact.job_id = temporay_skill_job_dim.job_id
GROUP BY skills_dim.skills, temporay_job_postings_fact.job_location
ORDER BY no_of_jobs DESC
LIMIT 5 ;