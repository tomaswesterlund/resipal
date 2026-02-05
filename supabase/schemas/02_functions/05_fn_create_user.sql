CREATE OR REPLACE FUNCTION fn_create_user(p_user_id uuid, p_name text, p_email text, p_phone_number text, p_emergency_phone_number text)
RETURNS void
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO users (id, name, email, phone_number, emergency_phone_number)
    VALUES (p_user_id, p_name, p_email, p_phone_number, p_emergency_phone_number);
END;
$$;