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
