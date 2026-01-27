drop function if exists "public"."fn_register_new_payment"(p_user_id uuid, p_amount_in_cents integer, p_date timestamp with time zone, p_reference text, p_note text);

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fn_register_new_payment(p_user_id uuid, p_amount_in_cents integer, p_date timestamp with time zone, p_reference text, p_note text, p_receipt_url text)
 RETURNS public.payments
 LANGUAGE plpgsql
AS $function$
DECLARE
    new_row payments;
BEGIN
    -- Validation: Amount in cents is greater than 0, date is not in the future etc.
    INSERT INTO payments(user_id, amount_in_cents, status, date, reference, note, receipt_url)
        VALUES (p_user_id, p_amount_in_cents, 'pending_review', p_date, p_reference, p_note, p_receipt_url)
    RETURNING
        * INTO new_row;
    RETURN new_row;
END;
$function$
;


