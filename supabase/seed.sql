INSERT INTO users(id, name, phone_number, emergency_phone_number, email)
    VALUES ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 'John Doe', '+1 555-123-4567', '+1 555-987-6543', 'john.doe@example.com');

INSERT INTO properties (user_id, name, description)
VALUES 
    ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 'Terreno K19', 'Lote residencial principal'),
    ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 'Departamento 402', 'Unidad en Torre A'),
    ('a7b8c9d0-e1f2-3a4b-5c6d-7e8f9a0b1c2d', 'Bodega B-05', 'Espacio de almacenamiento en sótano');

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