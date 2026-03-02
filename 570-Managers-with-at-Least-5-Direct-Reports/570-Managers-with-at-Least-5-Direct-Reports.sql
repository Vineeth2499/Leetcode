SELECT
  e.name
FROM
  Employee e
JOIN
  (SELECT
     managerid
   FROM
     Employee
   GROUP BY
     managerid
   HAVING
     COUNT(managerid) >= 5
   ) m ON
e.id = m.managerid
