CREATE TABLE properties(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    community_id UUID NOT NULL REFERENCES communities(id),
    owner_id UUID REFERENCES users(id),
    contract_id UUID REFERENCES maintenance_contracts(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    name TEXT NOT NULL,
    description text
);