/* EXAMPLE QUERIES */
-- List of Friends for each User
SELECT 
    u1.user_id AS user_id,
    u1.name AS user_name,
    u2.user_id AS friend_id,
    u2.name AS friend_name,
    f.status,
    f.created_at
FROM 
    USER u1
JOIN 
    FRIENDSHIP f ON u1.user_id = f.user1_id OR u1.user_id = f.user2_id
JOIN 
    USER u2 ON (u1.user_id = f.user1_id AND u2.user_id = f.user2_id) 
             OR (u1.user_id = f.user2_id AND u2.user_id = f.user1_id)
ORDER BY 
    u1.user_id, u2.name;
-- Messages by Channel
SELECT 
    s.server_title,
    tc.text_channel_name,
    COUNT(tcm.message_id) AS message_count,
    MAX(tcm.sent_at) AS last_message_date
FROM 
    SERVER s
JOIN 
    TEXT_CHANNEL tc ON s.server_id = tc.server_id
LEFT JOIN 
    TEXT_CHANNEL_MESSAGE tcm ON tc.text_channel_id = tcm.channel_id
GROUP BY 
    s.server_title, tc.text_channel_name
ORDER BY 
    s.server_title, message_count DESC;
-- User participation by server
SELECT 
    u.name AS user_name,
    COUNT(DISTINCT sm.server_id) AS servers_joined,
    COUNT(DISTINCT CASE WHEN sr.role_name = 'Admin' THEN sm.server_id END) AS servers_admin,
    COUNT(DISTINCT tcm.message_id) AS messages_sent
FROM 
    USER u
LEFT JOIN 
    SERVER_MEMBERSHIP sm ON u.user_id = sm.user_id
LEFT JOIN 
    USER_ROLE_ASSIGNMENT ura ON u.user_id = ura.user_id
LEFT JOIN 
    SERVER_ROLES sr ON ura.role_id = sr.role_id
LEFT JOIN 
    TEXT_CHANNEL_MESSAGE tcm ON u.user_id = tcm.sender_id
GROUP BY 
    u.user_id, u.name
ORDER BY 
    messages_sent DESC;
-- Channel Visibility Report
SELECT 
    s.server_title,
    tc.text_channel_name,
    STRING_AGG(sr.role_name, ', ') AS visible_to_roles
FROM 
    TEXT_CHANNEL tc
JOIN 
    SERVER s ON tc.server_id = s.server_id
LEFT JOIN 
    CHANNEL_ROLE_VISIBILITY crv ON tc.text_channel_id = crv.channel_id
LEFT JOIN 
    SERVER_ROLES sr ON crv.role_id = sr.role_id
GROUP BY 
    s.server_title, tc.text_channel_name
ORDER BY 
    s.server_title, tc.text_channel_name;