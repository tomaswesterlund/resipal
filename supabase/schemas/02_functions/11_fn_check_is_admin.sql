CREATE OR REPLACE FUNCTION fn_check_is_admin(
  p_user_id UUID,
  p_community_id UUID
) RETURNS BOOLEAN AS $$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM memberships 
    WHERE community_id = p_community_id 
    AND user_id = p_user_id 
    AND is_admin = TRUE
  );
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;