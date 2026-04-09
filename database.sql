CREATE DATABASE HotelBookingDB;
USE HotelBookingDB;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    phone VARCHAR(15),
    city VARCHAR(50)
);

CREATE TABLE Rooms (
    room_id INT PRIMARY KEY,
    room_type VARCHAR(30),
    price DECIMAL(10,2),
    status VARCHAR(20)
);

CREATE TABLE Bookings (
    booking_id INT PRIMARY KEY,
    customer_id INT,
    room_id INT,
    check_in DATE,
    check_out DATE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);

CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    booking_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    FOREIGN KEY (booking_id) REFERENCES Bookings(booking_id)
);

DELIMITER //
CREATE PROCEDURE CheckAvailability(
    IN p_check_in DATE,
    IN p_check_out DATE
)
BEGIN
    SELECT room_id, room_type
    FROM Rooms
    WHERE room_id NOT IN (
        SELECT room_id
        FROM Bookings
        WHERE (check_in < p_check_out AND check_out > p_check_in)
    );
END //
DELIMITER ;
