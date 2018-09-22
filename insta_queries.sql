-- Reward oldest users. make sure that they are active
SELECT 
    users.username, 
    users.created_at, 
    COUNT(photos.id) AS nphotos,
    MAX(photos.created_at) AS latest_post
FROM users
JOIN photos
    ON users.id = photos.user_id
GROUP BY users.id
ORDER BY users.created_at DESC LIMIT 5;

-- Figure out which day of the week most users regist on
SELECT
    COUNT(id) n_users,
    DAYNAME(created_at) AS day_of_week
FROM users
GROUP BY day_of_week
ORDER BY n_users DESC;

-- Figurte out which users never posted a photo
SELECT
    users.username
FROM users
LEFT JOIN photos
    ON users.id = photos.user_id
WHERE photos.id IS NULL;


-- Identify most popular photo and the user who posted it
-- Approach one, top 10 photos, COUNT()
-- photourl | username | totallikes
SELECT 
    photos.image_url,
    users.username,
    COUNT(likes.user_id) AS totallikes
FROM likes
JOIN photos ON photos.id = likes.photo_id
JOIN users ON users.id = photos.user_id
GROUP BY photos.id
ORDER BY totallikes DESC
LIMIT 10;

-- How many times does the average user post
-- | Average |
SELECT (
    (SELECT COUNT(*) FROM photos) / ( SELECT COUNT(*) FROM users)
) AS average;

-- What are the 5 most popular hashtags
-- tag_name | timesused
SELECT 
    tags.tag_name,
    COUNT(photo_tags.tag_id) AS timesused
FROM photo_tags
INNER JOIN tags
    ON photo_tags.tag_id = tags.id
GROUP BY tags.id
ORDER BY timesused DESC
LIMIT 10;

-- Find users who have liked every photo on the site
-- | username |
SELECT
    COUNT(*) AS likedtimes,
    username
FROM likes
JOIN users ON users.id = likes.user_id
GROUP by users.id
HAVING likedtimes = (
    SELECT COUNT(*) FROM photos
);