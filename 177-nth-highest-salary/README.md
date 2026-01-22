<h2><a href="https://leetcode.com/problems/nth-highest-salary">Nth Highest Salary</a></h2> <img src='https://img.shields.io/badge/Difficulty-Medium-orange' alt='Difficulty: Medium' /><hr><p>Table: <code>Employee</code></p>

<pre>
+-------------+------+
| Column Name | Type |
+-------------+------+
| id          | int  |
| salary      | int  |
+-------------+------+
id is the primary key (column with unique values) for this table.
Each row of this table contains information about the salary of an employee.
</pre>

<p>&nbsp;</p>

<p>Write a solution to find the <code>n<sup>th</sup></code> highest <strong>distinct</strong> salary from the <code>Employee</code> table. If there are less than <code>n</code> distinct salaries, return&nbsp;<code>null</code>.</p>

<p>The result format is in the following example.</p>

<p>&nbsp;</p>
<p><strong class="example">Example 1:</strong></p>

<pre>
<strong>Input:</strong> 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
| 2  | 200    |
| 3  | 300    |
+----+--------+
n = 2
<strong>Output:</strong> 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| 200                    |
+------------------------+
</pre>

<p><strong class="example">Example 2:</strong></p>

<pre>
<strong>Input:</strong> 
Employee table:
+----+--------+
| id | salary |
+----+--------+
| 1  | 100    |
+----+--------+
n = 2
<strong>Output:</strong> 
+------------------------+
| getNthHighestSalary(2) |
+------------------------+
| null                   |
+------------------------+
</pre>

## 🧠 Approach

The goal is to find the **nth highest distinct salary** from the `Employee` table and return `NULL` if such a salary does not exist.

1. **Rank salaries in descending order**  
   Used the `DENSE_RANK()` window function to rank salaries:
`DENSE_RANK()` ensures that duplicate salaries receive the same rank without skipping rank values.

2. **Handle distinct salary requirement**  
Since multiple employees can have the same salary, ranking is applied on salary values rather than employee rows.

3. **Encapsulate ranking logic in a subquery**  
Wrapped the ranking logic inside a subquery to allow filtering based on the computed rank.

4. **Select the nth highest salary**  
Filtered rows where:
and applied `LIMIT 1` to return a single value.

5. **Graceful handling of missing ranks**  
If fewer than `n` distinct salaries exist, the query returns no rows, causing the function to return `NULL` as required.

### 📌 Key Insight
`DENSE_RANK()` is ideal for **nth highest problems** because it preserves ranking order while correctly handling duplicate values.
