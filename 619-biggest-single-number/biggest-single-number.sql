WITH single_number AS(
    SELECT num,
           COUNT(num) AS num_cnt
    FROM MyNumbers
    GROUP BY num
)
SELECT MAX(num) AS num
FROM single_number
WHERE num_cnt = 1;