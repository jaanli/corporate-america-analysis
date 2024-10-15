duckdb -c "COPY (
    SELECT name, current_status, current_alternative_legal_name, incorporation_date, 
           registered_address_street_address, registered_address_region
    FROM '~/data/opencorporates/us_*/companies.parquet'
    WHERE name ILIKE '%medical group%'
      AND (
        name ILIKE '%surg%'
        OR name ILIKE '%cardiol%'
        OR name ILIKE '%oncolog%'
        OR name ILIKE '%pediatr%'
        OR name ILIKE '%neurol%'
        OR name ILIKE '%ortho%'
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
    LIMIT 10000
  ) TO 'active_medical_groups.csv' (HEADER, DELIMITER ',');"