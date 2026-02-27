# Customers Who Bought All Products

## 📌 Problem Statement

Given two tables:

### Customer
| Column Name | Type |
|-------------|------|
| customer_id | int  |
| product_key | int  |

- May contain duplicate rows.
- `customer_id` is not NULL.
- `product_key` references the `Product` table.

### Product
| Column Name | Type |
|-------------|------|
| product_key | int  |

- `product_key` is the primary key.
- Contains all available products.

### Objective

Return the `customer_id` values of customers who have purchased **all products** listed in the `Product` table.

Return the result in any order.

---

## 🧠 Approach

1. Each customer may have purchased multiple products.
2. To determine if a customer bought *all* products:
   - Count the number of **distinct products purchased by each customer**.
3. Count the total number of products available in the `Product` table.
4. If both counts are equal, it means:
5. Use:
- `GROUP BY customer_id`
- `COUNT(DISTINCT product_key)`
- `HAVING` clause to compare counts

---

## 💡 Key Insight

This is a **set comparison problem**:
- For each customer → compare their purchased product set
- With the complete product set

If sizes match → customer qualifies.
