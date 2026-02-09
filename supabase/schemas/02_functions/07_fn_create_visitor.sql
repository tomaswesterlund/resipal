CREATE OR REPLACE FUNCTION fn_create_visitor(p_user_id UUID, p_name TEXT, p_identification_path TEXT)
RETURNS VOID
LANGUAGE plpgsql as $$
BEGIN
    INSERT INTO visitors(user_id, name, identification_path)
    VALUES (p_user_id, p_name, p_identification_path);
END;
$$;