CREATE OR REPLACE FUNCTION fn_register_property(
    p_community_id UUID, 
    p_resident_id UUID, 
    p_contract_id UUID, 
    p_name TEXT, 
    p_description TEXT
)
RETURNS UUID -- Changed from 'properties' table type to 'UUID'
LANGUAGE plpgsql
AS $$
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
$$;