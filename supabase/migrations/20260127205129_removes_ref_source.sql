alter table "public"."movements" drop column "ref_source";

alter table "public"."movements" add constraint "movements_type_check" CHECK ((type = ANY (ARRAY['payment'::text, 'maintenance_fee'::text]))) not valid;

alter table "public"."movements" validate constraint "movements_type_check";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fn_after_maintenance_fee_insert()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_user_id UUID;
BEGIN
    -- 1. Get the user_id associated with the property in the contract
    SELECT p.user_id INTO v_user_id
    FROM public.properties p
    JOIN public.maintenance_contracts mc ON mc.property_id = p.id
    WHERE mc.id = NEW.contract_id;

    -- 2. Insert into movements
    INSERT INTO public.movements (
        user_id,
        amount_in_cents,
        type,
        ref_id,
        created_at
    )
    VALUES (
        v_user_id,
        NEW.amount_in_cents,
        'maintenance_fee',
        NEW.id::TEXT,
        NEW.created_at
    );

    RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.fn_after_payment_insert()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO public.movements (
        user_id,
        amount_in_cents,
        type,
        ref_id,
        created_at
    )
    VALUES (
        NEW.user_id,
        NEW.amount_in_cents,
        'payment',
        NEW.id::TEXT,
        NEW.created_at
    );
    RETURN NEW;
END;
$function$
;


