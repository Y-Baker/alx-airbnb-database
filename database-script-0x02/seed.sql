-- Role Table
INSERT INTO Role (role_name) VALUES 
('Guest'), 
('Host'), 
('Admin');

-- Status Table
INSERT INTO Status (status_name) VALUES 
('Pending'), 
('Confirmed'), 
('Canceled');

-- Location Table
INSERT INTO Location (location_id, country, city, street) VALUES 
(UUID(), 'USA', 'New York', '5th Avenue'), 
(UUID(), 'UK', 'London', 'Baker Street'), 
(UUID(), 'France', 'Paris', 'Champs-Élysées'),
(UUID(), 'Italy', 'Rome', 'Via del Corso').
(UUID(), 'Egypt', 'Cairo', 'Tahrir Square');

-- User Table
INSERT INTO User (user_id, first_name, last_name, email, password_hash, role_id, created_at) VALUES 
(UUID(), 'John', 'Doe', 'john.doe@example.com', 'hashed_password_1', 1, NOW()), 
(UUID(), 'Alice', 'Smith', 'alice.smith@example.com', 'hashed_password_2', 2, NOW()), 
(UUID(), 'Bob', 'Admin', 'admin@example.com', 'hashed_password_3', 3, NOW()),
(UUID(), 'Yousef', 'Ahmed', 'yuossefbakier@gmail.com', 'hashed_password_4', 3, NOW()),
(UUID(), 'Mohamed', 'Ali', 'mohamed@gmail.com', 'hashed_password_5', 2, NOW());


-- Phone Number Table
INSERT INTO PhoneNumber (user_id, phone_number, created_at) VALUES 
((SELECT user_id FROM User WHERE first_name = 'John'), '123-456-7890', NOW()), 
((SELECT user_id FROM User WHERE first_name = 'Alice'), '987-654-3210', NOW());

-- Property Table
INSERT INTO Property (property_id, name, description, price_per_night, location_id, host_id, created_at) VALUES 
(UUID(), 'Cozy Apartment', 'A beautiful apartment in the city center', 150.00, 
    (SELECT location_id FROM Location WHERE city = 'New York'), 
    (SELECT user_id FROM User WHERE first_name = 'Alice'), 
    NOW()), 
(UUID(), 'Luxury Villa', 'A luxurious villa with a private pool', 500.00, 
    (SELECT location_id FROM Location WHERE city = 'Paris'), 
    (SELECT user_id FROM User WHERE first_name = 'Alice'), 
    NOW()),
(UUID(), 'Beach House', 'A cozy beach house with a stunning view', 200.00,
    (SELECT location_id FROM Location WHERE city = 'Cairo'),
    (SELECT user_id FROM User WHERE first_name = 'Yousef'),
    NOW()),
(UUID(), 'Mountain Cabin', 'A rustic cabin in the mountains', 100.00,
    (SELECT location_id FROM Location WHERE city = 'Rome'),
    (SELECT user_id FROM User WHERE first_name = 'Yousef'),
    NOW());


-- Booking Table
INSERT INTO Booking (booking_id, user_id, property_id, status_id, start_date, end_date, total_price, created_at) VALUES 
(UUID(), 
    (SELECT user_id FROM User WHERE first_name = 'John'), 
    (SELECT property_id FROM Property WHERE name = 'Cozy Apartment'), 
    (SELECT status_id FROM Status WHERE status_name = 'Pending'), 
    '2024-12-01', '2024-12-05', 750.00, 
    NOW()), 
(UUID(), 
    (SELECT user_id FROM User WHERE first_name = 'John'), 
    (SELECT property_id FROM Property WHERE name = 'Luxury Villa'), 
    (SELECT status_id FROM Status WHERE status_name = 'Confirmed'), 
    '2024-12-10', '2024-12-15', 2500.00, 
    NOW()),
(UUID(),
    (SELECT user_id FROM User WHERE first_name = 'Alice'),
    (SELECT property_id FROM Property WHERE name = 'Cozy Apartment'),
    (SELECT status_id FROM Status WHERE status_name = 'Canceled'),
    '2024-12-20', '2024-12-25', 750.00,
    NOW());

-- Payment Table
INSERT INTO Payment (payment_id, booking_id, amount, payment_method, payment_date) VALUES 
(UUID(), 
    (SELECT booking_id FROM Booking WHERE total_price = 750.00), 
    750.00, 
    'Credit Card', 
    NOW()), 
(UUID(), 
    (SELECT booking_id FROM Booking WHERE total_price = 2500.00), 
    2500.00, 
    'Bank Transfer', 
    NOW());

-- Review Table
INSERT INTO Review (review_id, user_id, property_id, rating, comment, created_at) VALUES 
(UUID(), 
    (SELECT user_id FROM User WHERE first_name = 'John'), 
    (SELECT property_id FROM Property WHERE name = 'Cozy Apartment'), 
    5, 
    'Amazing place, highly recommended!', 
    NOW()), 
(UUID(), 
    (SELECT user_id FROM User WHERE first_name = 'John'), 
    (SELECT property_id FROM Property WHERE name = 'Luxury Villa'), 
    4, 
    'Great experience, but quite expensive.', 
    NOW());

-- Message Table
INSERT INTO Message (message_id, sender_id, recipient_id, message_body, sent_at) VALUES 
(UUID(), 
    (SELECT user_id FROM User WHERE first_name = 'John'), 
    (SELECT user_id FROM User WHERE first_name = 'Alice'), 
    'Hello, is the Cozy Apartment available for the first week of December?', 
    NOW()), 
(UUID(), 
    (SELECT user_id FROM User WHERE first_name = 'Alice'), 
    (SELECT user_id FROM User WHERE first_name = 'John'), 
    'Yes, it is available. Please confirm your booking.', 
    NOW());

-- End of seed data