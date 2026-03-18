drop function if exists "public"."fn_create_user"(p_name text, p_email text, p_phone_number text, p_emergency_phone_number text);

drop function if exists "public"."fn_register_payment"(p_community_id uuid, p_user_id uuid, p_amount_in_cents integer, p_date timestamp with time zone, p_reference text, p_note text, p_receipt_path text);


