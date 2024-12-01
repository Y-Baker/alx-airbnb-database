-- Write a query to find all properties where the average rating is greater than 4.0 using a subquery
SELECT * FROM Property p
WHERE (
    SELECT AVG(rating)
    FROM Review
    WHERE property_id = p.property_id
) > 4.0;

-- Write a correlated subquery to find users who have made more than 3 bookings
SELECT * FROM User u
WHERE (
    SELECT COUNT(*)
    FROM Booking
    WHERE user_id = u.user_id
) > 3;
