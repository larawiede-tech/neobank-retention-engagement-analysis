-- =====================================================
-- MERCHANT CATEGORY CODE (MCC) EXPLORATION
-- Neo-Bank Retention & Engagement Project
-- Author: Lara Wiede
-- =====================================================

-- Objective:
-- The original dataset contained Merchant Category Codes
-- (MCCs) but no merchant category descriptions.
-- To enrich the transaction dataset, an external MCC
-- reference table was created using publicly available
-- MCC definitions.
--
-- Source:
-- https://github.com/greggles/mcc-codes
--
-- The reference table was then joined to transaction
-- records to enable category-level exploration and
-- transaction behaviour analysis.
--
-- -----------------------------------------------------
-- 0. MCC Reference Table
-- -----------------------------------------------------
--
-- Reference table created:
--
-- le-wagon-bootcamp-493213.neo_bank.mcc_codes
--
-- Used to translate merchant category codes into
-- human-readable merchant categories.
-- -----------------------------------------------------
-- 1. MCC Coverage Validation
-- -----------------------------------------------------
-- Evaluate how many transactions containing an MCC
-- can be successfully mapped to a category.

SELECT
COUNT() AS transactions_with_mcc,
COUNT(m.mcc) AS mapped_transactions,
ROUND(
100 * COUNT(m.mcc) / COUNT(),
2
) AS pct_mapped
FROM le-wagon-bootcamp-493213.neo_bank.transactions t
LEFT JOIN le-wagon-bootcamp-493213.neo_bank.mcc_codes m
ON CAST(t.ea_merchant_mcc AS INT64) = m.mcc
WHERE t.ea_merchant_mcc IS NOT NULL;
-- ---------------------------------------------------
-- 2. Create Enriched Transaction View
-- ---------------------------------------------------

-- Enrich transactions with merchant category
-- descriptions.

CREATE OR REPLACE VIEW
le-wagon-bootcamp-493213.neo_bank.transactions_enriched AS

SELECT
t.*,
m.edited_description AS merchant_category
FROM le-wagon-bootcamp-493213.neo_bank.transactions t
LEFT JOIN le-wagon-bootcamp-493213.neo_bank.mcc_codes m
ON CAST(t.ea_merchant_mcc AS INT64) = m.mcc;
-- ------------------------------------------------------
-- 3. Top Merchant Categories
-- ------------------------------------------------------

-- Explore the most common merchant categories among
-- completed transactions.

SELECT
merchant_category,
COUNT(*) AS nb_transactions
FROM le-wagon-bootcamp-493213.neo_bank.transactions_enriched
WHERE transactions_state = 'COMPLETED'
GROUP BY merchant_category
ORDER BY nb_transactions DESC
LIMIT 20;

-- Notes

-- Findings supported exploratory analysis but were not
-- included in the final dashboard.
