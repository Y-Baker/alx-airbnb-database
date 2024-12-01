-- Measure performance before adding indexes
EXPLAIN ANALYZE SELECT * FROM property WHERE location = 'New York, NY';
EXPLAIN ANALYZE SELECT * FROM booking WHERE user_id = 'user_uuid_here';
EXPLAIN ANALYZE 
SELECT p.* FROM property p
LEFT JOIN booking b ON p.property_id = b.property_id
WHERE b.property_id IS NULL
   OR b.property_id NOT IN (
      SELECT property_id FROM booking
      WHERE (start_date <= '2023-07-15' AND end_date >= '2023-07-10')
   );

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_user_email ON "user" (email);
CREATE INDEX IF NOT EXISTS idx_user_role ON "user" (role);
CREATE INDEX IF NOT EXISTS idx_property_host_id ON property (host_id);
CREATE INDEX IF NOT EXISTS idx_property_location ON property (location);
CREATE INDEX IF NOT EXISTS idx_property_price ON property (price_per_night);
CREATE INDEX IF NOT EXISTS idx_booking_user_id ON booking (user_id);
CREATE INDEX IF NOT EXISTS idx_booking_property_id ON booking (property_id);
CREATE INDEX IF NOT EXISTS idx_booking_dates ON booking (start_date, end_date);
CREATE INDEX IF NOT EXISTS idx_booking_status ON booking (status);

-- Measure performance after adding indexes
EXPLAIN ANALYZE SELECT * FROM property WHERE location = 'New York, NY';
EXPLAIN ANALYZE SELECT * FROM booking WHERE user_id = 'user_uuid_here';
EXPLAIN ANALYZE 
SELECT p.* FROM property p
LEFT JOIN booking b ON p.property_id = b.property_id
WHERE b.property_id IS NULL
   OR b.property_id NOT IN (
      SELECT property_id FROM booking
      WHERE (start_date <= '2023-07-15' AND end_date >= '2023-07-10')
   );