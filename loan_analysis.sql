SELECT * FROM dataset_loan LIMIT 10;
-- How many total loans are there? What is the average interest rate and average FICO score?
SELECT COUNT(*) AS total_loans,
       ROUND(AVG(`int.rate`), 4) AS avg_interest_rate,
       ROUND(AVG(fico), 0) AS avg_fico_score
FROM dataset_loan;
-- as we can see total loans is 100 and average fico score is 727.
-- 2) How many loans exist for each loan purpose? Sort from highest to lowest.
SELECT purpose,
       COUNT(*) AS total_loans
FROM dataset_loan
GROUP BY purpose
ORDER BY total_loans DESC;
-- 3) What is the average interest rate for each loan purpose? Sort from highest to lowest
SELECT purpose,
       ROUND(AVG(`int.rate`), 4) AS avg_rate
FROM dataset_loan
GROUP BY purpose
ORDER BY avg_rate DESC
LIMIT 10;

-- 4) How many loans were fully paid vs not fully paid? Сount and percentage for each group;
SELECT ('not_fully_paid'),
       COUNT(*) AS total,
       ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM dataset_loan), 1) AS percentage
FROM dataset_loan
GROUP BY not_fully_paid;

-- 5) Which loan purpose has the highest default rate? Show total loans, number of defaults, and default percentage for each purpose.
SELECT purpose,
       COUNT(*) AS total_loans,
       SUM(`not.fully.paid`) AS defaults,
       ROUND(AVG(`not.fully.paid`) * 100, 1) AS default_rate_pct
FROM dataset_loan
GROUP BY purpose
ORDER BY default_rate_pct DESC;

-- 6) Find all borrowers who did NOT fully pay their loan AND have a FICO score below 700. Sort by FICO score ascending;
SELECT purpose, fico, `int.rate`, `not.fully.paid`
FROM dataset_loan
WHERE `not.fully.paid` = 1
  AND fico < 750
ORDER BY fico ASC;

-- 7)Which 10 loans have the highest interest rates? Show purpose, FICO score, interest rate, and whether they defaulted.
SELECT purpose, fico, `int.rate`, 'not_fully_paid'
FROM dataset_loan
ORDER BY `int.rate` DESC
LIMIT 10;

-- 8)For each loan purpose with more than 2 loans, show the total count, average FICO score, average interest rate, 
-- and default percentage. Sort by default percentage descending.
SELECT purpose,
       COUNT(*) AS total_loans,
       ROUND(AVG(fico), 0) AS avg_fico,
       ROUND(AVG(`int.rate`), 4) AS avg_rate,
       ROUND(AVG('not_fully_paid') * 100, 1) AS default_pct
FROM dataset_loan
GROUP BY purpose
HAVING COUNT(*) > 2
ORDER BY default_pct DESC;










