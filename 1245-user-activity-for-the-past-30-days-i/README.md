<h2><a href="https://leetcode.com/problems/user-activity-for-the-past-30-days-i">User Activity for the Past 30 Days I</a></h2> <img src='https://img.shields.io/badge/Difficulty-Easy-brightgreen' alt='Difficulty: Easy' /><hr><p>Table: <code>Activity</code></p>

<pre>
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| session_id    | int     |
| activity_date | date    |
| activity_type | enum    |
+---------------+---------+
This table may have duplicate rows.
The activity_type column is an ENUM (category) of type (&#39;open_session&#39;, &#39;end_session&#39;, &#39;scroll_down&#39;, &#39;send_message&#39;).
The table shows the user activities for a social media website. 
Note that each session belongs to exactly one user.
</pre>

<p>&nbsp;</p>

<p>Write a solution to find the daily active user count for a period of <code>30</code> days ending <code>2019-07-27</code> inclusively. A user was active on someday if they made at least one activity on that day.</p>

<p>Return the result table in <strong>any order</strong>.</p>

<p>The&nbsp;result format is in the following example.</p>

<p>Note: <strong>Any</strong> activity from (<code>&#39;open_session&#39;</code>, <code>&#39;end_session&#39;</code>, <code>&#39;scroll_down&#39;</code>, <code>&#39;send_message&#39;</code>) will be considered valid activity for a user to be considered active on a day.</p>

<p>&nbsp;</p>
<p><strong class="example">Example 1:</strong></p>

<pre>
<strong>Input:</strong> 
Activity table:
+---------+------------+---------------+---------------+
| user_id | session_id | activity_date | activity_type |
+---------+------------+---------------+---------------+
| 1       | 1          | 2019-07-20    | open_session  |
| 1       | 1          | 2019-07-20    | scroll_down   |
| 1       | 1          | 2019-07-20    | end_session   |
| 2       | 4          | 2019-07-20    | open_session  |
| 2       | 4          | 2019-07-21    | send_message  |
| 2       | 4          | 2019-07-21    | end_session   |
| 3       | 2          | 2019-07-21    | open_session  |
| 3       | 2          | 2019-07-21    | send_message  |
| 3       | 2          | 2019-07-21    | end_session   |
| 4       | 3          | 2019-06-25    | open_session  |
| 4       | 3          | 2019-06-25    | end_session   |
+---------+------------+---------------+---------------+
<strong>Output:</strong> 
+------------+--------------+ 
| day        | active_users |
+------------+--------------+ 
| 2019-07-20 | 2            |
| 2019-07-21 | 2            |
+------------+--------------+ 
<strong>Explanation:</strong> Note that we do not care about days with zero active users.
</pre>

## 🧠 Approach

This problem asks for the **daily active user (DAU)** count over a fixed 30-day window ending on **2019-07-27**.

A user is considered *active* on a given day if they performed **at least one activity**, regardless of the activity type or the number of times they were active on that day.

---

### 🔍 Problem Breakdown

To solve this, we need to:

1. Restrict the data to the **last 30 days**, including `2019-07-27`
2. Treat **any activity** as valid activity
3. Count **unique users per day**, not total activities
4. Ignore days where there were **no active users**

---

### 💡 Key Insights

- The table may contain **multiple rows per user per day**, so:
  - We must use `COUNT(DISTINCT user_id)` to avoid double counting
- The 30-day window is calculated as:
  - `2019-07-27` (inclusive)
  - back to `2019-06-29` (`27 - 29 days`)
- Since days with zero activity do not need to be shown, there is **no need to generate a calendar table**

---
