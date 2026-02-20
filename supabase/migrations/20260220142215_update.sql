alter table "public"."communities" drop constraint "communities_key_key";

drop index if exists "public"."communities_key_key";

alter table "public"."communities" drop column "key";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fn_create_community(p_user_id uuid, p_name text, p_description text, p_location text, p_is_admin boolean, p_is_security boolean, p_is_user boolean)
 RETURNS uuid
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE
  new_community_id UUID;
BEGIN
  -- 1. Validations
  IF p_name IS NULL OR trim(p_name) = '' THEN
    RAISE EXCEPTION 'El nombre de la comunidad no puede estar vacío';
  END IF;

  IF p_location IS NULL OR trim(p_location) = '' THEN
    RAISE EXCEPTION 'La ubicación es obligatoria';
  END IF;

  -- 2. Insert the Community
  INSERT INTO communities (
    name,
    description,
    location,
    created_by
  ) VALUES (
    p_name,
    p_description,
    p_location,
    p_user_id
  ) RETURNING id INTO new_community_id;

  -- 3. Insert the Membership
  INSERT INTO memberships (
    user_id,
    community_id,
    is_admin,
    is_security,
    is_resident,
    created_by
  ) VALUES (
    p_user_id,
    new_community_id,
    p_is_admin,
    p_is_security,
    p_is_user,
    p_user_id
  );

  RETURN new_community_id;

END;
$function$
;


