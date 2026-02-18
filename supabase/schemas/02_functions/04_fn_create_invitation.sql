CREATE OR REPLACE FUNCTION fn_create_invitation(p_community_id UUID, p_user_id UUID, p_property_id UUID, p_visitor_id UUID, p_from_date timestamptz, p_to_date timestamptz)
    RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- IF p_to_date::date < p_from_date::date THEN
    --     RAISE EXCEPTION 'p_to_date is before p_from_date';
    -- END IF;
    -- IF p_from_date::date < CURRENT_DATE  THEN
    --     RAISE EXCEPTION 'p_from_date must be today or a future date';
    -- END IF;
    -- IF p_to_date::date < CURRENT_DATE THEN
    --     RAISE EXCEPTION 'p_to_date must be today or a future date';
    -- END IF;
    -- Check Property
    IF NOT EXISTS(
        SELECT
            1
        FROM
            properties
        WHERE
            id = p_property_id
            AND resident_id = p_user_id) THEN
    RAISE EXCEPTION 'Property resident error';
END IF;
    -- Check Visitor
    IF NOT EXISTS(
        SELECT
            1
        FROM
            visitors
        WHERE
            id = p_visitor_id
            AND user_id = p_user_id) THEN
    RAISE EXCEPTION 'Visitor ownership error';
END IF;
    -- Insert
    INSERT INTO invitations(community_id, user_id, property_id, visitor_id, qr_code_token, from_date, to_date, max_entries)
        VALUES(p_community_id, p_user_id, p_property_id, p_visitor_id, gen_random_uuid(), p_from_date, p_to_date, 999999);
END;
$$;

