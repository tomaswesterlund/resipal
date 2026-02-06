CREATE TABLE users(
    id uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    created_at timestamptz NOT NULL DEFAULT NOW(),
    name text NOT NULL,
    phone_number text NOT NULL,
    emergency_phone_number text NOT NULL,
    email text NOT NULL
);