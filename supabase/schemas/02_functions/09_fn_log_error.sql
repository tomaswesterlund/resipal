CREATE OR REPLACE FUNCTION fn_log_error(
    p_error_message TEXT,
    p_stack_trace TEXT DEFAULT NULL,
    p_platform TEXT DEFAULT NULL,
    p_app_version TEXT DEFAULT NULL,
    p_feature_area TEXT DEFAULT NULL,
    p_metadata JSONB DEFAULT '{}'::jsonb
)
RETURNS uuid
LANGUAGE plpgsql
SECURITY INVOKER -- Runs with the permissions of the user calling it
AS $$
DECLARE
    v_new_id UUID;
BEGIN
    INSERT INTO error_logs (
        error_message,
        stack_trace,
        platform,
        app_version,
        feature_area,
        metadata
    )
    VALUES (
        p_error_message,
        p_stack_trace,
        p_platform,
        p_app_version,
        p_feature_area,
        p_metadata
    )
    RETURNING id INTO v_new_id;

    RETURN v_new_id;
END;
$$;