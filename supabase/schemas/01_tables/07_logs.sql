-- Rename the table to be more generic
CREATE TABLE logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID NULL DEFAULT auth.uid() REFERENCES auth.users(id),
    
    -- Level: 'INFO', 'ERROR', 'DEBUG', 'WARNING'
    level TEXT NOT NULL DEFAULT 'ERROR',
    
    -- General Message (renamed from error_message)
    message TEXT NOT NULL,
    
    -- Debugging info
    stack_trace TEXT,
    platform TEXT, -- 'ios', 'android', 'web'
    app_version TEXT,
    
    -- Context
    feature_area TEXT, -- e.g., 'payments', 'invitations'
    metadata JSONB DEFAULT '{}'::jsonb -- Stores variables/state
);

-- Indexing for performance
CREATE INDEX idx_logs_level ON logs(level);
CREATE INDEX idx_logs_feature_area ON logs(feature_area);
CREATE INDEX idx_logs_created_at ON logs(created_at DESC);