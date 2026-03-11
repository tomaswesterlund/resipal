CREATE OR REPLACE FUNCTION fn_check_is_admin(
  p_user_id UUID,
  p_community_id UUID
) RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM users AS u
    INNER JOIN memberships AS m ON m.user_id = u.id
    WHERE u.id = p_user_id 
    AND m.community_id = p_community_id
    AND is_admin = TRUE
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;