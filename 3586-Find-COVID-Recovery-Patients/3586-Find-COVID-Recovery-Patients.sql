SELECT
   p.patient_id,
   patient_name,
   age,
   MAX(CASE WHEN result = 'Negative' THEN test_date END) -
   MAX(CASE WHEN result = 'Positive' THEN test_date END) AS recovery_time
FROM
   patients p
LEFT JOIN
   covid_tests c ON p.patient_id = c.patient_id
GROUP BY
   1,
   2,
   3
HAVING
   recovery_time IS NOT NULL
ORDER BY
   recovery_time ASC, 1 ASC
