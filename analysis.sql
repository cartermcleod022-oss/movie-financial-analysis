-- Movie Financial Analysis
-- SQL used to analyze movie financial performance, ROI,
-- genre trends, runtime, release decade, and production companies.


-- 1. Overall movie metrics
SELECT
    AVG(vote_average) AS average_rating,
    AVG(TRY_CAST(popularity AS DOUBLE)) AS average_popularity,
    COUNT(*) AS total_movies
FROM movies;


-- 2. Highest rated movies with meaningful vote counts
SELECT
    title,
    vote_average,
    vote_count
FROM movies
WHERE vote_count >= 500
ORDER BY vote_average DESC
LIMIT 10;


-- 3. Most popular movies
SELECT
    title,
    TRY_CAST(popularity AS DOUBLE) AS popularity_numeric
FROM movies
WHERE TRY_CAST(popularity AS DOUBLE) IS NOT NULL
ORDER BY popularity_numeric DESC
LIMIT 10;


-- 4. Movie-level financial performance and ROI
SELECT
    title,
    TRY_CAST(budget AS DOUBLE) AS budget,
    revenue,
    revenue - TRY_CAST(budget AS DOUBLE) AS profit,
    (revenue - TRY_CAST(budget AS DOUBLE))
        / TRY_CAST(budget AS DOUBLE) AS roi,
    TRY_CAST(popularity AS DOUBLE) AS popularity,
    vote_average,
    vote_count
FROM movies
WHERE TRY_CAST(budget AS DOUBLE) > 0
  AND revenue > 0
  AND TRY_CAST(popularity AS DOUBLE) IS NOT NULL;


-- 5. Genre ROI analysis
SELECT
    genre_names,
    COUNT(*) AS movie_count,
    AVG(
        (revenue - TRY_CAST(budget AS DOUBLE))
        / TRY_CAST(budget AS DOUBLE)
    ) AS average_roi,
    MEDIAN(
        (revenue - TRY_CAST(budget AS DOUBLE))
        / TRY_CAST(budget AS DOUBLE)
    ) AS median_roi
FROM genres
WHERE TRY_CAST(budget AS DOUBLE) >= 100000
  AND revenue > 0
GROUP BY genre_names
HAVING COUNT(*) >= 50
ORDER BY average_roi DESC;


-- 6. Runtime ROI analysis
SELECT
    CASE
        WHEN runtime >= 90 AND runtime < 120 THEN '90-119 min'
        WHEN runtime >= 120 AND runtime < 150 THEN '120-149 min'
        WHEN runtime >= 150 AND runtime <= 180 THEN '150-180 min'
    END AS runtime_bucket,
    AVG(
        (revenue - TRY_CAST(budget AS DOUBLE))
        / TRY_CAST(budget AS DOUBLE)
    ) AS average_roi,
    MEDIAN(
        (revenue - TRY_CAST(budget AS DOUBLE))
        / TRY_CAST(budget AS DOUBLE)
    ) AS median_roi,
    COUNT(*) AS movie_count
FROM movies
WHERE runtime >= 90
  AND runtime <= 180
  AND TRY_CAST(budget AS DOUBLE) >= 100000
  AND revenue > 0
GROUP BY runtime_bucket
ORDER BY runtime_bucket;


-- 7. Release decade analysis
SELECT
    FLOOR(YEAR(TRY_CAST(release_date AS DATE)) / 10) * 10
        AS release_decade,
    COUNT(*) AS movie_count,
    AVG(revenue) AS average_revenue,
    AVG(
        (revenue - TRY_CAST(budget AS DOUBLE))
        / TRY_CAST(budget AS DOUBLE)
    ) AS average_roi
FROM movies
WHERE TRY_CAST(release_date AS DATE) IS NOT NULL
  AND TRY_CAST(budget AS DOUBLE) >= 100000
  AND revenue > 0
GROUP BY release_decade
HAVING COUNT(*) >= 20
ORDER BY release_decade;


-- 8. Top production companies by median ROI
SELECT
    company_names,
    COUNT(*) AS movie_count,
    AVG(revenue) AS average_revenue,
    AVG(
        (revenue - TRY_CAST(budget AS DOUBLE))
        / TRY_CAST(budget AS DOUBLE)
    ) AS average_roi,
    MEDIAN(
        (revenue - TRY_CAST(budget AS DOUBLE))
        / TRY_CAST(budget AS DOUBLE)
    ) AS median_roi
FROM companies
WHERE TRY_CAST(budget AS DOUBLE) >= 100000
  AND revenue > 0
GROUP BY company_names
HAVING COUNT(*) >= 10
ORDER BY median_roi DESC
LIMIT 10;
