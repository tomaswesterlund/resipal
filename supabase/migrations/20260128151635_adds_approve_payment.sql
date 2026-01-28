set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fn_approve_payment(p_user_id uuid, p_payment_id uuid)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_is_approved BOOLEAN;
    v_amount_in_cents INT;
BEGIN
    -- Check if payment is in 'pending_review'?
    SELECT (status == 'pending_review'), amount_in_cents
    INTO v_is_approved, v_amount_in_cents
    FROM payments
    WHERE id = p_payment_id;

    IF v_is_approved THEN
        RAISE EXCEPTION 'This payment is already approved';
    END IF;

    -- Update payment
    UPDATE payments
    SET status = 'approved'
    WHERE id = p_payment_id;

    -- Record the ledger movement
    INSERT INTO public.movements (user_id, amount_in_cents, type, ref_id, description)
    VALUES (p_user_id, (v_amount_in_cents * -1), 'payment', p_payment_id, 'Pago aprobado');
END;
$function$
;

CREATE OR REPLACE FUNCTION public.fn_pay_maintenance_fee(p_user_id uuid, p_maintenance_fee_id uuid)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_is_paid BOOLEAN;
    v_amount_cents INT;
    v_current_balance INT;
BEGIN
    -- Check if maintenance is paid already
    -- Future: Check if it is cancelled or deleted
    SELECT (payment_date IS NOT NULL), amount_in_cents
    INTO v_is_paid, v_amount_cents
    FROM maintenance_fees
    WHERE id = p_maintenance_fee_id;

    IF v_is_paid THEN
        RAISE EXCEPTION 'This maintenance fee has already been paid.';
    END IF;

    -- Check if we have enough saldo
    SELECT SUM(amount_in_cents) INTO v_current_balance 
    FROM public.movements 
    WHERE user_id = p_user_id;

    IF v_current_balance < v_amount_cents THEN
        RAISE EXCEPTION 'Insufficient balance. Current: %, Required: %', v_current_balance, v_amount_cents;
    END IF;

    -- Update
    UPDATE public.maintenance_fees 
    SET payment_date = NOW() 
    WHERE id = p_maintenance_fee_id;

    -- Record the ledger movement
    INSERT INTO public.movements (user_id, amount_in_cents, type, ref_id, description)
    VALUES (p_user_id, (v_amount_cents * -1), 'maintenance_fee', p_maintenance_fee_id, 'Pago de mantenimiento aplicado desde saldo a favor');
END;
$function$
;


