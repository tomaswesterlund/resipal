CREATE OR REPLACE FUNCTION fn_create_membership(
    p_community_id UUID, 
    p_user_id UUID, 
    p_is_admin BOOLEAN, 
    p_is_resident BOOLEAN, 
    p_is_security BOOLEAN)
    RETURNS uuid
    AS $$
DECLARE
    v_user_id uuid;
    new_membership_id uuid;
BEGIN
    -- Get current user session for auditing
    v_user_id := auth.uid();
    IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'Usuario no autenticado';
    END IF;
    
    INSERT INTO memberships(community_id, user_id, is_admin, is_resident, is_security)
        VALUES (p_community_id, p_user_id, p_is_admin, p_is_resident, p_is_security)
    RETURNING
        id INTO new_membership_id;
    RETURN new_membership_id;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER;
