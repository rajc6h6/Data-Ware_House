BULK INSERT bronze.supermarket_data
FROM 'F:\sql material\archive\Sample - Superstore.csv'
WITH (
    FIRSTROW = 2,               -- skip header row
    FIELDTERMINATOR = ',',      -- CSV comma separator
    ROWTERMINATOR = '\n',       -- line break as row separator
    TABLOCK                    -- optimize for bulk insert
);

