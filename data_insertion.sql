-- Insert users
INSERT INTO USER (user_id, name, email) VALUES
(1, 'alice', 'alice@example.com'),
(2, 'bob', 'bob@example.com'),
(3, 'charlie', 'charlie@example.com'),
(4, 'dana', 'dana@example.com'),
(5, 'eve', 'eve@example.com');

-- Insert servers
INSERT INTO SERVER (server_id, server_title, server_description, created_at) VALUES
(1, 'Gaming Community', 'A server for gamers', #2023-01-15#),
(2, 'Study Group', 'Server for our study group', #2023-02-20#),
(3, 'Book Club', 'Monthly book discussions', #2023-03-10#);

-- Insert server roles
INSERT INTO SERVER_ROLES (role_id, server_id, role_name, permissions) VALUES
(1, 1, 'Admin', 'Manage server, kick members'),
(2, 1, 'Moderator', 'Delete messages, timeout members'),
(3, 1, 'Member', 'Send messages, join voice'),
(4, 2, 'Admin', 'Manage server, kick members'),
(5, 2, 'Member', 'Send messages'),
(6, 3, 'Admin', 'Manage server, kick members'),
(7, 3, 'Reader', 'Read messages, vote on books');

-- Insert server memberships
INSERT INTO SERVER_MEMBERSHIP (membership_id, server_id, user_id, joined_at, role) VALUES
(1, 1, 1, #2023-01-16#, 'Admin'),
(2, 1, 2, #2023-01-17#, 'Moderator'),
(3, 1, 3, #2023-01-18#, 'Member'),
(4, 2, 1, #2023-02-21#, 'Admin'),
(5, 2, 4, #2023-02-22#, 'Member'),
(6, 3, 5, #2023-03-11#, 'Admin'),
(7, 3, 2, #2023-03-12#, 'Reader');

-- Insert text channels
INSERT INTO TEXT_CHANNEL (text_channel_id, server_id, text_channel_name, text_channel_description) VALUES
(1, 1, 'general', 'General discussions'),
(2, 1, 'announcements', 'Server announcements'),
(3, 2, 'homework-help', 'Help with homework'),
(4, 3, 'book-discussions', 'Discuss current book'),
(5, 3, 'suggestions', 'Book suggestions');

-- Insert channel messages
INSERT INTO TEXT_CHANNEL_MESSAGE (message_id, channel_id, sender_id, content, sent_at) VALUES
(1, 1, 1, 'Welcome everyone to our gaming server!', #2023-01-16 10:00:00#),
(2, 1, 2, 'Thanks for having me!', #2023-01-16 10:05:00#),
(3, 3, 4, 'Can someone help with math problem 5?', #2023-02-23 15:30:00#),
(4, 4, 5, 'What did everyone think of chapter 3?', #2023-03-15 19:00:00#),
(5, 4, 2, 'I loved the plot twist!', #2023-03-15 19:15:00#);

-- Insert friendships
INSERT INTO FRIENDSHIP (friendship_id, user1_id, user2_id, created_at, status) VALUES
(1, 1, 2, #2025-12-01#, 'Confirmed'),
(2, 1, 3, #2025-12-05#, 'Confirmed'),
(3, 2, 4, #2025-01-10#, 'Confirmed'),
(4, 3, 5, #2025-02-01#, 'Pending');

-- Insert channel role visibility
INSERT INTO CHANNEL_ROLE_VISIBILITY (channel_id, role_id) VALUES
(1, 1), (1, 2), (1, 3), -- All roles can see general
(2, 1), (2, 2),         -- Only admins and mods see announcements
(3, 4), (3, 5),         -- All study group roles
(4, 6), (4, 7),         -- All book club roles
(5, 6);                 -- Only admins can see suggestions

-- Insert user role assignments
INSERT INTO USER_ROLE_ASSIGNMENT (user_id, role_id, assigned_at) VALUES
(1, 1, #2025-01-16#),
(2, 2, #2025-01-17#),
(3, 3, #2025-01-18#),
(1, 4, #2025-02-21#),
(4, 5, #2025-02-22#),
(5, 6, #2025-03-11#),
(2, 7, #2025-03-12#);