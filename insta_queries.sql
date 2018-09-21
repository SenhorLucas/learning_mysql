-- Reward oldest users. make sure that they are active
SELECT 
    users.username, 
    users.created_at, 
    COUNT(photos.id) AS nphotos
    MAX(photos.created_at) AS latest_post
FROM users
JOIN photos
    ON users.id = photos.user_id
GROUP BY users.id
ORDER BY users.created_at DESC LIMIT 5;