-- INSERT INTO communities(id, name)
--     VALUES ('f47ac10b-58cc-4372-a567-0e02b2c3d479', 'Residencial El Bosque');

-- -- 2. Insert User with the community_id
-- INSERT INTO users(id, community_id, name, phone_number, emergency_phone_number, email)
--     VALUES ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 'f47ac10b-58cc-4372-a567-0e02b2c3d479', -- References the community above
--         'John Doe', '+1 555-123-4567', '+1 555-987-6543', 'john.doe@example.com');

-- INSERT INTO properties(user_id, name, description)
-- VALUES
--     ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 'Terreno K19', 'Lote residencial principal'),
-- ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 'Departamento 402', 'Unidad en Torre A'),
-- ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 'Bodega B-05', 'Espacio de almacenamiento en sótano');

-- -- 1. Create Maintenance Contracts 
-- INSERT INTO maintenance_contracts (id, property_id, name, period, amount_in_cents, description)
-- VALUES 
-- ('c1111111-1111-1111-1111-111111111111', (SELECT id FROM properties WHERE name = 'Terreno K19' LIMIT 1), 'Mantenimiento K19', 'monthly', 5000, 'Cuota mensual estándar'),
-- ('c2222222-2222-2222-2222-222222222222', (SELECT id FROM properties WHERE name = 'Departamento 402' LIMIT 1), 'Mantenimiento Depto 402', 'monthly', 5000, 'Cuota mensual estándar'),
-- ('c3333333-3333-3333-3333-333333333333', (SELECT id FROM properties WHERE name = 'Bodega B-05' LIMIT 1), 'Mantenimiento Bodega', 'monthly', 2000, 'Cuota mensual estándar');

-- -- 2. Create Maintenance Fees for Terreno K19 (The specific 6-month history)
-- INSERT INTO maintenance_fees (contract_id, amount_in_cents, payment_date, due_date, from_date, to_date, note)
-- VALUES 
-- -- October 2025: Paid (Payment date is before or on the due date)
-- ('c1111111-1111-1111-1111-111111111111', 5000, '2025-10-05 10:00:00+00', '2025-10-10 23:59:59+00', '2025-10-01', '2025-10-31', 'October 2025 Maintenance'),

-- -- November 2025: Not Paid (payment_date is NULL, and today is 2026, so this is OVERDUE)
-- ('c1111111-1111-1111-1111-111111111111', 5000, NULL, '2025-11-10 23:59:59+00', '2025-11-01', '2025-11-30', 'November 2025 Maintenance'),

-- -- December 2025: Not Paid (OVERDUE)
-- ('c1111111-1111-1111-1111-111111111111', 5000, NULL, '2025-12-10 23:59:59+00', '2025-12-01', '2025-12-31', 'December 2025 Maintenance'),

-- -- January 2026: Not Paid (OVERDUE - Today is Jan 28, due date was Jan 10)
-- ('c1111111-1111-1111-1111-111111111111', 5000, NULL, '2026-01-10 23:59:59+00', '2026-01-01', '2026-01-31', 'January 2026 Maintenance'),

-- -- February 2026: Not Paid (UPCOMING - Due in the future)
-- ('c1111111-1111-1111-1111-111111111111', 5000, NULL, '2026-02-10 23:59:59+00', '2026-02-01', '2026-02-28', 'February 2026 Maintenance'),

-- -- March 2026: Not Paid (UPCOMING - Due in the future)
-- ('c1111111-1111-1111-1111-111111111111', 5000, NULL, '2026-03-10 23:59:59+00', '2026-03-01', '2026-03-31', 'March 2026 Maintenance');
-- -- 3. (Optional) Quick entries for the other properties so the UI isn't empty

-- -- INSERT INTO maintenance_fees (contract_id, amount_in_cents, is_paid, from_date, to_date, note)
-- -- VALUES 
-- -- ('c2222222-2222-2222-2222-222222222222', 5000, true, '2026-01-01', '2026-01-31', 'January 2026 Maintenance'),
-- -- ('c3333333-3333-3333-3333-333333333333', 2000, true, '2026-01-01', '2026-01-31', 'January 2026 Maintenance');

-- INSERT INTO payments(user_id, amount_in_cents, status, date, reference, note)
-- VALUES
--     ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 5000, 'approved', NOW() - INTERVAL '3 months', 'PAY-001', 'January Maintenance'),
-- ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 5000, 'approved', NOW() - INTERVAL '2 months', 'PAY-002', 'February Maintenance'),
-- ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 5000, 'approved', NOW() - INTERVAL '1 month', 'PAY-003', 'March Maintenance'),
-- ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 2500, 'approved', NOW() - INTERVAL '25 days', 'PAY-004', 'Late fee payment'),
-- ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 15000, 'approved', NOW() - INTERVAL '20 days', 'PAY-005', 'Special Assessment Installment 1'),
-- ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 15000, 'approved', NOW() - INTERVAL '15 days', 'PAY-006', 'Special Assessment Installment 2'),
-- ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 2500, 'cancelled', NOW() - INTERVAL '10 days', 'PAY-007', 'Receipt was blurred'),
-- ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 5000, 'pending_review', NOW() - INTERVAL '5 days', 'PAY-008', 'April Maintenance'),
-- ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 15000, 'pending_review', NOW() - INTERVAL '2 days', 'PAY-009', 'Special Assessment Installment 3'),
-- ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 3000, 'pending_review', NOW(), 'PAY-010', 'Common area damage fine');

-- -- Insert Visitors linked to John Doe
-- INSERT INTO visitors(id, user_id, name)
-- VALUES
--     ('b1111111-2222-3333-4444-555555555555', 'a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 'Carla Sainz'),
-- ('c2222222-3333-4444-5555-666666666666', 'a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 'Martha C.'),
-- ('d3333333-4444-5555-6666-777777777777', 'a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 'María Sánchez'),
-- ('e4444444-5555-6666-7777-888888888888', 'a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 'Repartidor FedEx');

-- INSERT INTO invitations(user_id, property_id, visitor_id, qr_code_token, from_date, to_date, max_entries)
--     VALUES
--     -- Active invitation for María Sánchez (Valid for 24 hours)
-- ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d',(
--             SELECT
--                 id
--             FROM
--                 properties
--             WHERE
--                 name = 'Terreno K19'
--             LIMIT 1),
--         'd3333333-4444-5555-6666-777777777777',
--         gen_random_uuid(),
--         NOW(),
--         NOW() + INTERVAL '1 day',
--         1),
-- -- Frequent access for Carla Sainz (Valid for 1 month, 30 entries)
-- ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d',(
--         SELECT
--             id
--         FROM properties
--         WHERE
--             name = 'Terreno K19' LIMIT 1), 'b1111111-2222-3333-4444-555555555555', gen_random_uuid(), NOW() - INTERVAL '5 days', NOW() + INTERVAL '25 days', 30),
-- -- Past invitation for FedEx (Expired)
-- ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d',(
--         SELECT
--             id
--         FROM properties
--     WHERE
--         name = 'Terreno K19' LIMIT 1), 'e4444444-5555-6666-7777-888888888888', gen_random_uuid(), NOW() - INTERVAL '2 hours', NOW() - INTERVAL '1 hour', 1);

-- -- 1. Carla Sainz (Frequent Visitor) - 2 entries, 1 exit
-- INSERT INTO access_logs(invitation_id, direction, timestamp)
-- VALUES
--     -- First Visit: 2 days ago
-- ((
--             SELECT
--                 id
--             FROM
--                 invitations
--             WHERE
--                 visitor_id = 'b1111111-2222-3333-4444-555555555555'
--             LIMIT 1),
--         'entry',
--         NOW() - INTERVAL '2 days 4 hours'),
-- ((
--     SELECT
--         id
--     FROM invitations
--     WHERE
--         visitor_id = 'b1111111-2222-3333-4444-555555555555' LIMIT 1), 'exit', NOW() - INTERVAL '2 days 1 hour'),
-- -- Second Visit: Yesterday
-- ((
--     SELECT
--         id
--     FROM invitations
-- WHERE
--     visitor_id = 'b1111111-2222-3333-4444-555555555555' LIMIT 1), 'entry', NOW() - INTERVAL '1 day 2 hours');

-- -- 2. FedEx Delivery (Expired Invitation) - 1 entry/exit pair in the past
-- INSERT INTO access_logs(invitation_id, direction, timestamp)
-- VALUES
--     ((
--             SELECT
--                 id
--             FROM
--                 invitations
--             WHERE
--                 visitor_id = 'e4444444-5555-6666-7777-888888888888'
--             LIMIT 1),
--         'entry',
--         NOW() - INTERVAL '1 hour 50 minutes'),
-- ((
--     SELECT
--         id
--     FROM invitations
--     WHERE
--         visitor_id = 'e4444444-5555-6666-7777-888888888888' LIMIT 1), 'exit', NOW() - INTERVAL '1 hour 40 minutes');

-- -- 3. María Sánchez (Newest Invitation) - Just entered 15 minutes ago
-- INSERT INTO access_logs(invitation_id, direction, timestamp)
--     VALUES ((
--             SELECT
--                 id
--             FROM
--                 invitations
--             WHERE
--                 visitor_id = 'd3333333-4444-5555-6666-777777777777'
--             LIMIT 1),
--         'entry',
--         NOW() - INTERVAL '15 minutes');

