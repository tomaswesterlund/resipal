CREATE TABLE communities(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at timestamptz NOT NULL DEFAULT NOW(),
    name text NOT NULL
    -- add key so the community can be searched for
);

CREATE TABLE users(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    -- uud UUID NOT NULL, -- Reference later to auth.users(id)
    community_id uuid NOT NULL REFERENCES communities(id),
    created_at timestamptz NOT NULL DEFAULT NOW(),
    name text NOT NULL,
    phone_number text NOT NULL,
    emergency_phone_number text NOT NULL,
    email text NOT NULL
);

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

CREATE TABLE properties(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id uuid NOT NULL REFERENCES users(id),
    created_at timestamptz NOT NULL DEFAULT NOW(),
    name text NOT NULL,
    description text
);

CREATE TABLE movements(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id uuid NOT NULL REFERENCES users(id),
    created_at timestamptz NOT NULL DEFAULT NOW(),
    amount_in_cents int NOT NULL,
    date TIMESTAMPTZ NOT NULL,
    type TEXT NOT NULL CHECK (type IN ('payment', 'maintenance_fee')),
    ref_id text NOT NULL,
    description TEXT
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

CREATE TABLE maintenance_contracts(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    property_id UUID NOT NULL REFERENCES properties(id),
    created_at timestamptz NOT NULL DEFAULT NOW(),
    name TEXT NOT NULL,
    period TEXT NOT NULL CHECK (period IN ('monthly')),
    amount_in_cents INT NOT NULL,
    description TEXT
);

CREATE TABLE maintenance_fees(
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    contract_id UUID NOT NULL REFERENCES maintenance_contracts(id),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    amount_in_cents INT NOT NULL,
    due_date TIMESTAMPTZ NOT NULL, 
    payment_date TIMESTAMPTZ,
    from_date TIMESTAMPTZ NOT NULL,
    to_date TIMESTAMPTZ NOT NULL,
    note TEXT
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

