// Identify high-usage columns in your User, Booking, and Property tables (e.g., columns used in WHERE, JOIN, ORDER BY clauses).

- User Table:
    - email
    - role_id
    - first_name
    - last_name

- Booking Table:
    - user_id
    - property_id
    - start_date
    - end_date

- Property Table:
    - user_id
    - name

```sql
CREATE INDEX idx_role_name ON Role(role_name);
CREATE INDEX idx_status_name ON Status(status_name);
CREATE INDEX idx_location_country ON Location(country);
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_property_location ON Property(location_id);
CREATE INDEX idx_booking_property ON Booking(property_id);
CREATE INDEX idx_payment_booking ON Payment(booking_id);
```

// Measure the query performance before and after adding indexes using EXPLAIN or ANALYZE.

```sql
EXPLAIN SELECT * FROM User WHERE email = 'test@gmail.com';
EXPLAIN SELECT * FROM Booking WHERE user_id = '1231';
```