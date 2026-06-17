-- =====================================================
-- EXECUTIVE KPI OVERVIEW
-- Neo-Bank Retention & Engagement Project
-- Author: Lara Wiede
-- =====================================================

-- Objective:
-- Create key business metrics used in the Executive
-- Overview dashboard to provide stakeholders with a
-- high-level view of customer activity, transaction
-- performance, and geographic reach.
-- -----------------------------------------------------
-- Total Users
-- -----------------------------------------------------

SELECT
    COUNT(DISTINCT user_id) AS total_users
FROM `le-wagon-bootcamp-493213.neo_bank.users`;
-- -----------------------------------------------------
-- Total Transactions
-- -----------------------------------------------------

SELECT
    COUNT(*) AS total_transactions
FROM `le-wagon-bootcamp-493213.neo_bank.transactions`;
-- -----------------------------------------------------
-- Completed Transaction Rate
-- -----------------------------------------------------

SELECT
    ROUND(
        100 * COUNTIF(transactions_state = 'COMPLETED')
        / COUNT(*),
        2
    ) AS completed_transaction_rate
FROM `le-wagon-bootcamp-493213.neo_bank.transactions`;
-- -----------------------------------------------------
-- Countries Covered
-- -----------------------------------------------------

SELECT
    COUNT(DISTINCT country) AS countries_covered
FROM `le-wagon-bootcamp-493213.neo_bank.users`;
-- -----------------------------------------------------
-- Transaction Volume
-- -----------------------------------------------------

SELECT
    ROUND(SUM(amount_usd), 2) AS transaction_volume_usd
FROM `le-wagon-bootcamp-493213.neo_bank.transactions`
WHERE transactions_state = 'COMPLETED';

-- -----------------------------------------------------
-- Crypto Unlock Rate
-- -----------------------------------------------------

SELECT
    ROUND(
        100 * COUNTIF(user_settings_crypto_unlocked = 1)
        / COUNT(*),
        2
    ) AS crypto_unlock_rate
FROM `le-wagon-bootcamp-493213.neo_bank.users`;
