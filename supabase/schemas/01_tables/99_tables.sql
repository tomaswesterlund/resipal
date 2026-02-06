CREATE TABLE error_logs(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id uuid REFERENCES users(id) ON DELETE SET NULL,
    created_at timestamptz NOT NULL DEFAULT NOW(),
    -- Error Data
    error_message text NOT NULL,
    stack_trace text,
    platform text, -- 'ios', 'android', 'web'
    app_version text,
    -- Context
    feature_area text, -- e.g., 'payments', 'invitations'
    metadata jsonb -- To store variables/state when the error happened
);

-- Indexing for faster searching in the dashboard
CREATE INDEX idx_error_logs_user ON error_logs(user_id);

CREATE INDEX idx_error_logs_created_at ON error_logs(created_at);

CREATE TABLE movements(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id uuid NOT NULL REFERENCES users(id),
    created_at timestamptz NOT NULL DEFAULT NOW(),
    amount_in_cents int NOT NULL,
    date timestamptz NOT NULL,
    type TEXT NOT NULL CHECK (type IN ('payment', 'maintenance_fee')),
    ref_id text NOT NULL,
    description text
);

CREATE TABLE payments(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id uuid NOT NULL REFERENCES users(id),
    created_at timestamptz NOT NULL DEFAULT NOW(),
    amount_in_cents int NOT NULL,
    status text NOT NULL CHECK (status IN ('approved', 'pending_review', 'cancelled')),
    date timestamptz NOT NULL,
    reference text,
    note text,
    receipt_path text
);

CREATE TABLE visitors(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id uuid NOT NULL REFERENCES users(id),
    created_at timestamptz NOT NULL DEFAULT NOW(),
    name text NOT NULL
);

CREATE TABLE invitations(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id uuid NOT NULL REFERENCES users(id),
    property_id uuid NOT NULL REFERENCES properties(id),
    visitor_id uuid NOT NULL REFERENCES visitors(id),
    created_at timestamptz NOT NULL DEFAULT NOW(),
    qr_code_token uuid NOT NULL,
    from_date timestamptz NOT NULL,
    to_date timestamptz NOT NULL,
    max_entries int NOT NULL
);

CREATE TABLE access_logs(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    invitation_id uuid NOT NULL REFERENCES invitations(id),
    created_at timestamptz NOT NULL DEFAULT NOW(),
    direction text NOT NULL,
    timestamp timestamptz NOT NULL
);

-- ENABLE REAL TIME FOR ALL TABLES
DO $$
BEGIN
    IF NOT EXISTS(
        SELECT
            1
        FROM
            pg_publication
        WHERE
            pubname = 'supabase_realtime') THEN
    CREATE PUBLICATION supabase_realtime;
END IF;
END
$$;

-- 2. Alter the publication to include all tables in the public schema
-- This will automatically include tables you create in the future!
ALTER PUBLICATION supabase_realtime
    ADD TABLES IN SCHEMA public;

