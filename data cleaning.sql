SHOW Tables;
SELECT *
FROM superstore
LIMIT 10;
#Add new columns
ALTER TABLE superstore 
ADD COLUMN OrderDate DATE,
ADD COLUMN ShipDate DATE;
# update new date columns
UPDATE superstore
SET 
    OrderDate = STR_TO_DATE(`Order Date`, '%m/%d/%Y'),
    ShipDate = STR_TO_DATE(`Ship Date`, '%m/%d/%Y');
# clean null dates
SELECT `Order Date`, OrderDate, `Ship Date`, ShipDate 
FROM superstore
LIMIT 10;










