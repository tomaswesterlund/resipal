CREATE TABLE edge_function_logs (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    function_name TEXT NOT NULL,
    status TEXT NOT NULL CHECK (status IN ('success', 'error', 'pending')),
    execution_time_ms INT,
    payload JSONB,
    response JSONB,
    error_message TEXT
);

-- Index for faster searching by function name and date
CREATE INDEX idx_logs_function_name ON edge_function_logs (function_name, created_at DESC);