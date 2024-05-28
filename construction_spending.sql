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
