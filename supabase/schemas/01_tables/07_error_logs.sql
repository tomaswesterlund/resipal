CREATE TABLE error_logs(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    community_id UUID REFERENCES communities(id),
    user_id UUID REFERENCES users(id) ON DELETE SET NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID NOT NULL DEFAULT auth.uid() REFERENCES auth.users(id),
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