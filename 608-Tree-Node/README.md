## 🧠 Problem: Classifying Nodes in a Tree

### 🎯 Objective
Determine the type of each node in a tree as one of the following:

- **Root** → Node with no parent  
- **Leaf** → Node with no children  
- **Inner** → Node that is neither root nor leaf  

---

## 🔍 Understanding the Structure

The table contains:

- `id` → current node  
- `p_id` → parent node  

Key observations:

- A **Root** node has `p_id IS NULL`  
- A **Leaf** node does **not appear as a parent** of any node  
- An **Inner** node has both a parent and at least one child  

---

## 💡 Approach

Used a **CASE-based classification + subquery** pattern:

### 1️⃣ Identify Root Node

```sql
p_id IS NULL
