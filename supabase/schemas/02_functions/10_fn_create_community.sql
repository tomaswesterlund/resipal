CREATE OR REPLACE FUNCTION fn_create_community(
  p_user_id UUID,
  p_name TEXT,
  p_description TEXT,
  p_location TEXT,
  p_is_admin BOOLEAN,
  p_is_security BOOLEAN,
  p_is_user BOOLEAN
) RETURNS UUID AS $$
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
$$ LANGUAGE plpgsql SECURITY DEFINER;