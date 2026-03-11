set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fn_create_community(p_name text, p_description text, p_location text)
 RETURNS uuid
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE
  v_user_id UUID;
  new_community_id UUID;
BEGIN
  -- Get current user session for auditing
    v_user_id := auth.uid();
    IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'Usuario no autenticado';
    END IF;

  
  IF p_name IS NULL OR trim(p_name) = '' THEN
    RAISE EXCEPTION 'El nombre de la comunidad no puede estar vacío';
  END IF;

  IF p_location IS NULL OR trim(p_location) = '' THEN
    RAISE EXCEPTION 'La ubicación es obligatoria';
  END IF;
  
  
  INSERT INTO communities(name, description, location, created_by)
    VALUES (p_name, p_description, p_location, v_user_id)
  RETURNING
    id INTO new_community_id;
  RETURN new_community_id;
END;
$function$
;


