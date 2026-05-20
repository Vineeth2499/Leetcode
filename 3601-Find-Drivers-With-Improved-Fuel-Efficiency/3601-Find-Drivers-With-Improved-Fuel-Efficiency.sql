SELECT
  d.driver_id,
  d.driver_name,
  ROUND(AVG(CASE WHEN MONTH(t.trip_date) <= 6 THEN t.distance_km / t.fuel_consumed END), 2) AS first_half_avg,
  ROUND(AVG(CASE WHEN MONTH(t.trip_date) >= 7 THEN t.distance_km / t.fuel_consumed END), 2) AS second_half_avg,
  ROUND(AVG(CASE WHEN MONTH(t.trip_date) >= 7 THEN t.distanc_km / t.fuel_consumed END) - 
  AVG(CASE WHEN MONTH(t.trip_date) <= 6 THEN t.distance_km / t/fuel_consumed END), 2) AS efficiency_improvement
FROM
  drivers d
JOIN
  trips t ON d.driver_id = t.driver_id
GROUP BY
  d.driver_id, d.driver_name
HAVING
  COUNT(CASE WHEN MONTH(t.trip_date) <= 6 THEN 1 END) > 0
  AND COUNT(CASE WHEN MONTH(t.trip_date) >= 7 THEN 1 END) > 0
  AND AVG(CASE WHEN MONTH(t.trip_date) >= 7 THEN t/distance_kn / t.fuel_consumed END) >
  AVG(CASE WHEN MONTH(t.trip_date) <= 6 THEN t.distance_km / t.fuel_consumed END)
ORDER BY
  efficiency_improvement DESC,
  d.driver_name ASC;
