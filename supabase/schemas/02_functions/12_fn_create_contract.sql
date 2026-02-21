CREATE OR REPLACE FUNCTION fn_create_contract(p_community_id uuid, -- Added parameter
p_name text, p_amount_in_cents int, p_period text, p_description text)
    RETURNS uuid
    AS $$
DECLARE
    v_user_id uuid;
    new_contract_id uuid;
BEGIN
    -- 1. Get current user session for auditing
    v_user_id := auth.uid();
    IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'Usuario no autenticado';
    END IF;
    -- 2. Validations
    IF p_name IS NULL OR trim(p_name) = '' THEN
        RAISE EXCEPTION 'El nombre del contrato es obligatorio';
    END IF;
    IF p_amount_in_cents < 0 THEN
        RAISE EXCEPTION 'El monto no puede ser negativo';
    END IF;
    -- Verify the community exists and the user has permission to add contracts to it
    IF NOT fn_check_is_admin(auth.uid(), p_community_id) THEN
        RAISE EXCEPTION 'No tienes permisos de administrador en esta comunidad';
    END IF;
    -- 3. Insert the Contract
    INSERT INTO contracts(community_id, name, amount_in_cents, period, description, created_by)
        VALUES (p_community_id, p_name, p_amount_in_cents, p_period, p_description, v_user_id)
    RETURNING
        id INTO new_contract_id;
    RETURN new_contract_id;
END;
$$
LANGUAGE plpgsql
SECURITY DEFINER;

