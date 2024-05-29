CREATE TABLE
	PBWSCONS(									-- change table name
  date DATE, value DECIMAL(10,2));


LOAD DATA LOCAL INFILE 'FRED Total Construction Spending Data/Public Spending/CSV/PBWSCONSTotal Public Construction Spending-Water Supply.csv' -- change file pathname
INTO TABLE PBWSCONS -- change table name
COLUMNS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(date, value);

ALTER TABLE PBWSCONS -- change table name
ADD COLUMN sector VARCHAR(200), 
ADD COLUMN construction_type VARCHAR(200); -- added column 'sector' and 'construction_type' that will be used in the analysis and dashboard

UPDATE PBWSCONS -- change table name
SET sector = 'Public', construction_type = 'Water Supply'; -- change sector and construction type

/*   ---- Combining Public and Private tables

CREATE TABLE total_public_cons AS
(
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

-- combining tables, total public construction
