CREATE TABLE contracts(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id),
    community_id UUID NOT NULL REFERENCES communities(id),
    name TEXT NOT NULL,
    period TEXT NOT NULL CHECK (period IN ('monthly')),
    amount_in_cents INT NOT NULL,
    description TEXT
);