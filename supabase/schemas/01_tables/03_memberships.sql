CREATE TABLE memberships(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id),
    community_id UUID NOT NULL REFERENCES  communities(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id),
    is_admin BOOLEAN NOT NULL,
    is_resident BOOLEAN NOT NULL,
    is_security BOOLEAN NOT NULL,
    UNIQUE (user_id, community_id)
);