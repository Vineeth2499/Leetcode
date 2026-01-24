## 🧾 Problem Statement

### Table: Users

| Column Name     | Type    |
|-----------------|---------|
| user_id         | int     |
| join_date       | date    |
| favorite_brand  | varchar |

- `user_id` is the primary key of this table.
- Each row contains information about a user of the platform.

---

### Table: Orders

| Column Name | Type |
|------------|------|
| order_id   | int  |
| order_date | date |
| item_id    | int  |
| buyer_id   | int  |
| seller_id  | int  |

- `order_id` is the primary key.
- `buyer_id` and `seller_id` reference the `Users` table.

---

### Table: Items

| Column Name | Type |
|------------|------|
| item_id    | int  |
| item_brand | varchar |

- `item_id` is the primary key of this table.

---

### Task

Write a SQL query to report, **for each user**, their:
- join date
- number of orders they made **as a buyer in the year 2019**

Include users who made **zero orders** in 2019.  
The result can be returned in any order.

---

## 🧠 Approach

1. **Use Users as the base table**  
   Started from the `Users` table since the output must include **all users**, even those with no orders.

2. **LEFT JOIN Orders table**  
   Joined `Orders` to `Users` using:
A `LEFT JOIN` ensures users without orders are not excluded.

3. **Filter orders for 2019 inside the JOIN condition**  
Applied the date filter in the `ON` clause:
This avoids converting the `LEFT JOIN` into an `INNER JOIN`.

4. **Count orders per user**  
Used `COUNT(o.order_id)` to count valid orders in 2019.
Applied `COALESCE()` to return `0` for users with no matching orders.

5. **Group at user level**  
Grouped by `user_id` and `join_date` to aggregate order counts correctly per user.

6. **Final output**  
Returned:
- `buyer_id`
- `join_date`
- `orders_in_2019`

### 📌 Key Insight
When reporting activity metrics while retaining users with **no activity**, use a **LEFT JOIN** and apply filters in the `ON` clause instead of the `WHERE` clause.
