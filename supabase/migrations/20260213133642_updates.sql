drop function if exists "public"."fn_create_invitation"(p_user_id uuid, p_property_id uuid, p_visitor_id uuid, p_from_date timestamp with time zone, p_to_date timestamp with time zone);

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fn_create_invitation(p_community_id uuid, p_user_id uuid, p_property_id uuid, p_visitor_id uuid, p_from_date timestamp with time zone, p_to_date timestamp with time zone)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
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
            AND owner_id = p_user_id) THEN
    RAISE EXCEPTION 'Property ownership error';
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
    INSERT INTO invitations(user_id, property_id, visitor_id, qr_code_token, from_date, to_date, max_entries)
        VALUES(p_user_id, p_property_id, p_visitor_id, gen_random_uuid(), p_from_date, p_to_date, 999999);
END;
$function$
;


