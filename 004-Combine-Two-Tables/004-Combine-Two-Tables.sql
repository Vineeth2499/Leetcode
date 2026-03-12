SELECT
  first_name,
  last_name,
  city,
  state
FROM
  Person p
LEFT JOIN
  Address a ON p.person_id = a.person_id
