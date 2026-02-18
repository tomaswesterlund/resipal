CREATE OR REPLACE FUNCTION fn_create_community_application(p_community_id uuid, p_user_id uuid)
RETURNS void
LANGUAGE plpgsql 
SECURITY DEFINER
AS $$
DECLARE
    v_email TEXT;
BEGIN
    v_email := auth.jwt() ->> 'email';

    INSERT INTO community_applications (community_id, user_id, status, message)
    VALUES (
        p_community_id, 
        p_user_id, 
        'pending_review', 
        'Creada para ' || v_email
    );
END;
$$;