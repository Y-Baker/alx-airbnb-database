-- Initial complex query
EXPLAIN ANALYZE
SELECT * FROM booking b
JOIN 
    "user" u ON b.user_id = u.user_id
JOIN 
    property p ON b.property_id = p.property_id
LEFT JOIN 
    payment pay ON b.booking_id = pay.booking_id
ORDER BY 
    b.start_date DESC;

-- Refactored query
EXPLAIN ANALYZE
SELECT * FROM booking b
JOIN 
    "user" u ON b.user_id = u.user_id
JOIN 
    property p ON b.property_id = p.property_id
LEFT JOIN 
    payment pay ON b.booking_id = pay.booking_id
WHERE 
    b.start_date >= CURRENT_DATE - INTERVAL '1 year'
ORDER BY 
    b.start_date DESC
LIMIT 100;

-- Add indexes to improve performance
CREATE INDEX IF NOT EXISTS idx_booking_start_date ON booking(start_date);
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON booking(user_id);
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON booking(property_id);
CREATE INDEX IF NOT EXISTS idx_payment_booking_id ON payment(booking_id);

-- Run the refactored query again to see the improvement
EXPLAIN ANALYZE
SELECT * FROM booking b
JOIN 
    "user" u ON b.user_id = u.user_id
JOIN 
    property p ON b.property_id = p.property_id
LEFT JOIN 
    payment pay ON b.booking_id = pay.booking_id
WHERE 
    b.start_date >= CURRENT_DATE - INTERVAL '1 year'
    AND b.property_id IS NULL
    AND b.property_id NOT IN (
        SELECT property_id FROM booking
        WHERE (start_date <= '2023-07-15' AND end_date >= '2023-07-10')
    )
ORDER BY 
    b.start_date DESC
LIMIT 100;
