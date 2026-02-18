CREATE TABLE visitors(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id),
    community_id UUID NOT NULL REFERENCES communities(id),
    user_id uuid NOT NULL REFERENCES users(id),
    name TEXT NOT NULL,
    identification_path TEXT NOT NULL
);