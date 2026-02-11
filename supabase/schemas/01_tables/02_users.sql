CREATE TABLE users(
    id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id),
    community_id UUID REFERENCES communities(id),
    name text NOT NULL,
    phone_number text NOT NULL,
    emergency_phone_number text NOT NULL,
    email text NOT NULL
);