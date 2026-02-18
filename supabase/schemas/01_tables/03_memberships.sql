CREATE TABLE memberships(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id),
    user_id uuid NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    community_id uuid NOT NULL REFERENCES communities(id) ON DELETE CASCADE,
    -- status varchar(20) NOT NULL CHECK (status IN ('pending_approval', 'approved', 'rejected')),
    is_admin BOOLEAN NOT NULL,
    is_resident BOOLEAN NOT NULL,
    is_security BOOLEAN NOT NULL,
    UNIQUE (user_id, community_id)
);