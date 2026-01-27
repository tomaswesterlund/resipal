INSERT INTO communities(id, name)
    VALUES ('f47ac10b-58cc-4372-a567-0e02b2c3d479', 'Residencial El Bosque');

-- 2. Insert User with the community_id
INSERT INTO users(id, community_id, name, phone_number, emergency_phone_number, email)
    VALUES ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', -- References the community above
        'John Doe', '+1 555-123-4567', '+1 555-987-6543', 'john.doe@example.com');

INSERT INTO properties(user_id, name, description)
VALUES
    ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 'Terreno K19', 'Lote residencial principal'),
('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 'Departamento 402', 'Unidad en Torre A'),
('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 'Bodega B-05', 'Espacio de almacenamiento en sótano');

-- 1. Create Maintenance Contracts for ALL existing properties
-- We use a CROSS JOIN / LATERAL approach to ensure every property gets one
INSERT INTO maintenance_contracts(property_id, name, period, amount_in_cents, description)
SELECT
    id,
    'Cuota de mantenimiento mensual',
    'monthly',
    5000,
    'Cuota de mantenimiento mensual - ' || name
FROM
    properties;

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

INSERT INTO payments(user_id, amount_in_cents, status, date, reference, note)
VALUES
    ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 5000, 'approved', NOW() - INTERVAL '3 months', 'PAY-001', 'January Maintenance'),
('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 5000, 'approved', NOW() - INTERVAL '2 months', 'PAY-002', 'February Maintenance'),
('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 5000, 'approved', NOW() - INTERVAL '1 month', 'PAY-003', 'March Maintenance'),
('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 2500, 'approved', NOW() - INTERVAL '25 days', 'PAY-004', 'Late fee payment'),
('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 15000, 'approved', NOW() - INTERVAL '20 days', 'PAY-005', 'Special Assessment Installment 1'),
('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 15000, 'approved', NOW() - INTERVAL '15 days', 'PAY-006', 'Special Assessment Installment 2'),
('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 2500, 'cancelled', NOW() - INTERVAL '10 days', 'PAY-007', 'Receipt was blurred'),
('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 5000, 'pending_review', NOW() - INTERVAL '5 days', 'PAY-008', 'April Maintenance'),
('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 15000, 'pending_review', NOW() - INTERVAL '2 days', 'PAY-009', 'Special Assessment Installment 3'),
('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 3000, 'pending_review', NOW(), 'PAY-010', 'Common area damage fine');

-- Insert Visitors linked to John Doe
INSERT INTO visitors(id, user_id, name)
VALUES
    ('b1111111-2222-3333-4444-555555555555', 'a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 'Carla Sainz'),
('c2222222-3333-4444-5555-666666666666', 'a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 'Martha C.'),
('d3333333-4444-5555-6666-777777777777', 'a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 'María Sánchez'),
('e4444444-5555-6666-7777-888888888888', 'a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 'Repartidor FedEx');

INSERT INTO invitations(user_id, property_id, visitor_id, qr_code_token, from_date, to_date, max_entries)
    VALUES
    -- Active invitation for María Sánchez (Valid for 24 hours)
('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d',(
            SELECT
                id
            FROM
                properties
            WHERE
                name = 'Terreno K19'
            LIMIT 1),
        'd3333333-4444-5555-6666-777777777777',
        gen_random_uuid(),
        NOW(),
        NOW() + INTERVAL '1 day',
        1),
-- Frequent access for Carla Sainz (Valid for 1 month, 30 entries)
('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d',(
        SELECT
            id
        FROM properties
        WHERE
            name = 'Terreno K19' LIMIT 1), 'b1111111-2222-3333-4444-555555555555', gen_random_uuid(), NOW() - INTERVAL '5 days', NOW() + INTERVAL '25 days', 30),
-- Past invitation for FedEx (Expired)
('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d',(
        SELECT
            id
        FROM properties
    WHERE
        name = 'Terreno K19' LIMIT 1), 'e4444444-5555-6666-7777-888888888888', gen_random_uuid(), NOW() - INTERVAL '2 hours', NOW() - INTERVAL '1 hour', 1);

-- 1. Carla Sainz (Frequent Visitor) - 2 entries, 1 exit
INSERT INTO access_logs(invitation_id, direction, timestamp)
VALUES
    -- First Visit: 2 days ago
((
            SELECT
                id
            FROM
                invitations
            WHERE
                visitor_id = 'b1111111-2222-3333-4444-555555555555'
            LIMIT 1),
        'entry',
        NOW() - INTERVAL '2 days 4 hours'),
((
    SELECT
        id
    FROM invitations
    WHERE
        visitor_id = 'b1111111-2222-3333-4444-555555555555' LIMIT 1), 'exit', NOW() - INTERVAL '2 days 1 hour'),
-- Second Visit: Yesterday
((
    SELECT
        id
    FROM invitations
WHERE
    visitor_id = 'b1111111-2222-3333-4444-555555555555' LIMIT 1), 'entry', NOW() - INTERVAL '1 day 2 hours');

-- 2. FedEx Delivery (Expired Invitation) - 1 entry/exit pair in the past
INSERT INTO access_logs(invitation_id, direction, timestamp)
VALUES
    ((
            SELECT
                id
            FROM
                invitations
            WHERE
                visitor_id = 'e4444444-5555-6666-7777-888888888888'
            LIMIT 1),
        'entry',
        NOW() - INTERVAL '1 hour 50 minutes'),
((
    SELECT
        id
    FROM invitations
    WHERE
        visitor_id = 'e4444444-5555-6666-7777-888888888888' LIMIT 1), 'exit', NOW() - INTERVAL '1 hour 40 minutes');

-- 3. María Sánchez (Newest Invitation) - Just entered 15 minutes ago
INSERT INTO access_logs(invitation_id, direction, timestamp)
    VALUES ((
            SELECT
                id
            FROM
                invitations
            WHERE
                visitor_id = 'd3333333-4444-5555-6666-777777777777'
            LIMIT 1),
        'entry',
        NOW() - INTERVAL '15 minutes');

