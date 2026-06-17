-- =====================================================
-- TRANSACTION DATA QUALITY & EXPLORATION
-- Neo-Bank Retention & Engagement Project
-- Author: Lara Wiede
-- =====================================================
-- -----------------------------------------------------
-- Dataset Overview
-- -----------------------------------------------------

SELECT COUNT(*) AS total_transactions
FROM `le-wagon-bootcamp-493213.neo_bank.transactions`;
-- -----------------------------------------------------
-- Transaction ID Validation
-- Check if transaction_id can be used as a primary key
-- -----------------------------------------------------

SELECT
    transaction_id,
    COUNT(*) AS occurrences
FROM `le-wagon-bootcamp-493213.neo_bank.transactions`
GROUP BY transaction_id
HAVING COUNT(*) > 1;
-- -----------------------------------------------------
-- Missing Values Assessment
-- -----------------------------------------------------

SELECT
    COUNTIF(transaction_id IS NULL) AS null_transaction_id,
    COUNTIF(transactions_type IS NULL) AS null_transaction_type,
    COUNTIF(transactions_currency IS NULL) AS null_currency,
    COUNTIF(amount_usd IS NULL) AS null_amount,
    COUNTIF(transactions_state IS NULL) AS null_state,
    COUNTIF(ea_merchant_mcc IS NULL) AS null_mcc,
    COUNTIF(user_id IS NULL) AS null_user_id,
    COUNTIF(created_date IS NULL) AS null_created_date
FROM `le-wagon-bootcamp-493213.neo_bank.transactions`;
-- -----------------------------------------------------
-- Transaction Type Distribution
-- -----------------------------------------------------

SELECT
    transactions_type,
    COUNT(*) AS nb_transactions
FROM `le-wagon-bootcamp-493213.neo_bank.transactions`
GROUP BY transactions_type
ORDER BY nb_transactions DESC;
-- -----------------------------------------------------
-- Date Coverage
-- -----------------------------------------------------

SELECT
    MIN(created_date) AS first_transaction,
    MAX(created_date) AS last_transaction
FROM `le-wagon-bootcamp-493213.neo_bank.transactions`;
-- -----------------------------------------------------
-- User Lifespan Analysis
-- Time between first and last completed transaction
-- -----------------------------------------------------

WITH user_lifespan AS (
    SELECT
        user_id,
        DATE_DIFF(
            MAX(DATE(created_date)),
            MIN(DATE(created_date)),
            DAY
        ) AS lifespan_days
    FROM `le-wagon-bootcamp-493213.neo_bank.transactions`
    WHERE transactions_state = 'COMPLETED'
    GROUP BY user_id
)

SELECT
    MIN(lifespan_days) AS min_lifespan,
    AVG(lifespan_days) AS avg_lifespan,
    MAX(lifespan_days) AS max_lifespan
FROM user_lifespan;
