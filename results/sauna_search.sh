duckdb -c "COPY (
    SELECT name, current_status, jurisdiction_code, current_alternative_legal_name, incorporation_date, 
           registered_address_street_address, registered_address_region
    FROM '~/data/opencorporates/us_*/companies.parquet'
    WHERE name ILIKE '%sauna%'
      OR (
        name ILIKE '%steam room%'
        OR name ILIKE '%banya %'
        OR name ILIKE '%bathhouse%'
        OR name ILIKE '%hammam%'
      )
      AND current_status NOT ILIKE '%inactive%'
      AND current_status NOT ILIKE '%dissolved%'
      AND current_status NOT ILIKE '%terminated%'
      AND current_status NOT ILIKE '%revoked%'
      AND current_status NOT ILIKE '%converted%'
      AND current_status NOT ILIKE '%forfeited%'
      AND current_status NOT ILIKE '%cancelled%'
      AND current_status NOT ILIKE '%suspended%'
      AND current_status NOT ILIKE '%merged out%'
      AND current_status NOT ILIKE '%past due%'
      AND current_status NOT ILIKE '%expired%'
      AND current_status NOT ILIKE '%withdrawn%'
      AND current_status NOT ILIKE '%delinquent%'
    LIMIT 10000
  ) TO 'sauna_search.csv' (HEADER, DELIMITER ',');"