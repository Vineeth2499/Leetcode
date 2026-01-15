<h2><a href="https://leetcode.com/problems/department-top-three-salaries">Department Top Three Salaries</a></h2> <img src='https://img.shields.io/badge/Difficulty-Hard-red' alt='Difficulty: Hard' /><hr><p>Table: <code>Employee</code></p>

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
departmentId is a foreign key (reference column) of the ID from the <code>Department </code>table.
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
id is the primary key (column with unique values) for this table.
Each row of this table indicates the ID of a department and its name.
</pre>

<p>&nbsp;</p>

<p>A company&#39;s executives are interested in seeing who earns the most money in each of the company&#39;s departments. A <strong>high earner</strong> in a department is an employee who has a salary in the <strong>top three unique</strong> salaries for that department.</p>

<p>Write a solution to find the employees who are <strong>high earners</strong> in each of the departments.</p>

<p>Return the result table <strong>in any order</strong>.</p>

<p>The&nbsp;result format is in the following example.</p>

<p>&nbsp;</p>
<p><strong class="example">Example 1:</strong></p>

<pre>
<strong>Input:</strong> 
Employee table:
+----+-------+--------+--------------+
| id | name  | salary | departmentId |
+----+-------+--------+--------------+
| 1  | Joe   | 85000  | 1            |
| 2  | Henry | 80000  | 2            |
| 3  | Sam   | 60000  | 2            |
| 4  | Max   | 90000  | 1            |
| 5  | Janet | 69000  | 1            |
| 6  | Randy | 85000  | 1            |
| 7  | Will  | 70000  | 1            |
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
| IT         | Max      | 90000  |
| IT         | Joe      | 85000  |
| IT         | Randy    | 85000  |
| IT         | Will     | 70000  |
| Sales      | Henry    | 80000  |
| Sales      | Sam      | 60000  |
+------------+----------+--------+
<strong>Explanation:</strong> 
In the IT department:
- Max earns the highest unique salary
- Both Randy and Joe earn the second-highest unique salary
- Will earns the third-highest unique salary

In the Sales department:
- Henry earns the highest salary
- Sam earns the second-highest salary
- There is no third-highest salary as there are only two employees
</pre>

<p>&nbsp;</p>
<p><strong>Constraints:</strong></p>

<ul>
	<li>There are no employees with the <strong>exact</strong> same name, salary <em>and</em> department.</li>
</ul>

## 🧠 Approach

The requirement is to identify employees who earn within the **top three unique salaries per department**.  
This naturally points to using **window functions**.

### Step-by-step Logic

1. **Join the required tables**  
   Joined `Employee` and `Department` using the correct relationship:
This allows access to department names along with employee details.

2. **Select required output columns**  
Selected:
- Department name
- Employee name
- Salary  
as specified in the expected output.

3. **Rank salaries within each department**  
Used `DENSE_RANK()` with:
`DENSE_RANK()` is chosen over `RANK()` to ensure:
- Employees with the same salary share the same rank
- No rank values are skipped, which is required for identifying the top three *unique* salaries

4. **Encapsulate logic using a CTE**  
Placed the ranking logic inside a CTE to keep the query readable and to enable filtering on the computed rank.

5. **Filter top three salaries per department**  
Queried the CTE and filtered rows where:
This ensures all employees earning within the top three unique salaries per department are included.

### 📌 Key Learnings

- **Correct joins are critical**  
Accidentally joining incorrect columns (e.g., `Employee.id` to `Department.id`) can lead to:
- Incorrect or meaningless results
- Performance issues
- Hard-to-detect data bugs  
Always verify foreign key relationships before joining tables.

- **Window functions cannot be used in the WHERE clause**  
Window functions are evaluated *after* the `WHERE` clause.  
To filter on window function results, they must be computed first (via a CTE or subquery).

- **Simple problems can still expose important fundamentals**  
This problem reinforced the importance of:
- Understanding schema relationships
- Choosing the right ranking function
- Respecting SQL execution order
