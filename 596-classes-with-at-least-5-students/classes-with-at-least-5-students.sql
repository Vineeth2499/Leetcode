SELECT class
FROM (SELECT class,
             COUNT(student) AS student_count
      FROM Courses
      GROUP BY class)
WHERE student_count >= 5;