CREATE TABLE payments(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id),
    user_id uuid NOT NULL REFERENCES users(id),
    community_id UUID NOT NULL REFERENCES communities(id),
    amount_in_cents int NOT NULL,
    status text NOT NULL CHECK (status IN ('approved', 'pending_review', 'cancelled')),
    date timestamptz NOT NULL,
    reference text,
    note text,
    receipt_path text
);