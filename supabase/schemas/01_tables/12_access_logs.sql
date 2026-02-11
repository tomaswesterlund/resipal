CREATE TABLE access_logs(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id),
    community_id UUID NOT NULL REFERENCES communities(id),
    invitation_id uuid NOT NULL REFERENCES invitations(id),
    direction text NOT NULL,
    timestamp timestamptz NOT NULL
);