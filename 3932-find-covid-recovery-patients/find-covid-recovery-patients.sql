WITH first_positive AS (
    SELECT
        patient_id,
        MIN(test_date) AS first_positive_date
    FROM covid_tests
    WHERE result = 'Positive'
    GROUP BY patient_id
),
first_negative_after AS (
    SELECT
        c.patient_id,
        MIN(c.test_date) AS first_negative_date
    FROM covid_tests c
    INNER JOIN first_positive fp
        ON c.patient_id = fp.patient_id
        AND c.test_date > fp.first_positive_date
    WHERE c.result = 'Negative'
    GROUP BY c.patient_id
)
SELECT
    p.patient_id,
    p.patient_name,
    p.age,
    DATEDIFF(fna.first_negative_date, fp.first_positive_date) AS recovery_time
FROM patients p
INNER JOIN first_positive fp
    ON p.patient_id = fp.patient_id
INNER JOIN first_negative_after fna
    ON p.patient_id = fna.patient_id
ORDER BY
    recovery_time ASC,
    p.patient_name ASC;