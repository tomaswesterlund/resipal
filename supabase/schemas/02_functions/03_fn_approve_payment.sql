CREATE OR REPLACE FUNCTION fn_approve_payment(p_user_id UUID, p_payment_id UUID)
RETURNS void
LANGUAGE plpgsql AS $$
DECLARE
    v_is_pending BOOLEAN;
    v_amount_in_cents INT;
BEGIN
    -- Check if payment is in 'pending_review'?
    SELECT (status = 'pending_review'), amount_in_cents
    INTO v_is_pending, v_amount_in_cents
    FROM payments
    WHERE id = p_payment_id;

    IF NOT v_is_pending THEN
        RAISE EXCEPTION 'This payment is NOT pending review.';
    END IF;

    -- Update payment
    UPDATE payments
    SET status = 'approved'
    WHERE id = p_payment_id;

    -- Record the ledger movement
    INSERT INTO public.movements (user_id, amount_in_cents, type, ref_id, description)
    VALUES (p_user_id, (v_amount_in_cents * -1), 'payment', p_payment_id, 'Pago aprobado');
END;
$$;