-- Write a query to display car id, car name and owner id of all the cars whose car type is 'Hatchback' or 'SUV'.
-- Sort the result based on car id.

SELECT car_id, car_name, owner_id
FROM cars
WHERE car_type IN ('Hatchback','SUV')
ORDER BY car_id;

-- Write a query to display car id, car name and car type of Maruthi company 'Sedan' type cars.
-- Sort the result based on car id.

SELECT car_id, car_name, car_type
FROM cars
WHERE car_name = 'Maruthi Swift' AND car_type = 'Sedan'
ORDER BY car_id;

SELECT car_id, car_name, car_type
FROM cars
WHERE car_name LIKE 'Maruthi%' and car_type = 'Sedan'
ORDER BY car_id;

-- Refer to the given schema. Assume, CARS table has been already created.
-- Write an appropriate query for the given requirement.  
-- Requirement 1: Add a new column Car_Regno VARCHAR(10)  to the Cars table.

ALTER TABLE cars ADD Car_Regno VARCHAR(10);

-- Refer to the given schema.
-- Write a query to create the Owners table with the specified columns and constraints.

CREATE TABLE owners(
    owner_id VARCHAR(10) PRIMARY KEY,
    owner_name VARCHAR(20),
    address VARCHAR(20),
    phone_no BIGINT,
    email_id VARCHAR(20)
);

-- Refer to the given schema diagram. Insert the below records into Rentals Table. Assume the rentals table has been already created.

INSERT INTO rentals
VALUES
    ("R001", "C007", "V004", "2018-03-10", "2018-03-10", 800, 9000),
    ("R002", "C001", "V007", "2018-03-11", "2018-03-12", 200, 3000),
    ("R003", "C007", "V003", "2018-04-15", "2018-04-15", 100, 1500),
    ("R004", "C007", "V001", "2018-05-16", "2018-05-18", 1000, 10000),
    ("R005", "C004", "V005", "2018-05-10", "2018-05-12", 900, 11000),
    ("R006", "C004", "V006", "2018-05-20", "2018-05-21", 200, 2500);

-- Write a query to display car id, car name, car type of cars which was not taken for rent.
-- Sort the result based on car id.

SELECT car_id, car_name, car_type
FROM cars
WHERE car_id NOT IN (
    SELECT car_id
    FROM rentals
    WHERE car_id IS NOT NULL
)
ORDER BY car_id;

-- Write a query to display the username and password of all owners.
-- Give an alias name as USERNAME and PASSWORD.
-- Sort the result based on the username in ascending order.

SELECT CONCAT(owner_name,owner_id) as USERNAME, CONCAT(SUBSTRING(owner_name,1,3),owner_id) as PASSWORD
FROM owners
ORDER BY USERNAME;

-- Write a query to display distinct owner id, owner name, address, and phone no of owners who owns 'Maruthi' company car.
-- Sort the result based on owner id.

SELECT DISTINCT owner_id,owner_name, address, phone_no
FROM owners
WHERE owner_id IN (SELECT DISTINCT owner_id FROM cars WHERE car_name LIKE 'Maruthi%')
ORDER BY owner_id;

-- Write a query to display car id and number of times car taken for rental.
-- Give an alias name to the number of times car taken for rental as 'NO_OF_TRIPS'.
-- Sort the records based on car id in ascending order.

SELECT car_id, COUNT(car_id) as NO_OF_TRIPS
FROM rentals
GROUP BY car_id
ORDER BY car_id;

-- Write a query to display rental id, car id, customer id and km driven of rentals taken during 'AUGUST 2019'.
-- Sort the result based on rental id.

SELECT rental_id, car_id, customer_id, km_driven
FROM rentals
WHERE MONTH(pickup_date) = 8 AND YEAR(pickup_date) = 2019
ORDER BY rental_id;

