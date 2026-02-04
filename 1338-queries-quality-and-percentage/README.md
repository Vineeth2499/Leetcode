<h2><a href="https://leetcode.com/problems/queries-quality-and-percentage">Queries Quality and Percentage</a></h2> <img src='https://img.shields.io/badge/Difficulty-Easy-brightgreen' alt='Difficulty: Easy' /><hr><p>Table: <code>Queries</code></p>

<pre>
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| query_name  | varchar |
| result      | varchar |
| position    | int     |
| rating      | int     |
+-------------+---------+
This table may have duplicate rows.
This table contains information collected from some queries on a database.
The <code>position</code> column has a value from <strong>1</strong> to <strong>500</strong>.
The <code>rating</code> column has a value from <strong>1</strong> to <strong>5</strong>. Query with <code>rating</code> less than 3 is a poor query.
</pre>

<p>&nbsp;</p>

<p>We define query <code>quality</code> as:</p>

<blockquote>
<p>The average of the ratio between query rating and its position.</p>
</blockquote>

<p>We also define <code>poor query percentage</code> as:</p>

<blockquote>
<p>The percentage of all queries with rating less than 3.</p>
</blockquote>

<p>Write a solution to find each <code>query_name</code>, the <code>quality</code> and <code>poor_query_percentage</code>.</p>

<p>Both <code>quality</code> and <code>poor_query_percentage</code> should be <strong>rounded to 2 decimal places</strong>.</p>

<p>Return the result table in <strong>any order</strong>.</p>

<p>The&nbsp;result format is in the following example.</p>

<p>&nbsp;</p>
<p><strong class="example">Example 1:</strong></p>

<pre>
<strong>Input:</strong> 
Queries table:
+------------+-------------------+----------+--------+
| query_name | result            | position | rating |
+------------+-------------------+----------+--------+
| Dog        | Golden Retriever  | 1        | 5      |
| Dog        | German Shepherd   | 2        | 5      |
| Dog        | Mule              | 200      | 1      |
| Cat        | Shirazi           | 5        | 2      |
| Cat        | Siamese           | 3        | 3      |
| Cat        | Sphynx            | 7        | 4      |
+------------+-------------------+----------+--------+
<strong>Output:</strong> 
+------------+---------+-----------------------+
| query_name | quality | poor_query_percentage |
+------------+---------+-----------------------+
| Dog        | 2.50    | 33.33                 |
| Cat        | 0.66    | 33.33                 |
+------------+---------+-----------------------+
<strong>Explanation:</strong> 
Dog queries quality is ((5 / 1) + (5 / 2) + (1 / 200)) / 3 = 2.50
Dog queries poor_ query_percentage is (1 / 3) * 100 = 33.33

Cat queries quality equals ((2 / 5) + (3 / 3) + (4 / 7)) / 3 = 0.66
Cat queries poor_ query_percentage is (1 / 3) * 100 = 33.33
</pre>

## 🧠 Approach

The requirement is to compute two metrics for each query_name:
- *Query quality*: average of (rating / position)
- *Poor query percentage*: percentage of queries with rating < 3

1. *Partition calculations by query name*  
   Used window functions with:
to ensure all calculations are performed independently for each query.

2. *Calculate query quality*  
Computed the quality metric as:
Used floating-point division (rating * 1.0 / position) to avoid integer division and rounded the result to two decimal places.

3. *Calculate poor query percentage*  
Counted poor queries using a conditional expression:
Used floating-point division (rating * 1.0 / position) to avoid integer division and rounded the result to two decimal places.

3. *Calculate poor query percentage*  
Counted poor queries using a conditional expression:
Divided this count by the total number of queries per query_name, multiplied by 100, and rounded to two decimal places.

4. *Use window functions instead of GROUP BY*  
Applied window functions for both metrics so that multiple aggregations could be computed without collapsing rows.

5. *Remove duplicate rows in final output*  
Used DISTINCT(query_name) to return a single result row per query name.

6. *Final output*  
Returned:
- query_name
- quality
- poor_query_percentage

### 📌 Key Insight
Window functions allow computing multiple aggregated metrics over the same partition *without grouping*, making them ideal for analytical queries like this.
