WITH no_return AS
(
    SELECT
      l.book_id,
      title,
      author,
      genre,
      publication_year,
      total_copies,
      COUNT(borrower_name) AS current_borrowers
    FROM
      library_books l
    LEFT JOIN
      borrowing_records r
    ON
      l.book_id = r.book_id
    WHERE
      return_date IS NULL
    GROUP BY
      1, 2, 3, 4, 5, 6
)
SELECT
  book_id,
  title,
  author,
  genre,
  publication_year,
  current_borrowers
FROM
  no_return
WHERE
  total_copies - current_borrowers = 0
ORDER BY
  current_borrowers DESC, title ASC
