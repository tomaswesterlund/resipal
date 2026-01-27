


-- 2. Create Fees for EVERY contract
-- We'll generate 3 months of history for each: Jan (Paid), Feb (Paid), March (Pending)
INSERT INTO maintenance_fees(contract_id, amount_in_cents, status, from_date, to_date, note)
SELECT
    mc.id,
    mc.amount_in_cents,
    -- Case to decide status based on the month
    CASE WHEN months.start_date < '2026-03-01' THEN
        'paid'
    ELSE
        'pending'
    END AS status,
    months.start_date,
(months.start_date + INTERVAL '1 month' - INTERVAL '1 second') AS end_date,
    TO_CHAR(months.start_date, 'Month') || ' Maintenance' AS note
FROM
    maintenance_contracts mc
    CROSS JOIN (
        VALUES (TIMESTAMPTZ '2026-01-01 00:00:00+00'),
(TIMESTAMPTZ '2026-02-01 00:00:00+00'),
(TIMESTAMPTZ '2026-03-01 00:00:00+00')) AS months(start_date);
