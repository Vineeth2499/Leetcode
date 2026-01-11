<h2><a href="https://leetcode.com/problems/human-traffic-of-stadium">Human Traffic of Stadium</a></h2> <img src='https://img.shields.io/badge/Difficulty-Hard-red' alt='Difficulty: Hard' /><hr><p>Table: <code>Stadium</code></p>

<pre>
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| visit_date    | date    |
| people        | int     |
+---------------+---------+
visit_date is the column with unique values for this table.
Each row of this table contains the visit date and visit id to the stadium with the number of people during the visit.
As the id increases, the date increases as well.
</pre>

<p>&nbsp;</p>

<p>Write a solution to display the records with three or more rows with <strong>consecutive</strong> <code>id</code>&#39;s, and the number of people is greater than or equal to 100 for each.</p>

<p>Return the result table ordered by <code>visit_date</code> in <strong>ascending order</strong>.</p>

<p>The result format is in the following example.</p>

<p>&nbsp;</p>
<p><strong class="example">Example 1:</strong></p>

<pre>
<strong>Input:</strong> 
Stadium table:
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 1    | 2017-01-01 | 10        |
| 2    | 2017-01-02 | 109       |
| 3    | 2017-01-03 | 150       |
| 4    | 2017-01-04 | 99        |
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-09 | 188       |
+------+------------+-----------+
<strong>Output:</strong> 
+------+------------+-----------+
| id   | visit_date | people    |
+------+------------+-----------+
| 5    | 2017-01-05 | 145       |
| 6    | 2017-01-06 | 1455      |
| 7    | 2017-01-07 | 199       |
| 8    | 2017-01-09 | 188       |
+------+------------+-----------+
<strong>Explanation:</strong> 
The four rows with ids 5, 6, 7, and 8 have consecutive ids and each of them has &gt;= 100 people attended. Note that row 8 was included even though the visit_date was not the next day after row 7.
The rows with ids 2 and 3 are not included because we need at least three consecutive ids.
</pre>

## 🧠 Approach

At first glance, the problem looks simple since we only need records where `people >= 100`.  
However, the real challenge is identifying **three or more rows with consecutive IDs**.

### Step-by-step Logic

1. **Filter valid records first**  
   Filtered the table to include only rows where `people >= 100`, since other rows cannot be part of a valid consecutive sequence.

2. **Identify consecutive IDs using a window function**  
   Used `ROW_NUMBER()` ordered by `id` and calculated:

This creates a constant value (`rw_num`) for consecutive IDs after filtering.

####  id - ROW_NUMBER()

This creates a constant value (`rw_num`) for consecutive IDs after filtering.

3. **Why this works**  
- When IDs are consecutive, the difference between `id` and `ROW_NUMBER()` remains the same.
- Once an ID is skipped (because `people < 100`), the difference changes, forming a new group.
- This allows grouping consecutive IDs logically without relying on dates.

4. **Create a CTE for clarity**  
Wrapped the filtering and window function logic inside a CTE (`people_count`) to improve readability and reuse.

5. **Find valid consecutive groups**  
Grouped records by `rw_num` and used:

####  HAVING COUNT(id) >= 3

to identify sequences with at least three consecutive IDs.

6. **Final selection**  
Selected rows from the CTE whose `rw_num` belongs to a group satisfying the consecutive condition, and ordered the output by `visit_date`.

### 📌 Key Learnings
- `id - ROW_NUMBER()` is a powerful technique to detect **consecutive sequences** in SQL.
- Filtering before applying window functions directly affects row numbering.
- `HAVING COUNT(id) >= 3` ensures only valid consecutive groups are selected.
- Breaking the query and running it step by step makes complex logic easier to understand.
