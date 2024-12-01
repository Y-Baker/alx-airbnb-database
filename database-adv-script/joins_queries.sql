-- INNER JOIN to retrieve all bookings and the respective users who made those bookings.
SELECT * FROM bookings b
INNER JOIN users u
ON b.user_id = u.user_id;

-- LEFT JOIN to retrieve all properties and their reviews, including properties that have no reviews.
SELECT * FROM properties p
LEFT JOIN reviews r
ON p.property_id = r.property_id;

-- FULL OUTER JOIN to retrieve all users and all bookings, even if the user has no booking or a booking is not linked to a user.
SELECT * FROM users u
FULL OUTER JOIN bookings b
ON u.user_id = b.user_id;

