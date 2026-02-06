CREATE OR REPLACE FUNCTION fn_join_community(p_user_id uuid, p_community_id uuid)
RETURNS void
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO user_community (user_id, community_id, status)
    VALUES (p_user_id, p_community_id, 'pending_approval');
END;
$$;