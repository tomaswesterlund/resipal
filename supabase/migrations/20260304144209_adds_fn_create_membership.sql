set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fn_create_membership(p_community_id uuid, p_user_id uuid, p_is_admin boolean, p_is_resident boolean, p_is_security boolean)
 RETURNS uuid
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
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
$function$
;


