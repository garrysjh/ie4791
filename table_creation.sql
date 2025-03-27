-- Create USER table
CREATE TABLE USER (
    user_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE
);

-- Create SERVER table
CREATE TABLE SERVER (
    server_id INT PRIMARY KEY,
    server_title VARCHAR(100) NOT NULL,
    server_description TEXT,
    created_at DATE NOT NULL
);

-- Create SERVER_ROLES table
CREATE TABLE SERVER_ROLES (
    role_id INT PRIMARY KEY,
    server_id INT NOT NULL,
    role_name VARCHAR(50) NOT NULL,
    permissions TEXT,
    FOREIGN KEY (server_id) REFERENCES SERVER(server_id)
);

-- Create SERVER_MEMBERSHIP table
CREATE TABLE SERVER_MEMBERSHIP (
    membership_id INT PRIMARY KEY,
    server_id INT NOT NULL,
    user_id INT NOT NULL,
    joined_at DATE NOT NULL,
    role VARCHAR(50),
    FOREIGN KEY (server_id) REFERENCES SERVER(server_id),
    FOREIGN KEY (user_id) REFERENCES USER(user_id),
    UNIQUE (server_id, user_id)
);

-- Create TEXT_CHANNEL table
CREATE TABLE TEXT_CHANNEL (
    text_channel_id INT PRIMARY KEY,
    server_id INT NOT NULL,
    text_channel_name VARCHAR(100) NOT NULL,
    text_channel_description TEXT,
    FOREIGN KEY (server_id) REFERENCES SERVER(server_id)
);

-- Create TEXT_CHANNEL_MESSAGE table
CREATE TABLE TEXT_CHANNEL_MESSAGE (
    message_id INT PRIMARY KEY,
    channel_id INT NOT NULL,
    sender_id INT NOT NULL,
    content TEXT NOT NULL,
    sent_at DATETIME NOT NULL,
    FOREIGN KEY (channel_id) REFERENCES TEXT_CHANNEL(text_channel_id),
    FOREIGN KEY (sender_id) REFERENCES USER(user_id)
);

-- Create FRIENDSHIP table
CREATE TABLE FRIENDSHIP (
    friendship_id INT PRIMARY KEY,
    user1_id INT NOT NULL,
    user2_id INT NOT NULL,
    created_at DATE NOT NULL,
    status VARCHAR(20) NOT NULL,
    FOREIGN KEY (user1_id) REFERENCES USER(user_id),
    FOREIGN KEY (user2_id) REFERENCES USER(user_id),
    CHECK (user1_id < user2_id) -- Ensures no duplicate friendships
);

-- Junction table for channel visibility to roles
CREATE TABLE CHANNEL_ROLE_VISIBILITY (
    channel_id INT NOT NULL,
    role_id INT NOT NULL,
    PRIMARY KEY (channel_id, role_id),
    FOREIGN KEY (channel_id) REFERENCES TEXT_CHANNEL(text_channel_id),
    FOREIGN KEY (role_id) REFERENCES SERVER_ROLES(role_id)
);

-- Junction table for user role assignments
CREATE TABLE USER_ROLE_ASSIGNMENT (
    user_id INT NOT NULL,
    role_id INT NOT NULL,
    assigned_at DATE NOT NULL,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES USER(user_id),
    FOREIGN KEY (role_id) REFERENCES SERVER_ROLES(role_id)
);