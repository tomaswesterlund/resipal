CREATE TABLE maintenance_fees(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    contract_id UUID NOT NULL REFERENCES maintenance_contracts(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    amount_in_cents INT NOT NULL,
    due_date TIMESTAMPTZ NOT NULL,
    payment_date TIMESTAMPTZ,
    from_date TIMESTAMPTZ NOT NULL,
    to_date TIMESTAMPTZ NOT NULL,
    note TEXT
);