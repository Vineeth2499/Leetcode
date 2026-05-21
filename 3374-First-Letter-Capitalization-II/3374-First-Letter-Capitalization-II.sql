SELECT
  content_id,
  content_text AS original_text,
  ARRAY_TO_STRING(ARRAY(
    SELECT ARRAY_TO_STRING(ARRAY(
        SELECT 
          CASE 
            WHEN idx = 1 AND part ~ '^[a-zA-Z]'
            THEN UPPER(LEFT(LOWER(part), 1)) || SUBSTRING(LOWER(part), 2)
            ELSE LOWER(part)
          END
        FROM UNNEST(STRING_TO_ARRAY(word, '-')) WITH ORDINALITY AS t(part, idx)
    ), '-')
    FROM UNNEST(STRING_TO_ARRAY(content_text, ' ')) AS word
  ), ' ') AS converted_text
FROM user_content;
