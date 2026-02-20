drop function if exists "public"."fn_create_user"(p_user_id uuid, p_name text, p_email text, p_phone_number text);

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fn_create_user(p_name text, p_email text, p_phone_number text)
 RETURNS uuid
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE
  new_user_id UUID;
BEGIN
    -- Get the ID from the current authenticated session
    new_user_id := auth.uid();

    -- Validation: Ensure we actually have a session
    IF new_user_id IS NULL THEN
        RAISE EXCEPTION 'No se pudo obtener el ID del usuario autenticado.';
    END IF;

    INSERT INTO users (id, name, email, phone_number)
    VALUES (new_user_id, p_name, p_email, p_phone_number)
    RETURNING id INTO new_user_id;

    RETURN new_user_id;
END;
$function$
;


