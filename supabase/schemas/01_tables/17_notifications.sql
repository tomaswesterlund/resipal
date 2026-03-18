CREATE TABLE notifications(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    community_id UUID NOT NULL REFERENCES communities(id),
    user_id UUID NOT NULL REFERENCES users(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id),
    app TEXT NOT NULL CHECK (app in ('admin', 'resident', 'security')),
    title TEXT NOT NULL,
    message TEXT NOT NULL,
    read_date TIMESTAMPTZ
);