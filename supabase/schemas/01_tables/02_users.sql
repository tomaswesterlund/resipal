CREATE TABLE users(
    id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id),
    name text NOT NULL,
    phone_number text NOT NULL,
    emergency_phone_number text NULL,
    email text NOT NULL
);