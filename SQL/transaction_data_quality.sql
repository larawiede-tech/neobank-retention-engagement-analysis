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
