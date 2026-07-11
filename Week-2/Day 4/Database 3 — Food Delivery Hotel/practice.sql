-- Write a query to display the customer id, customer name and contact details of customers.
-- If address is missing, display the email id. If both address and email is missing then display ‘NA’.
-- Give an alias name as CONTACT_DETAILS.Sort the results based on customer id in ascending order.

SELECT customer_id, customer_name, COALESCE(address,email_id,'NA') as CONTACT_DETAILS
FROM customers
ORDER BY customer_id;


-- Refer to the schema. Write a query to display the customer mail details.
-- Display the details in the below format.
-- Give an alias name as CUSTOMER_MAIL_INFO. Sort the result in ascending order.

SELECT CONCAT(customer_id,' mail id is ', email_id) as CUSTOMER_MAIL_INFO
FROM customers
ORDER BY CUSTOMER_MAIL_INFO;

-- Write a query to display customer id, customer name, address, and phone number of customers having Gmail id.
-- Sort the result based on customer id.

SELECT customer_id, customer_name, address, phone_no
FROM customers
WHERE email_id LIKE '%@gmail.%'
ORDER BY customer_id;

-- Write a query to display partner id, partner name, phone number of delivery partners whose rating is between 3 to 5.
-- sort the result based on partner id.

SELECT partner_id, partner_name, phone_no
FROM delivery_partners
WHERE rating BETWEEN 3 AND 5
ORDER BY partner_id;

-- Refer to the schema. Write a query to display the hotel name along with the type.
-- Give an alias name as `hotel_info`. Sort the result in descending order.

SELECT CONCAT(hotel_name,' is a ',hotel_type,' hotel') as hotel_info
FROM hotel_details
ORDER BY hotel_info DESC;

-- Write a query to display hotel id, hotel name and hotel type of hotels which has not taken any orders in the month of 'MAY 19'.
-- Sort the result based on hotel id in ascending order.

SELECT hotel_id, hotel_name, hotel_type
FROM hotel_details
WHERE hotel_id NOT IN (
    SELECT hotel_id
    FROM orders
    WHERE MONTH(order_date) = 5 and YEAR(order_date) = 2019 AND hotel_id IS NOT NULL)
ORDER BY hotel_id;

-- Write a query to display distinct hotel id, hotel name, and rating of hotels that have taken order in the month of July.
-- Sort the result based on hotel id in ascending order.

SELECT DISTINCT h.hotel_id, h.hotel_name, h.rating
FROM hotel_details h
INNER JOIN orders o ON h.order_id = o.order_id
WHERE MONTH(o.order_date) = 7
ORDER BY h.hotel_id;

-- Hotels that took order more than five times

SELECT o.hotel_id, h.hotel_name, COUNT(o.order_id) AS no_of_orders
FROM hotel_details h
INNER JOIN orders o
ON o.hotel_id =  h.hotel_id
GROUP BY o.hotel_id, h.hotel_name
HAVING no_of_orders > 5;

-- Write a query to change the data type of the field customer_id in Customers table to int.

ALTER TABLE customers MODIFY COLUMN customer_id INT;

-- Change the name of the existing field Rating to Hotel_Rating in the  Hotel_Details table.

ALTER TABLE hotel_details CHANGE rating Hotel_Rating INT;

-- Update records based on the given requirement.
-- Requirement 1: update the phone no of the Customers whose id is 'CUST1004' to the new phone no  '9876543210'

UPDATE customers SET phone_no = 9876543210 
WHERE customer_id = 'CUST1004';

-- Write a query to display order id, customer name, hotel name, and order amount of all orders.
-- Sort the result based on order id in ascending order.

SELECT o.order_id, c.customer_name, h.hotel_name, o.order_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id
INNER JOIN hotel_details h  ON h.hotel_id = o.hotel_id
ORDER BY o.order_id; 

-- Write a query to display partner id,partner name and review of the delivery partner, give alias name for partner review as 'REVIEW'.
-- sort the result based on partner id in ascending order.

SELECT partner_id, partner_name, (
    CASE 
    WHEN rating >= 4 THEN 'GOOD'
    WHEN rating >=2 AND rating < 4 THEN 'AVERAGE'
    ELSE 'WORST'
    END
) AS REVIEW
FROM delivery_partners
ORDER BY partner_id;

-- Write a query to display order_date, total order amount in each day. Give an alias name for total order amount as ‘TOTAL_SALE’.
-- Sort the result based on order_date.

SELECT order_date, SUM(order_amount) as TOTAL_SALE
FROM orders
GROUP BY order_date
ORDER BY order_date;