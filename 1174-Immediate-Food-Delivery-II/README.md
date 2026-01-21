Table: Delivery

+-----------------------------+---------+
| Column Name                 | Type    |
+-----------------------------+---------+
| delivery_id                 | int     |
| customer_id                 | int     |
| order_date                  | date    |
| customer_pref_delivery_date | date    |
+-----------------------------+---------+
delivery_id is the column of unique values of this table.
The table holds information about food delivery to customers that make orders at some date and specify a preferred delivery date (on the same order date or after it).
 

If the customer's preferred delivery date is the same as the order date, then the order is called immediate; otherwise, it is called scheduled.

The first order of a customer is the order with the earliest order date that the customer made. It is guaranteed that a customer has precisely one first order.

Write a solution to find the percentage of immediate orders in the first orders of all customers, rounded to 2 decimal places.

The result format is in the following example.

 

Example 1:

Input: 
Delivery table:
+-------------+-------------+------------+-----------------------------+
| delivery_id | customer_id | order_date | customer_pref_delivery_date |
+-------------+-------------+------------+-----------------------------+
| 1           | 1           | 2019-08-01 | 2019-08-02                  |
| 2           | 2           | 2019-08-02 | 2019-08-02                  |
| 3           | 1           | 2019-08-11 | 2019-08-12                  |
| 4           | 3           | 2019-08-24 | 2019-08-24                  |
| 5           | 3           | 2019-08-21 | 2019-08-22                  |
| 6           | 2           | 2019-08-11 | 2019-08-13                  |
| 7           | 4           | 2019-08-09 | 2019-08-09                  |
+-------------+-------------+------------+-----------------------------+
Output: 
+----------------------+
| immediate_percentage |
+----------------------+
| 50.00                |
+----------------------+
Explanation: 
The customer id 1 has a first order with delivery id 1 and it is scheduled.
The customer id 2 has a first order with delivery id 2 and it is immediate.
The customer id 3 has a first order with delivery id 5 and it is scheduled.
The customer id 4 has a first order with delivery id 7 and it is immediate.
Hence, half the customers have immediate first orders.

## 🧠 Approach

The goal is to calculate the **percentage of immediate deliveries among customers’ first orders**.

1. **Identify each customer’s first order**  
   Since the first order is defined as the earliest `order_date` per customer, used:
Grouped by `customer_id` to isolate first-order records.

2. **Filter the dataset to first orders only**  
Used a tuple comparison:
To ensure only first-order rows are included in the calculation.

3. **Classify immediate orders**  
An order is considered *immediate* when the `order_date` is the same as the `customer_pref_delivery_date`.  
Converted this condition into a numeric value using a `CASE` expression (1 for immediate, 0 otherwise).

4. **Compute the percentage**  
Calculated the ratio of immediate first orders to total first orders and multiplied by 100 to get the percentage.

5. **Round the final result**  
Applied `ROUND(..., 2)` to return the result rounded to two decimal places as required.

### 📌 Key Insight
Filtering the data to the correct **granularity (first order per customer)** before aggregation is essential to ensure accurate percentage calculations.
