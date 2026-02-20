CREATE TABLE properties(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id),
    community_id UUID NOT NULL REFERENCES communities(id),
    resident_id UUID REFERENCES users(id),
    contract_id UUID REFERENCES contracts(id),
    name TEXT NOT NULL,
    description text
);