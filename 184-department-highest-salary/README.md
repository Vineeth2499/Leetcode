<h2><a href="https://leetcode.com/problems/department-highest-salary">Department Highest Salary</a></h2> <img src='https://img.shields.io/badge/Difficulty-Medium-orange' alt='Difficulty: Medium' /><hr><p>Table: <code>Employee</code></p>

<pre>
+--------------+---------+
| Column Name  | Type    |
+--------------+---------+
| id           | int     |
| name         | varchar |
| salary       | int     |
| departmentId | int     |
+--------------+---------+
id is the primary key (column with unique values) for this table.
departmentId is a foreign key (reference columns) of the ID from the <code>Department </code>table.
Each row of this table indicates the ID, name, and salary of an employee. It also contains the ID of their department.
</pre>

<p>&nbsp;</p>

<p>Table: <code>Department</code></p>

<pre>
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| name        | varchar |
+-------------+---------+
id is the primary key (column with unique values) for this table. It is guaranteed that department name is not <code>NULL.</code>
Each row of this table indicates the ID of a department and its name.
</pre>

<p>&nbsp;</p>

<p>Write a solution to find employees who have the highest salary in each of the departments.</p>

<p>Return the result table in <strong>any order</strong>.</p>

<p>The result format is in the following example.</p>

<p>&nbsp;</p>
<p><strong class="example">Example 1:</strong></p>

<pre>
<strong>Input:</strong> 
Employee table:
+----+-------+--------+--------------+
| id | name  | salary | departmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 70000  | 1            |
| 2  | Jim   | 90000  | 1            |
| 3  | Henry | 80000  | 2            |
| 4  | Sam   | 60000  | 2            |
| 5  | Max   | 90000  | 1            |
+----+-------+--------+--------------+
Department table:
+----+-------+
| id | name  |
+----+-------+
| 1  | IT    |
| 2  | Sales |
+----+-------+
<strong>Output:</strong> 
+------------+----------+--------+
| Department | Employee | Salary |
+------------+----------+--------+
| IT         | Jim      | 90000  |
| Sales      | Henry    | 80000  |
| IT         | Max      | 90000  |
+------------+----------+--------+
<strong>Explanation:</strong> Max and Jim both have the highest salary in the IT department and Henry has the highest salary in the Sales department.
</pre>

## 🧠 Approach

Since the requirement is to find the **highest salary in each department**, a window function is the most suitable choice.

1. **Join the required tables**  
   Joined `Employee` and `Department` using `departmentId` to associate each employee with their department name.

2. **Use a window function to rank salaries within each department**  
   Applied `DENSE_RANK()` with `PARTITION BY departmentId` and ordered salaries in descending order.  
   This assigns rank `1` to the highest salary in each department while handling ties correctly.

3. **Encapsulate logic using a CTE**  
   Wrapped the ranking logic inside a Common Table Expression (CTE) to keep the query clean and readable.

4. **Filter only top-ranked employees**  
   Queried the CTE and used a `WHERE` clause to select rows where `salary_rank = 1`, representing the highest-paid employees per department.

5. **Final output**  
   Selected only the required columns: `Department`, `Employee`, and `Salary`.

### 📌 Key Learning
Instead of explicitly selecting individual columns, using `*` along with window functions is also a valid approach when all base columns are required. This helps simplify queries in similar scenarios.
