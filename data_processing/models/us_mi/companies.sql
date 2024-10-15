{{ config(
    materialized = 'external',
    location = '~/data/opencorporates/us_mi/companies.parquet'
)}}

WITH source_data AS (
    SELECT * FROM read_csv_auto('~/data/opencorporates/us_mi/companies.csv.gz',
                                header=true,
                                filename=true,
                                compression='gzip')
)

SELECT
    CAST(company_number AS VARCHAR) AS company_number,
    CAST(jurisdiction_code AS VARCHAR) AS jurisdiction_code,
    CAST(name AS VARCHAR) AS name,
    CAST(normalised_name AS VARCHAR) AS normalised_name,
    CAST(company_type AS VARCHAR) AS company_type,
    CAST(nonprofit AS BOOLEAN) AS nonprofit,
    CAST(current_status AS VARCHAR) AS current_status,
    TRY_CAST(incorporation_date AS DATE) AS incorporation_date,
    TRY_CAST(dissolution_date AS DATE) AS dissolution_date,
    CAST(branch AS VARCHAR) AS branch,
    CAST(business_number AS VARCHAR) AS business_number,
    CAST(current_alternative_legal_name AS VARCHAR) AS current_alternative_legal_name,
    CAST(current_alternative_legal_name_language AS VARCHAR) AS current_alternative_legal_name_language,
    CAST(home_jurisdiction_text AS VARCHAR) AS home_jurisdiction_text,
    CAST(native_company_number AS VARCHAR) AS native_company_number,
    CAST(previous_names AS VARCHAR) AS previous_names,
    TRY_CAST(retrieved_at AS TIMESTAMP) AS retrieved_at,
    CAST(registry_url AS VARCHAR) AS registry_url,
    CAST(restricted_for_marketing AS BOOLEAN) AS restricted_for_marketing,
    CAST(inactive AS BOOLEAN) AS inactive,
    TRY_CAST(accounts_next_due AS DATE) AS accounts_next_due,
    TRY_CAST(accounts_reference_date AS DATE) AS accounts_reference_date,
    TRY_CAST(accounts_last_made_up_date AS DATE) AS accounts_last_made_up_date,
    TRY_CAST(annual_return_next_due AS DATE) AS annual_return_next_due,
    TRY_CAST(annual_return_last_made_up_date AS DATE) AS annual_return_last_made_up_date,
    CAST(has_been_liquidated AS BOOLEAN) AS has_been_liquidated,
    CAST(has_insolvency_history AS BOOLEAN) AS has_insolvency_history,
    CAST(has_charges AS BOOLEAN) AS has_charges,
    TRY_CAST(number_of_employees AS INTEGER) AS number_of_employees,
    CAST("registered_address.street_address" AS VARCHAR) AS registered_address_street_address,
    CAST("registered_address.locality" AS VARCHAR) AS registered_address_locality,
    CAST("registered_address.region" AS VARCHAR) AS registered_address_region,
    CAST("registered_address.postal_code" AS VARCHAR) AS registered_address_postal_code,
    CAST("registered_address.country" AS VARCHAR) AS registered_address_country,
    CAST("registered_address.in_full" AS VARCHAR) AS registered_address_in_full,
    CAST(home_jurisdiction_code AS VARCHAR) AS home_jurisdiction_code,
    CAST(home_jurisdiction_company_number AS VARCHAR) AS home_jurisdiction_company_number,
    CAST(industry_code_uids AS VARCHAR) AS industry_code_uids,
    TRY_CAST(latest_accounts_date AS DATE) AS latest_accounts_date,
    TRY_CAST(latest_accounts_cash AS DECIMAL(18,2)) AS latest_accounts_cash,
    TRY_CAST(latest_accounts_assets AS DECIMAL(18,2)) AS latest_accounts_assets,
    TRY_CAST(latest_accounts_liabilities AS DECIMAL(18,2)) AS latest_accounts_liabilities

FROM source_data