-- Rename the table to be more generic
CREATE TABLE logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    created_by UUID NULL DEFAULT auth.uid() REFERENCES auth.users(id),
    level TEXT NOT NULL,
    message TEXT NOT NULL,
    stack_trace TEXT,
    platform TEXT,
    app_version TEXT,
    feature_area TEXT,
    metadata JSONB DEFAULT '{}'::jsonb
);

-- Indexing for performance
CREATE INDEX idx_logs_level ON logs(level);
CREATE INDEX idx_logs_feature_area ON logs(feature_area);
CREATE INDEX idx_logs_created_at ON logs(created_at DESC);