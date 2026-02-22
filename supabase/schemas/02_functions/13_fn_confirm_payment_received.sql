CREATE OR REPLACE FUNCTION fn_confirm_payment_received(
    p_community_id UUID, 
    p_user_id UUID, 
    p_payment_id UUID
)
RETURNS void
LANGUAGE plpgsql AS $$
DECLARE
    v_is_pending BOOLEAN;
    v_payment_community_id UUID;
BEGIN
    -- 1. Security Check: Is the user an admin in this community?
    IF NOT fn_check_is_admin(p_user_id, p_community_id) THEN
        RAISE EXCEPTION 'Access Denied: User is not an admin of this community.';
    END IF;

    -- 2. Data Check: Does the payment exist, belong to this community, and is it pending?
    SELECT (status = 'pending_review'), community_id
    INTO v_is_pending, v_payment_community_id
    FROM payments
    WHERE id = p_payment_id;

    -- 3. Validations
    IF v_payment_community_id IS NULL THEN
        RAISE EXCEPTION 'Payment not found.';
    END IF;

    IF v_payment_community_id != p_community_id THEN
        RAISE EXCEPTION 'Cross-community update attempt detected.';
    END IF;

    IF NOT COALESCE(v_is_pending, FALSE) THEN
        RAISE EXCEPTION 'This payment is not in a state that can be approved.';
    END IF;

    -- 4. Execute Update
    UPDATE payments
    SET status = 'approved'
    WHERE id = p_payment_id;
END;
$$;