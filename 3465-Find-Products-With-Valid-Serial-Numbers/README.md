<h2><a href="https://leetcode.com/problems/find-products-with-valid-serial-numbers">Find Products with Valid Serial Numbers</a></h2>
<img src='https://img.shields.io/badge/Difficulty-Easy-brightgreen' alt='Difficulty: Easy' />
<hr>
<p>Table: <code>products</code></p>

<pre>
+--------------+------------+
| Column Name  | Type       |
+--------------+------------+
| product_id   | int        |
| product_name | varchar    |
| description  | varchar    |
+--------------+------------+
product_id is the unique key for this table.
Each row in the table represents a product with its unique ID, name, and description.
</pre>

<p>&nbsp;</p>

<p>
Write a solution to find all products whose description contains a valid serial number pattern.
</p>

<p>
A valid serial number follows these rules:
</p>

<ul>
<li>It starts with the letters <code>SN</code> (case-sensitive).</li>
<li>Followed by exactly 4 digits.</li>
<li>It must have a hyphen (<code>-</code>) followed by exactly 4 digits.</li>
<li>The serial number must be within the description.</li>
</ul>

<p>
Return the result table ordered by <code>product_id</code> in ascending order.
</p>

<p>&nbsp;</p>

<p><strong class="example">Example:</strong></p>

<pre>
<strong>Input:</strong>
products table:
+------------+--------------+------------------------------------------------------+
| product_id | product_name | description                                          |
+------------+--------------+------------------------------------------------------+
| 1          | Widget A     | This is a sample product with SN1234-5678            |
| 2          | Widget B     | A product with serial SN9876-1234 in the description |
| 3          | Widget C     | Product SN1234-56789 is available now                |
| 4          | Widget D     | No serial number here                                |
| 5          | Widget E     | Check out SN4321-8765 in this description            |
+------------+--------------+------------------------------------------------------+

<strong>Output:</strong>
+------------+--------------+------------------------------------------------------+
| product_id | product_name | description                                          |
+------------+--------------+------------------------------------------------------+
| 1          | Widget A     | This is a sample product with SN1234-5678            |
| 2          | Widget B     | A product with serial SN9876-1234 in the description |
| 5          | Widget E     | Check out SN4321-8765 in this description            |
+------------+--------------+------------------------------------------------------+
</pre>

<h2>🧠 Approach</h2>

<ul>
<li>The problem requires identifying whether a product description contains a valid serial number pattern.</li>
<li>Since the serial number may appear anywhere in the text and must follow a strict format, regular expression matching is used.</li>
<li>The pattern enforces an exact <code>SN</code> prefix, followed by four digits, a hyphen, and another four digits.</li>
<li>Boundary conditions are applied to ensure the serial number is not part of a longer alphanumeric string.</li>
<li>Only rows containing valid serial numbers are selected and the result is ordered by <code>product_id</code>.</li>
</ul>
