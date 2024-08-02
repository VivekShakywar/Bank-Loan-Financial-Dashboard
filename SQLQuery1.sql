select * from [Bank Loan DB]

-- Total Loan Application
select COUNT(id) AS Total_Loan_Application from [Bank Loan DB]

-- Month Wise Loan Application
select YEAR(issue_date) AS Year, Month(issue_date) AS Month, count(id) AS Total_Loan_Application from [Bank Loan DB]
Group by YEAR(issue_date), MONTH(issue_date)
Order by YEAR(issue_date), MONTH(issue_date)
 
 -- Total Funded Amount
select SUM(loan_amount) AS Total_Funded_Amount from [Bank Loan DB]

-- Month Wise Total Funded Amount
select YEAR(issue_date) AS Year, Month(issue_date) AS Month, sum(loan_amount) AS Total_Funded_Amount from [Bank Loan DB]
Group by YEAR(issue_date), MONTH(issue_date)
Order by YEAR(issue_date), MONTH(issue_date)

-- Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM [Bank Loan DB]

-- Month Wise Total Amount Received
Select YEAR(issue_date) AS Year, Month(issue_date) AS Month, SUM(total_payment) from [Bank Loan DB]
Group by YEAR(issue_date), MONTH(issue_date)
Order by YEAR(issue_date), MONTH(issue_date)

-- Average Interest Rate
select concat(round(avg(int_rate)*100,2),'%') as Avg_Int_Rate from [Bank Loan DB]

-- Month Wise Average Interest Rate
select concat(round(avg(int_rate)*100,2),'%') as Avg_Int_Rate from [Bank Loan DB]
Group by YEAR(issue_date), MONTH(issue_date)
Order by YEAR(issue_date), MONTH(issue_date)

-- Average DTI
select YEAR(issue_date), MONTH(issue_date), round(avg(dti),4)*100 as Avg_DTI from [Bank Loan DB]

-- Month Wise Average DTI
select YEAR(issue_date), MONTH(issue_date), round(avg(dti),4)*100 as Avg_DTI from [Bank Loan DB]
group by YEAR(issue_date), MONTH(issue_date)
order by YEAR(issue_date), MONTH(issue_date)

select round(COUNT(CASE when loan_status = 'Fully Paid' or loan_status = 'Current' then id END)*100/
		count(id),2) as Good_Loan_Percentage from [Bank Loan DB]

select count(id) as Good_loan from [Bank Loan DB] 
where loan_status IN ('Fully Paid','Current')

select sum(loan_amount) AS Good_Loan_Funded_Amount from [Bank Loan DB]
where loan_status IN ('Fully Paid','Current')

select round(COUNT(CASE when loan_status = 'Charged off' then id END)*100.0/
		count(id),2) as Bad_Loan_Percentage 
		from [Bank Loan DB]

select COUNT(id) AS Bad_Loan_Applications from [Bank Loan DB]
where loan_status = 'Charged off'

select SUM(total_payment) AS Bad_Loan_Funded_Amount from [Bank Loan DB]
where loan_status = 'Charged Off'

select SUM(loan_amount) AS Bad_Loan_Funded_Amount_Received from [Bank Loan DB]
where loan_status = 'Charged Off'


-- Loan_Status
select 
loan_status AS Loan_Status,
count(id) AS LoanCount,
sum(total_payment) AS Total_Amount_Received,
sum(loan_amount) AS Total_Funded_Amount,
Avg(int_rate)*100 AS Interest_Rate,
Avg(dti)*100 AS DTI
FROM [Bank Loan DB]
group by loan_status


SELECT 
	MONTH(issue_date) AS Month_Munber, 
	DATENAME(MONTH, issue_date) AS Month_name, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan DB]
GROUP BY MONTH(issue_date), DATENAME(MONTH, issue_date)
ORDER BY MONTH(issue_date)


Select
address_state AS State,
count(id) AS Total_Loan_Application,
sum(loan_amount) AS Total_Funded_Amount,
sum(total_payment) AS Total_Amount_Received
from [Bank Loan DB]
group by address_state
order by address_state


SELECT 
	term AS Term, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan DB]
GROUP BY term
ORDER BY term


SELECT 
	emp_length AS Employee_Length, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan DB]
GROUP BY emp_length
ORDER BY emp_length


SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan DB]
GROUP BY purpose
ORDER BY purpose


SELECT 
	home_ownership AS Home_Ownership, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan DB]
GROUP BY home_ownership
ORDER BY home_ownership

-- I have applied multiple filters to all the dashboards. You can check the results for the filters as well by modifying the query and comparing the results.
-- For e.g
-- See the results when we hit the Grade A in the filters for dashboards.

SELECT 
	purpose AS PURPOSE, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM [Bank Loan DB]
WHERE grade = 'A'
GROUP BY purpose
ORDER BY purpose






