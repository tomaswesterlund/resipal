set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fn_register_property(p_community_id uuid, p_resident_id uuid, p_contract_id uuid, p_name text, p_description text)
 RETURNS uuid
 LANGUAGE plpgsql
AS $function$
DECLARE
    new_property_id UUID; -- Changed variable type
BEGIN
    INSERT INTO properties(
        created_by, 
        community_id, 
        resident_id, 
        contract_id, 
        name, 
        description
    )
    VALUES (
        auth.uid(),
        p_community_id, 
        p_resident_id, 
        p_contract_id, 
        p_name, 
        p_description
    )
    RETURNING id INTO new_property_id; -- Only return the id column

    RETURN new_property_id;
END;
$function$
;


