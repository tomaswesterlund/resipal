CREATE TABLE applications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NULL REFERENCES  auth.users(id),
    community_id UUID NOT NULL REFERENCES  communities(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id),
    name TEXT NOT NULL,
    phone_number TEXT NOT NULL,
    emergency_phone_number TEXT NULL,
    email TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('pending_approval', 'invited', 'approved', 'rejected', 'revoked')),
    message TEXT NOT NULL,
    is_admin BOOLEAN NOT NULL,
    is_resident BOOLEAN NOT NULL,
    is_security BOOLEAN NOT NULL,
    UNIQUE(community_id, email)
);