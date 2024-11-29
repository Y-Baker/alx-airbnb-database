-- Role Table
CREATE TABLE Role (
    role_id INT AUTO_INCREMENT PRIMARY KEY,
    role_name VARCHAR(50) NOT NULL UNIQUE
);

-- Status Table
CREATE TABLE Status (
    status_id INT AUTO_INCREMENT PRIMARY KEY,
    status_name ENUM('Pending', 'Confirmed', 'Canceled') NOT NULL UNIQUE
);

-- Location Table
CREATE TABLE Location (
    location_id UUID PRIMARY KEY,
    country VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    street VARCHAR(255) NOT NULL,
);

-- User Table
CREATE TABLE User (
    user_id UUID PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role_id INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (role_id) REFERENCES Role(role_id)
);

-- Phone Number Table
CREATE TABLE PhoneNumber (
    user_id UUID NOT NULL,
    phone_number VARCHAR(15) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (user_id, phone_number),
    FOREIGN KEY (user_id) REFERENCES User(user_id)
);

-- Property Table
CREATE TABLE Property (
    property_id UUID PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price_per_night DECIMAL(10, 2) NOT NULL,
    location_id UUID NOT NULL,
    host_id UUID NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (location_id) REFERENCES Location(location_id),
    FOREIGN KEY (host_id) REFERENCES User(user_id)
);

-- Booking Table
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    property_id UUID NOT NULL,
    status_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (property_id) REFERENCES Property(property_id),
    FOREIGN KEY (status_id) REFERENCES Status(status_id)
);

-- Payment Table
CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY,
    booking_id UUID NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(255) NOT NULL,
    payment_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

-- Review Table
CREATE TABLE Review (
    review_id UUID PRIMARY KEY,
    user_id UUID NOT NULL,
    property_id UUID NOT NULL,
    rating TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (property_id) REFERENCES Property(property_id)
);


-- Message Table
CREATE TABLE Message (
    message_id UUID PRIMARY KEY,
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    sent_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (sender_id) REFERENCES User(user_id),
    FOREIGN KEY (recipient_id) REFERENCES User(user_id)
);


-- Additional Indexes
CREATE INDEX idx_role_name ON Role(role_name);
CREATE INDEX idx_status_name ON Status(status_name);
CREATE INDEX idx_location_country ON Location(country);
CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_property_location ON Property(location_id);
CREATE INDEX idx_booking_property ON Booking(property_id);
CREATE INDEX idx_payment_booking ON Payment(booking_id);

