CREATE TABLE error_logs(
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID NULL DEFAULT auth.uid() REFERENCES auth.users(id),
    -- Error Data
    error_message text NOT NULL,
    stack_trace text,
    platform text, -- 'ios', 'android', 'web'
    app_version text,
    -- Context
    feature_area text, -- e.g., 'payments', 'invitations'
    metadata jsonb -- To store variables/state when the error happened
);