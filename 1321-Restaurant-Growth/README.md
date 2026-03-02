# 7-Day Moving Average of Customer Spending

## 📌 Problem Statement

You are given a `Customer` table:

| Column Name | Type |
|-------------|------|
| customer_id | int  |
| name        | varchar |
| visited_on  | date |
| amount      | int  |

- `(customer_id, visited_on)` is the primary key.
- Each row represents the total amount paid by a customer on a given date.
- There is at least one customer every day.

### Objective

Compute the **7-day moving average** of total daily revenue  
(current day + previous 6 days).

- Return:
  - `visited_on`
  - 7-day total `amount`
  - `average_amount` (rounded to 2 decimal places)
- Sort results by `visited_on` in ascending order.
- Only return rows where a full 7-day window exists.

---

## 🧠 Approach

### 1️⃣ Aggregate Daily Revenue

This gives one row per date.

---

### 2️⃣ Apply 7-Day Moving Window

Use a window function:

This creates a rolling 7-day frame.

For each day:
- Calculate 7-day total revenue using `SUM() OVER`
- Calculate 7-day average using `AVG() OVER`

---

### 3️⃣ Remove Incomplete Windows

The first 6 days don’t have a full 7-day window.  
Use:

to exclude them.

---

## 💡 Key Insight

This problem has **two layers**:

1. Convert transaction-level data → daily revenue.
2. Apply a rolling window using window functions.

Moving averages should always be applied **after aggregation**,  
not directly on raw transaction data.

---

Since multiple customers can visit on the same day,  
first calculate **total revenue per day**:
