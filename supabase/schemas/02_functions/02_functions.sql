CREATE OR REPLACE FUNCTION fn_register_new_payment(p_user_id uuid, p_amount_in_cents int, p_date timestamptz, p_reference text, p_note text, p_receipt_path text)
    RETURNS payments
    LANGUAGE plpgsql
    AS $$
DECLARE
    new_row payments;
BEGIN
    -- Validation: Amount in cents is greater than 0, date is not in the future etc.
    INSERT INTO payments(user_id, amount_in_cents, status, date, reference, note, receipt_path)
        VALUES (p_user_id, p_amount_in_cents, 'pending_review', p_date, p_reference, p_note, p_receipt_path)
    RETURNING
        * INTO new_row;
    RETURN new_row;
END;
$$;

