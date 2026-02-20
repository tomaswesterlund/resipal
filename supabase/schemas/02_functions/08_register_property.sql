CREATE OR REPLACE FUNCTION fn_register_property(
    p_community_id UUID, 
    p_resident_id UUID, 
    p_contract_id UUID, 
    p_name TEXT, 
    p_description TEXT
)
RETURNS properties
LANGUAGE plpgsql
AS $$
DECLARE
    new_row properties;
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
    RETURNING * INTO new_row;

    RETURN new_row;
END;
$$;