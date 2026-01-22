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

The goal is to return the **nth highest distinct salary** from the `Employee` table and return `NULL` if such a rank does not exist.

1. **Use a SQL function for reusability**  
   Implemented a SQL function `getNthHighestSalary(n)` that accepts `n` as a parameter.  
   The function acts as a wrapper to return the salary corresponding to the nth rank.

2. **Rank salaries using a window function**  
   Applied `DENSE_RANK()` ordered by salary in descending order to assign ranks to **distinct salary values**.
   `DENSE_RANK()` ensures duplicate salaries share the same rank without skipping rank values.

3. **Encapsulate ranking logic in a subquery**  
   Used a subquery to compute salary ranks before applying any filtering, keeping the query readable and logically structured.

4. **Return the nth ranked salary**  
   Filtered the ranked result where:
   rnk = n and returned the corresponding salary.

5. **Handle missing ranks gracefully**  
   If fewer than `n` distinct salaries exist, the subquery returns no rows, causing the function to return `NULL` as required.

### 📌 Key Insight
Wrapping ranking logic inside a function allows the query to behave like a reusable utility, while `DENSE_RANK()` ensures accurate handling of duplicate salary values.
