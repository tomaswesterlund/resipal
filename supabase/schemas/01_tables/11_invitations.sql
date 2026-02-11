CREATE TABLE invitations(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id),
    community_id UUID NOT NULL REFERENCES communities(id),
    user_id uuid NOT NULL REFERENCES users(id),
    property_id uuid NOT NULL REFERENCES properties(id),
    visitor_id uuid NOT NULL REFERENCES visitors(id),
    qr_code_token uuid NOT NULL,
    from_date timestamptz NOT NULL,
    to_date timestamptz NOT NULL,
    max_entries int NOT NULL
);