CREATE TABLE users(
    id UUID PRIMARY KEY REFERENCES auth.users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id),
    name TEXT NOT NULL,
    phone_number TEXT NOT NULL,
    emergency_phone_number TEXT NULL,
    email TEXT NOT NULL,
    fcm_token TEXT
);