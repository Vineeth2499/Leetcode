<h2><a href="https://leetcode.com/problems/find-valid-emails">Find Valid Emails</a></h2> <img src='https://img.shields.io/badge/Difficulty-Easy-brightgreen' alt='Difficulty: Easy' /><hr><p>Table: <code>Users</code></p>

<pre>
+-----------------+---------+
| Column Name     | Type    |
+-----------------+---------+
| user_id         | int     |
| email           | varchar |
+-----------------+---------+
(user_id) is the unique key for this table.
Each row contains a user&#39;s unique ID and email address.
</pre>

<p>Write a solution to find all the <strong>valid email addresses</strong>. A valid email address meets the following criteria:</p>

<ul>
	<li>It contains exactly one <code>@</code> symbol.</li>
	<li>It ends with <code>.com</code>.</li>
	<li>The part before the <code>@</code> symbol contains only <strong>alphanumeric</strong> characters and <strong>underscores</strong>.</li>
	<li>The part after the <code>@</code> symbol and before <code>.com</code> contains a domain name <strong>that contains only letters</strong>.</li>
</ul>

<p>Return<em> the result table ordered by</em> <code>user_id</code> <em>in</em> <strong>ascending </strong><em>order</em>.</p>

<p>&nbsp;</p>
<p><strong class="example">Example:</strong></p>

<div class="example-block">
<p><strong>Input:</strong></p>

<p>Users table:</p>

<pre class="example-io">
+---------+---------------------+
| user_id | email               |
+---------+---------------------+
| 1       | alice@example.com   |
| 2       | bob_at_example.com  |
| 3       | charlie@example.net |
| 4       | david@domain.com    |
| 5       | eve@invalid         |
+---------+---------------------+
</pre>

<p><strong>Output:</strong></p>

<pre class="example-io">
+---------+-------------------+
| user_id | email             |
+---------+-------------------+
| 1       | alice@example.com |
| 4       | david@domain.com  |
+---------+-------------------+
</pre>

<p><strong>Explanation:</strong></p>

<ul>
	<li><strong>alice@example.com</strong> is valid because it contains one <code>@</code>, alice&nbsp;is alphanumeric, and example.com&nbsp;starts with a letter and ends with .com.</li>
	<li><strong>bob_at_example.com</strong> is invalid because it contains an underscore instead of an <code>@</code>.</li>
	<li><strong>charlie@example.net</strong> is invalid because the domain does not end with <code>.com</code>.</li>
	<li><strong>david@domain.com</strong> is valid because it meets all criteria.</li>
	<li><strong>eve@invalid</strong> is invalid because the domain does not end with <code>.com</code>.</li>
</ul>

<p>Result table is ordered by user_id in ascending order.</p>
</div>

## 🧠 Approach

This problem is about validating e-mail addresses based on a **specific set of rules**, not general e-mail standards.  
To ensure correctness and avoid partial matches, the solution uses **regular expressions** to validate the entire structure of the email string.

---

### 🔍 Validation Rules Breakdown

A valid email must satisfy **all** of the following:

1. Contains **exactly one `@` symbol**
2. Ends with **`.com`**
3. The part **before `@`**:
   - Contains only letters, digits, or underscores
4. The part **after `@` and before `.com`**:
   - Contains only letters
5. No extra characters are allowed before or after the valid pattern

---

### 💡 Key Insight

Using `LIKE` alone is insufficient because:
- It cannot enforce **character-level restrictions**
- It cannot guarantee **exactly one `@`**
- It allows partial matches

Regular expressions allow us to:
- Define allowed characters precisely
- Enforce start (`^`) and end (`$`) boundaries
- Validate the full email structure in a single condition

---

^                       -- start of string
[a-zA-Z0-9_]+           -- prefix: alphanumeric characters or underscore
@                       -- exactly one '@' symbol
[a-zA-Z]+               -- domain name: letters only
\.com                   -- must end with '.com'
$                       -- end of string

---
