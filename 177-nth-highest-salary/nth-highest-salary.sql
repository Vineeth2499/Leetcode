CREATE FUNCTION getNthHighestSalary(n INT)
RETURNS INT
BEGIN
    RETURN (
        SELECT salary
        FROM (
            SELECT
                salary,
                DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
            FROM Employee
        ) salary_rnk
        WHERE rnk = n
        LIMIT 1
    );
END