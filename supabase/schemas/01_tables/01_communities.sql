CREATE TABLE communities(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id),
    name text NOT NULL,
    description text,
    location TEXT NOT NULL
);