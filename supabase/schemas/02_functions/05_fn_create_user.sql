CREATE OR REPLACE FUNCTION fn_create_user(
  p_name TEXT, 
  p_email TEXT, 
  p_phone_number TEXT,
  p_emergency_phone_number TEXT
)
RETURNS UUID 
SECURITY DEFINER
LANGUAGE plpgsql AS $$
DECLARE
  new_user_id UUID;
BEGIN
    -- Get the ID from the current authenticated session
    new_user_id := auth.uid();

    -- Validation: Ensure we actually have a session
    IF new_user_id IS NULL THEN
        RAISE EXCEPTION 'No se pudo obtener el ID del usuario autenticado.';
    END IF;

    INSERT INTO users (id, name, email, phone_number, emergency_phone_number)
    VALUES (new_user_id, p_name, p_email, p_phone_number, p_emergency_phone_number)
    RETURNING id INTO new_user_id;

    RETURN new_user_id;
END;
$$;