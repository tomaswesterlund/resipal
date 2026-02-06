CREATE TABLE communities(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at timestamptz NOT NULL DEFAULT NOW(),
    name text NOT NULL,
    key text NOT NULL,
    description text,
    location TEXT NOT NULL,
    UNIQUE(key)
);