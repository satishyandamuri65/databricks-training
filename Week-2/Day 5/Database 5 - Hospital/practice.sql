-- Write a query to display unique patient id, patient first name, patient age, address and contact number of all the patients who booked appointments in the month of JUNE 2019.
-- Sort the records based on patient id.

SELECT DISTINCT P.PATIENT_ID, P.P_FIRST_NAME, P.P_AGE, P.ADDRESS, P.CONTACT_NUMBER
FROM PATIENT P, APPOINTMENT A
WHERE P.PATIENT_ID = A.PATIENT_ID
    AND MONTH(A.APP_DATE) = 6
    AND YEAR(A.APP_DATE) = 2019
ORDER BY P.PATIENT_ID;

-- Write a query to display the patient id, patient first name, patient age, appointment number and the date of appointment of those patients whose reason for the appointment is 'FEVER'.
-- Sort the records based on patient id.

SELECT p.PATIENT_ID, p.P_FIRST_NAME, p.P_AGE, a.APP_NUMBER, a.APP_DATE
FROM PATIENT p
INNER JOIN APPOINTMENT a
ON p.PATIENT_ID = a.PATIENT_ID
WHERE APP_REASON = 'FEVER'
ORDER BY p.PATIENT_ID;