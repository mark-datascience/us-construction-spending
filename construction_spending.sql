/* -------- creating individual tables and importing CSV files */
CREATE TABLE
	PBWSCONS(			-- change table name
  	date DATE, value DECIMAL(10,2))
	;


LOAD DATA LOCAL INFILE 'FRED Total Construction Spending Data/Public Spending/CSV/PBWSCONSTotal Public Construction Spending-Water Supply.csv' -- change file pathname
INTO TABLE PBWSCONS -- change table name
COLUMNS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(date, value)
	;


/* -------- adding column 'sector' and 'construction_type' that will be used in the analysis and dashboard */

ALTER TABLE PBWSCONS -- change table name
ADD COLUMN sector VARCHAR(200), 
ADD COLUMN construction_type VARCHAR(200)
	; 

UPDATE PBWSCONS -- change table name
SET sector = 'Public', construction_type = 'Water Supply'	-- change sector and construction type
	; 


/* -------- creating table and combining tables, total public construction */

CREATE TABLE total_public_cons AS
SELECT 
	*
FROM
	`PBAMUSCONS`
UNION ALL

SELECT 
	*
FROM
	`PBCADCONS`
UNION ALL

SELECT 
	*
FROM
	`PBCOMCONS`
UNION ALL

SELECT 
	*
FROM
	`PBEDUCONS`
UNION ALL

SELECT 
	*
FROM
	`PBHLTHCONS`
UNION ALL

SELECT 
	*
FROM
	`PBHWYCONS`
UNION ALL

SELECT 
	*
FROM
	`PBOFCONS`
UNION ALL

SELECT 
	*
FROM
	`PBPSCONS`
UNION ALL

SELECT 
	*
FROM
	`PBPWRCONS`
UNION ALL

SELECT 
	*
FROM
	`PBRESCONS`

UNION ALL

SELECT 
	*
FROM
	`PBSWGCONS`
UNION ALL

SELECT 
	*
FROM
	`PBTRANSCONS`
UNION ALL

SELECT 
	*
FROM
	`PBWSCONS`
);


/* -------- creating table and combining tables, total private construction */

CREATE TABLE total_private_cons AS
(
SELECT 
	*
FROM
	`PLODGCONS`
UNION ALL

SELECT 
	*
FROM
	`PRAMUSCONS`
UNION ALL

SELECT 
	*
FROM
	`PRCMUCONS`
UNION ALL

SELECT 
	*
FROM
	`PRCOMCON`
UNION ALL

SELECT 
	*
FROM
	`PREDUCONS`
UNION ALL

SELECT 
	*
FROM
	`PRHLTHCONS`
UNION ALL

SELECT 
	*
FROM
	`PRMFGCONS`
UNION ALL

SELECT 
	*
FROM
	`PROFCONS`
UNION ALL

SELECT 
	*
FROM
	`PRPWRCONS`
UNION ALL

SELECT 
	*
FROM
	`PRRELCONS`
UNION ALL

SELECT 
	*
FROM
	`PRRESCONS`
UNION ALL

SELECT 
	*
FROM
	`PRTRANSCONS`

);


/* -------- creating table and combining tables, total construction */

CREATE TABLE total_construction AS(
	SELECT
		*
	FROM
		`total_public_cons`
	UNION ALL
    
    SELECT
		*
	FROM
		`total_private_cons`
	);

/* -------- add columns year and month, this will be our final table and will be used for the analysis and dashboard */


ALTER TABLE total_construction
ADD COLUMN month VARCHAR(200) AFTER date
	;

ALTER TABLE total_construction
ADD COLUMN year VARCHAR(200) AFTER month
	;

UPDATE total_construction
SET month = (CASE WHEN MONTH(date) = 1 THEN 'Jan'
	WHEN MONTH(date) = 2 THEN 'Feb'
	WHEN MONTH(date) = 3 THEN 'Mar'
    	WHEN MONTH(date) = 4 THEN 'Apr'
    	WHEN MONTH(date)= 5 THEN 'May'
	WHEN MONTH(date)= 6 THEN 'Jun'
	WHEN MONTH(date) = 7 THEN 'July'
	WHEN MONTH(date)= 8 THEN 'Aug'
	WHEN MONTH(date)= 9 THEN 'Sept'
	WHEN MONTH(date)= 10 THEN 'Oct'
	WHEN MONTH(date) = 11 THEN 'Nov'
	ELSE 'Dec'
	END
	);

UPDATE total_construction
SET year = YEAR(date)
	;

