CREATE TABLE booking_partitioned (
    booking_id UUID PRIMARY KEY,
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) PARTITION BY RANGE (start_date);

-- Create partitions for the last 4 years
CREATE TABLE booking_y2020 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2020-01-01') TO ('2021-01-01');
CREATE TABLE booking_y2021 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2021-01-01') TO ('2022-01-01');

CREATE TABLE booking_y2022 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2022-01-01') TO ('2023-01-01');

CREATE TABLE booking_y2023 PARTITION OF booking_partitioned
    FOR VALUES FROM ('2023-01-01') TO ('2024-01-01');

CREATE TABLE booking_future PARTITION OF booking_partitioned
    FOR VALUES FROM ('2024-01-01') TO (MAXVALUE);

-- Create indexes 
CREATE INDEX idx_booking_partitioned_start_date ON booking_partitioned (start_date);
CREATE INDEX idx_booking_partitioned_property_id ON booking_partitioned (property_id);
CREATE INDEX idx_booking_partitioned_user_id ON booking_partitioned (user_id);


INSERT INTO booking_partitioned SELECT * FROM booking;

EXPLAIN ANALYZE
SELECT *
FROM booking_partitioned
WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31'
ORDER BY start_date DESC
LIMIT 100;

-- Compare with a query on the original table
EXPLAIN ANALYZE
SELECT *
FROM booking
WHERE start_date BETWEEN '2023-01-01' AND '2023-12-31'
ORDER BY start_date DESC
LIMIT 100;
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