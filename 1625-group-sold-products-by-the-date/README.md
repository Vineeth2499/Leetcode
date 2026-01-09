<h2><a href="https://leetcode.com/problems/group-sold-products-by-the-date">Group Sold Products By The Date</a></h2> <img src='https://img.shields.io/badge/Difficulty-Easy-brightgreen' alt='Difficulty: Easy' /><hr><p>Table <code>Activities</code>:</p>

<pre>
+-------------+---------+
| Column Name | Type    |
+-------------+---------+
| sell_date   | date    |
| product     | varchar |
+-------------+---------+
There is no primary key (column with unique values) for this table. It may contain duplicates.
Each row of this table contains the product name and the date it was sold in a market.
</pre>

<p>&nbsp;</p>

<p>Write a solution to find for each date the number of different products sold and their names.</p>

<p>The sold products names for each date should be sorted lexicographically.</p>

<p>Return the result table ordered by <code>sell_date</code>.</p>

<p>The&nbsp;result format is in the following example.</p>

<p>&nbsp;</p>
<p><strong class="example">Example 1:</strong></p>

<pre>
<strong>Input:</strong> 
Activities table:
+------------+------------+
| sell_date  | product     |
+------------+------------+
| 2020-05-30 | Headphone  |
| 2020-06-01 | Pencil     |
| 2020-06-02 | Mask       |
| 2020-05-30 | Basketball |
| 2020-06-01 | Bible      |
| 2020-06-02 | Mask       |
| 2020-05-30 | T-Shirt    |
+------------+------------+
<strong>Output:</strong> 
+------------+----------+------------------------------+
| sell_date  | num_sold | products                     |
+------------+----------+------------------------------+
| 2020-05-30 | 3        | Basketball,Headphone,T-shirt |
| 2020-06-01 | 2        | Bible,Pencil                 |
| 2020-06-02 | 1        | Mask                         |
+------------+----------+------------------------------+
<strong>Explanation:</strong> 
For 2020-05-30, Sold items were (Headphone, Basketball, T-shirt), we sort them lexicographically and separate them by a comma.
For 2020-06-01, Sold items were (Pencil, Bible), we sort them lexicographically and separate them by a comma.
For 2020-06-02, the Sold item is (Mask), we just return it.
</pre>

## 🧠 Approach

1. **Group data by sell date**  
   Since the requirement is to analyze sales per day, grouped the records using `sell_date`.

2. **Count distinct products sold per date**  
   Used `COUNT(DISTINCT product)` to calculate how many unique products were sold on each date, as the table may contain duplicate rows.

3. **Concatenate product names into a single column**  
   Identified that the output requires product names to be returned as a comma-separated string.  
   This led to using a string aggregation function instead of row-wise output.

4. **Use GROUP_CONCAT for string aggregation**  
   Discovered that MySQL provides `GROUP_CONCAT()` to combine multiple row values into a single string for each group.

5. **Handle duplicates inside concatenation**  
   Initially noticed duplicate product names appearing in the output (e.g., `Mask`).  
   Added `DISTINCT` inside `GROUP_CONCAT()` to ensure each product appears only once per date.

6. **Final output**  
   Returned:
   - `sell_date`
   - Number of distinct products sold (`num_sold`)
   - Lexicographically concatenated product names (`products`)

### 📌 Key Learnings
- Lexicographical ordering or list-style outputs often require **string aggregation functions** in SQL.
- `GROUP_CONCAT()` is useful for converting row-level values into a readable summary format.
- Trusting intuition and experimenting (like using `DISTINCT` inside `GROUP_CONCAT`) can lead to effective solutions.
