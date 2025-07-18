use social_media;

-- 1.Which platform has the highest average engagement (likes + comments + shares)?
SELECT platform, 
       AVG(likes + comments + shares) AS avg_total_engagement
FROM social_media_engagement1
GROUP BY platform
ORDER BY avg_total_engagement DESC;

-- 2.How does engagement vary across platforms for different post types?
SELECT post_type, platform, 
       AVG(likes + comments + shares) AS avg_engagement
FROM social_media_engagement1
GROUP BY post_type,platform
ORDER BY avg_engagement DESC;

-- 3.What type of content (image, video, carousel, poll) generates the most engagement?
SELECT platform, post_type, 
       AVG(likes + comments + shares) AS avg_engagement
FROM social_media_engagement1
GROUP BY platform, post_type
ORDER BY platform, avg_engagement DESC;


-- 4.List all unique post types used in the dataset?
SELECT DISTINCT post_type
FROM social_media_engagement1;

-- 5.Which day of the week sees the highest engagement overall?
SELECT post_day, 
       AVG(likes + comments + shares) AS avg_engagement
FROM social_media_engagement1
GROUP BY post_day
ORDER BY avg_engagement DESC;


-- 6.What time of day (morning, afternoon, night) is best for posting?
SELECT
  CASE
    WHEN EXTRACT(HOUR FROM post_time) BETWEEN 5 AND 11 THEN 'morning'
    WHEN EXTRACT(HOUR FROM post_time) BETWEEN 12 AND 16 THEN 'afternoon'
    WHEN EXTRACT(HOUR FROM post_time) BETWEEN 17 AND 20 THEN 'evening'
    ELSE 'night'
  END AS time_of_day,
  AVG(likes + comments + shares) AS avg_engagement
FROM social_media_engagement1
GROUP BY time_of_day
ORDER BY avg_engagement DESC;


-- 7.What is the most common post type on Instagram?
SELECT post_type, COUNT(*) AS count
FROM social_media_engagement1
WHERE platform = 'Instagram'
GROUP BY post_type
ORDER BY count DESC
LIMIT 1;

-- 8.Which platform gets more comments relative to likes?
SELECT platform, 
       AVG(CAST(comments AS FLOAT) / likes) AS avg_comment_like_ratio
FROM social_media_engagement1
GROUP BY platform
ORDER BY avg_comment_like_ratio DESC;

-- 9.Are polls getting more shares compared to other types of posts?
SELECT post_type, 
       AVG(shares) AS avg_shares
FROM social_media_engagement1
GROUP BY post_type
ORDER BY avg_shares DESC;

-- 10.Do positive posts consistently get more likes than neutral or negative ones?
SELECT sentiment_score, 
       AVG(likes) AS avg_likes
FROM social_media_engagement1
GROUP BY sentiment_score
ORDER BY avg_likes DESC;

-- 11.Is there any platform where negative sentiment posts perform better?
SELECT platform, 
       AVG(likes + comments + shares) AS avg_engagement
FROM social_media_engagement1
WHERE sentiment_score = 'negative'
GROUP BY platform
ORDER BY avg_engagement DESC;

-- 12.How many posts have more than 1000 likes?
SELECT COUNT(*) AS posts_above_1000_likes
FROM social_media_engagement1
WHERE likes > 1000;

-- 13.Do posts on weekends perform better than weekdays?
SELECT 
  CASE 
    WHEN post_day IN ('Saturday', 'Sunday') THEN 'Weekend'
    ELSE 'Weekday'
  END AS day_type,
  AVG(likes + comments + shares) AS avg_engagement
FROM social_media_engagement1
GROUP BY day_type;

-- 14.If you wanted to increase shares, what post type and day would you recommend?

-- (Use to explore top shared post types on top performing days/platforms)
SELECT platform, post_day, post_type, 
       AVG(shares) AS avg_shares
FROM social_media_engagement1
GROUP BY platform, post_day, post_type
ORDER BY avg_shares DESC
LIMIT 5;

-- 15.What platform and post type combination would be best for boosting comments?
SELECT platform, post_type, 
       AVG(comments) AS avg_comments
FROM social_media_engagement1
GROUP BY platform, post_type
ORDER BY avg_comments DESC
LIMIT 5;

-- 16.Which platform has the most consistent engagement across all post types?
SELECT platform, 
       COUNT(DISTINCT post_type) AS type_count,
       ROUND(STDDEV(likes + comments + shares), 2) AS engagement_variance
FROM social_media_engagement1
GROUP BY platform
ORDER BY engagement_variance ASC;

-- 17.Are there noticeable differences in engagement for similar sentiment posts across platforms?
SELECT platform, sentiment_score, 
       AVG(likes + comments + shares) AS avg_engagement
FROM social_media_engagement1
GROUP BY platform, sentiment_score
ORDER BY platform, avg_engagement DESC;

-- 18.Which post got the most comments?
SELECT *
FROM social_media_engagement1
ORDER BY comments DESC
LIMIT 1;


-- 19.Show top 5 posts with the highest total engagement (likes + comments + shares)?
SELECT *, (likes + comments + shares) AS total_engagement
FROM social_media_engagement1
ORDER BY total_engagement DESC
LIMIT 5;

-- 20. How many posts were made on each post type?
SELECT post_type, COUNT(*) AS number_of_posts
FROM social_media_engagement1
GROUP BY post_type;
