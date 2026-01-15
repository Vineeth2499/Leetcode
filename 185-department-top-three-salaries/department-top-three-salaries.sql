WITH ranked_salary AS(
    SELECT
   d.name AS department,
   e.name AS employee,
   e.salary,
   DENSE_RANK() OVER(PARTITION BY d.name ORDER BY salary DESC) AS Salary_rank
FROM
   Employee e
JOIN
   Department d ON e.departmentid = d.id
)
SELECT
   department,
   employee,
   salary
FROM
   ranked_salary
WHERE
   Salary_rank <= 3