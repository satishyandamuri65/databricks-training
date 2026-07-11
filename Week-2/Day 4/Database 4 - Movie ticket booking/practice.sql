-- Write a query to display the minimum discount amount and the maximum discount amount offered as per the coupon.
-- Give an alias name as MIN_DISCOUNT to the minimum discount amount and MAX_DISCOUNT to the maximum discount amount.

SELECT MIN(discount_amount) AS MIN_DISCOUNT, MAX(discount_amount) AS MAX_DISCOUNT
FROM discount_master;

-- Write a query to display the user id and number of time tickets was booked by each user.
-- Give an alias name as no_of_times. Sort the result based on the user_id.

SELECT customer_id, COUNT(customer_id) as no_of_times
FROM booking_details
GROUP BY customer_id
ORDER BY customer_id;

