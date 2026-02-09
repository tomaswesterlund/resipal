alter table "public"."user_community" drop constraint "user_community_status_check";

alter table "public"."user_community" add constraint "user_community_status_check" CHECK (((status)::text = ANY ((ARRAY['pending_approval'::character varying, 'approved'::character varying, 'rejected'::character varying])::text[]))) not valid;

alter table "public"."user_community" validate constraint "user_community_status_check";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fn_maintenance_fee_movements_sync()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_user_id uuid;
    v_target_record RECORD;
    v_created_by uuid;
BEGIN
    -- v_created_by := auth.uid();

    -- -- 1. Identify which record to extract foreign keys from
    -- IF (TG_OP = 'DELETE') THEN
    --     v_target_record := OLD;
    -- ELSE
    --     v_target_record := NEW;
    -- END IF;
    -- -- 2. Get the property owner (user_id)
    -- SELECT p.owner_id INTO v_user_id
    -- FROM maintenance_fees AS mf
    -- JOIN properties AS p ON mf.property_id = p.id
    -- WHERE mf.id = v_target_record.id;

    -- IF (TG_OP = 'INSERT') THEN
    --     INSERT INTO public.movements(user_id, created_by, amount_in_cents, type, ref_id, date, description)
    --     VALUES (v_user_id, v_created_by, v_target_record.amount_in_cents, 'maintenance_fee', v_target_record.id::text, v_target_record.created_at, 'Maintenance fee charge');
    -- END IF;
    
    RETURN NEW;
END;
$function$
;


