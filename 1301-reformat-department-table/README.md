<h2><a href="https://leetcode.com/problems/reformat-department-table">Reformat Department Table</a></h2> <img src='https://img.shields.io/badge/Difficulty-Easy-brightgreen' alt='Difficulty: Easy' /><hr><p>Table: <code>Department</code></p>

<pre>
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| id          | int     |
| revenue     | int     |
| month       | varchar |
+-------------+---------+
In SQL,(id, month) is the primary key of this table.
The table has information about the revenue of each department per month.
The month has values in [&quot;Jan&quot;,&quot;Feb&quot;,&quot;Mar&quot;,&quot;Apr&quot;,&quot;May&quot;,&quot;Jun&quot;,&quot;Jul&quot;,&quot;Aug&quot;,&quot;Sep&quot;,&quot;Oct&quot;,&quot;Nov&quot;,&quot;Dec&quot;].
</pre>

<p>&nbsp;</p>

<p>Reformat the table such that there is a department id column and a revenue column <strong>for each month</strong>.</p>

<p>Return the result table in <strong>any order</strong>.</p>

<p>The result format is in the following example.</p>

<p>&nbsp;</p>
<p><strong class="example">Example 1:</strong></p>

<pre>
<strong>Input:</strong> 
Department table:
+------+---------+-------+
| id   | revenue | month |
+------+---------+-------+
| 1    | 8000    | Jan   |
| 2    | 9000    | Jan   |
| 3    | 10000   | Feb   |
| 1    | 7000    | Feb   |
| 1    | 6000    | Mar   |
+------+---------+-------+
<strong>Output:</strong> 
+------+-------------+-------------+-------------+-----+-------------+
| id   | Jan_Revenue | Feb_Revenue | Mar_Revenue | ... | Dec_Revenue |
+------+-------------+-------------+-------------+-----+-------------+
| 1    | 8000        | 7000        | 6000        | ... | null        |
| 2    | 9000        | null        | null        | ... | null        |
| 3    | null        | 10000       | null        | ... | null        |
+------+-------------+-------------+-------------+-----+-------------+
<strong>Explanation:</strong> The revenue from Apr to Dec is null.
Note that the result table has 13 columns (1 for the department id + 12 for the months).
</pre>

## 🧠 Approach

The requirement is to **pivot monthly revenue values into separate columns** for each department.

1. **Group data by department**  
   Grouped the records by `id` since the output should contain one row per department.

2. **Pivot month values using conditional aggregation**  
   Used `CASE WHEN` expressions inside `SUM()` to transform row-level month values into individual revenue columns:
This pattern is repeated for all twelve months.

3. **Handle missing month data**  
When a department does not have revenue for a particular month, the `CASE` expression returns `NULL`, which correctly appears as `NULL` in the output.

4. **Aggregate safely using SUM()**  
Although `(id, month)` is unique, `SUM()` ensures the query remains correct and robust even if additional rows exist for the same department and month.

5. **Final output**  
Returned:
- `id`
- one revenue column for each month from January to December

### 📌 Key Insight
Conditional aggregation using `SUM(CASE WHEN ...)` is a reliable technique for **pivoting categorical values into columns** when native `PIVOT` functionality is unavailable or limited.
