
  create table "public"."access_logs" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "invitation_id" uuid not null,
    "direction" text not null,
    "timestamp" timestamp with time zone not null
      );



  create table "public"."communities" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "name" text not null,
    "key" text not null,
    "description" text,
    "location" text not null
      );



  create table "public"."error_logs" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid,
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "error_message" text not null,
    "stack_trace" text,
    "platform" text,
    "app_version" text,
    "feature_area" text,
    "metadata" jsonb
      );



  create table "public"."invitations" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "user_id" uuid not null,
    "property_id" uuid not null,
    "visitor_id" uuid not null,
    "qr_code_token" uuid not null,
    "from_date" timestamp with time zone not null,
    "to_date" timestamp with time zone not null,
    "max_entries" integer not null
      );



  create table "public"."maintenance_contracts" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "name" text not null,
    "period" text not null,
    "amount_in_cents" integer not null,
    "description" text
      );



  create table "public"."maintenance_fees" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "contract_id" uuid not null,
    "property_id" uuid not null,
    "amount_in_cents" integer not null,
    "due_date" timestamp with time zone not null,
    "payment_date" timestamp with time zone,
    "from_date" timestamp with time zone not null,
    "to_date" timestamp with time zone not null,
    "note" text
      );



  create table "public"."movements" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "user_id" uuid not null,
    "amount_in_cents" integer not null,
    "date" timestamp with time zone not null,
    "type" text not null,
    "ref_id" text not null,
    "description" text
      );



  create table "public"."payments" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "user_id" uuid not null,
    "amount_in_cents" integer not null,
    "status" text not null,
    "date" timestamp with time zone not null,
    "reference" text,
    "note" text,
    "receipt_path" text
      );



  create table "public"."properties" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "community_id" uuid not null,
    "owner_id" uuid,
    "contract_id" uuid,
    "name" text not null,
    "description" text
      );



  create table "public"."user_community" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "user_id" uuid not null,
    "community_id" uuid not null,
    "status" character varying(20) not null,
    "joined_at" timestamp with time zone default now()
      );



  create table "public"."users" (
    "id" uuid not null,
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "name" text not null,
    "phone_number" text not null,
    "emergency_phone_number" text not null,
    "email" text not null
      );



  create table "public"."visitors" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "user_id" uuid not null,
    "name" text not null
      );


CREATE UNIQUE INDEX access_logs_pkey ON public.access_logs USING btree (id);

CREATE UNIQUE INDEX communities_key_key ON public.communities USING btree (key);

CREATE UNIQUE INDEX communities_pkey ON public.communities USING btree (id);

CREATE UNIQUE INDEX error_logs_pkey ON public.error_logs USING btree (id);

CREATE INDEX idx_error_logs_created_at ON public.error_logs USING btree (created_at);

CREATE INDEX idx_error_logs_user ON public.error_logs USING btree (user_id);

CREATE UNIQUE INDEX invitations_pkey ON public.invitations USING btree (id);

CREATE UNIQUE INDEX maintenance_contracts_pkey ON public.maintenance_contracts USING btree (id);

CREATE UNIQUE INDEX maintenance_fees_pkey ON public.maintenance_fees USING btree (id);

CREATE UNIQUE INDEX movements_pkey ON public.movements USING btree (id);

CREATE UNIQUE INDEX payments_pkey ON public.payments USING btree (id);

CREATE UNIQUE INDEX properties_pkey ON public.properties USING btree (id);

CREATE UNIQUE INDEX user_community_pkey ON public.user_community USING btree (id);

CREATE UNIQUE INDEX user_community_user_id_community_id_key ON public.user_community USING btree (user_id, community_id);

CREATE UNIQUE INDEX users_pkey ON public.users USING btree (id);

CREATE UNIQUE INDEX visitors_pkey ON public.visitors USING btree (id);

alter table "public"."access_logs" add constraint "access_logs_pkey" PRIMARY KEY using index "access_logs_pkey";

alter table "public"."communities" add constraint "communities_pkey" PRIMARY KEY using index "communities_pkey";

alter table "public"."error_logs" add constraint "error_logs_pkey" PRIMARY KEY using index "error_logs_pkey";

alter table "public"."invitations" add constraint "invitations_pkey" PRIMARY KEY using index "invitations_pkey";

alter table "public"."maintenance_contracts" add constraint "maintenance_contracts_pkey" PRIMARY KEY using index "maintenance_contracts_pkey";

alter table "public"."maintenance_fees" add constraint "maintenance_fees_pkey" PRIMARY KEY using index "maintenance_fees_pkey";

alter table "public"."movements" add constraint "movements_pkey" PRIMARY KEY using index "movements_pkey";

alter table "public"."payments" add constraint "payments_pkey" PRIMARY KEY using index "payments_pkey";

alter table "public"."properties" add constraint "properties_pkey" PRIMARY KEY using index "properties_pkey";

alter table "public"."user_community" add constraint "user_community_pkey" PRIMARY KEY using index "user_community_pkey";

alter table "public"."users" add constraint "users_pkey" PRIMARY KEY using index "users_pkey";

alter table "public"."visitors" add constraint "visitors_pkey" PRIMARY KEY using index "visitors_pkey";

alter table "public"."access_logs" add constraint "access_logs_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."access_logs" validate constraint "access_logs_created_by_fkey";

alter table "public"."access_logs" add constraint "access_logs_invitation_id_fkey" FOREIGN KEY (invitation_id) REFERENCES public.invitations(id) not valid;

alter table "public"."access_logs" validate constraint "access_logs_invitation_id_fkey";

alter table "public"."communities" add constraint "communities_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."communities" validate constraint "communities_created_by_fkey";

alter table "public"."communities" add constraint "communities_key_key" UNIQUE using index "communities_key_key";

alter table "public"."error_logs" add constraint "error_logs_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."error_logs" validate constraint "error_logs_created_by_fkey";

alter table "public"."error_logs" add constraint "error_logs_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL not valid;

alter table "public"."error_logs" validate constraint "error_logs_user_id_fkey";

alter table "public"."invitations" add constraint "invitations_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."invitations" validate constraint "invitations_created_by_fkey";

alter table "public"."invitations" add constraint "invitations_property_id_fkey" FOREIGN KEY (property_id) REFERENCES public.properties(id) not valid;

alter table "public"."invitations" validate constraint "invitations_property_id_fkey";

alter table "public"."invitations" add constraint "invitations_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) not valid;

alter table "public"."invitations" validate constraint "invitations_user_id_fkey";

alter table "public"."invitations" add constraint "invitations_visitor_id_fkey" FOREIGN KEY (visitor_id) REFERENCES public.visitors(id) not valid;

alter table "public"."invitations" validate constraint "invitations_visitor_id_fkey";

alter table "public"."maintenance_contracts" add constraint "maintenance_contracts_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."maintenance_contracts" validate constraint "maintenance_contracts_created_by_fkey";

alter table "public"."maintenance_contracts" add constraint "maintenance_contracts_period_check" CHECK ((period = 'monthly'::text)) not valid;

alter table "public"."maintenance_contracts" validate constraint "maintenance_contracts_period_check";

alter table "public"."maintenance_fees" add constraint "maintenance_fees_contract_id_fkey" FOREIGN KEY (contract_id) REFERENCES public.maintenance_contracts(id) not valid;

alter table "public"."maintenance_fees" validate constraint "maintenance_fees_contract_id_fkey";

alter table "public"."maintenance_fees" add constraint "maintenance_fees_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."maintenance_fees" validate constraint "maintenance_fees_created_by_fkey";

alter table "public"."maintenance_fees" add constraint "maintenance_fees_property_id_fkey" FOREIGN KEY (property_id) REFERENCES public.properties(id) not valid;

alter table "public"."maintenance_fees" validate constraint "maintenance_fees_property_id_fkey";

alter table "public"."movements" add constraint "movements_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."movements" validate constraint "movements_created_by_fkey";

alter table "public"."movements" add constraint "movements_type_check" CHECK ((type = ANY (ARRAY['payment'::text, 'maintenance_fee'::text]))) not valid;

alter table "public"."movements" validate constraint "movements_type_check";

alter table "public"."movements" add constraint "movements_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) not valid;

alter table "public"."movements" validate constraint "movements_user_id_fkey";

alter table "public"."payments" add constraint "payments_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."payments" validate constraint "payments_created_by_fkey";

alter table "public"."payments" add constraint "payments_status_check" CHECK ((status = ANY (ARRAY['approved'::text, 'pending_review'::text, 'cancelled'::text]))) not valid;

alter table "public"."payments" validate constraint "payments_status_check";

alter table "public"."payments" add constraint "payments_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) not valid;

alter table "public"."payments" validate constraint "payments_user_id_fkey";

alter table "public"."properties" add constraint "properties_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."properties" validate constraint "properties_community_id_fkey";

alter table "public"."properties" add constraint "properties_contract_id_fkey" FOREIGN KEY (contract_id) REFERENCES public.maintenance_contracts(id) not valid;

alter table "public"."properties" validate constraint "properties_contract_id_fkey";

alter table "public"."properties" add constraint "properties_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."properties" validate constraint "properties_created_by_fkey";

alter table "public"."properties" add constraint "properties_owner_id_fkey" FOREIGN KEY (owner_id) REFERENCES public.users(id) not valid;

alter table "public"."properties" validate constraint "properties_owner_id_fkey";

alter table "public"."user_community" add constraint "user_community_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) ON DELETE CASCADE not valid;

alter table "public"."user_community" validate constraint "user_community_community_id_fkey";

alter table "public"."user_community" add constraint "user_community_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."user_community" validate constraint "user_community_created_by_fkey";

alter table "public"."user_community" add constraint "user_community_status_check" CHECK (((status)::text = ANY ((ARRAY['pending_approval'::character varying, 'approved'::character varying, 'rejected'::character varying])::text[]))) not valid;

alter table "public"."user_community" validate constraint "user_community_status_check";

alter table "public"."user_community" add constraint "user_community_user_id_community_id_key" UNIQUE using index "user_community_user_id_community_id_key";

alter table "public"."user_community" add constraint "user_community_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE not valid;

alter table "public"."user_community" validate constraint "user_community_user_id_fkey";

alter table "public"."users" add constraint "users_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."users" validate constraint "users_created_by_fkey";

alter table "public"."users" add constraint "users_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."users" validate constraint "users_id_fkey";

alter table "public"."visitors" add constraint "visitors_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."visitors" validate constraint "visitors_created_by_fkey";

alter table "public"."visitors" add constraint "visitors_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) not valid;

alter table "public"."visitors" validate constraint "visitors_user_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fn_approve_payment(p_user_id uuid, p_payment_id uuid)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.fn_create_invitation(p_user_id uuid, p_property_id uuid, p_visitor_id uuid, p_from_date timestamp with time zone, p_to_date timestamp with time zone)
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
    IF NOT EXISTS (SELECT 1 FROM properties WHERE id = p_property_id AND user_id = p_user_id) THEN
        RAISE EXCEPTION 'Property ownership error';
    END IF;

    -- Check Visitor
    IF NOT EXISTS (SELECT 1 FROM visitors WHERE id = p_visitor_id AND user_id = p_user_id) THEN
        RAISE EXCEPTION 'Visitor ownership error';
    END IF;

    -- Insert
    INSERT INTO invitations(user_id, property_id, visitor_id, qr_code_token, from_date, to_date, max_entries)
    VALUES (p_user_id, p_property_id, p_visitor_id, gen_random_uuid(), p_from_date, p_to_date, 999999);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.fn_create_user(p_user_id uuid, p_name text, p_email text, p_phone_number text, p_emergency_phone_number text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO users (id, name, email, phone_number, emergency_phone_number)
    VALUES (p_user_id, p_name, p_email, p_phone_number, p_emergency_phone_number);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.fn_join_community(p_user_id uuid, p_community_id uuid)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO user_community (user_id, community_id, status)
    VALUES (p_user_id, p_community_id, 'pending_approval');
END;
$function$
;

CREATE OR REPLACE FUNCTION public.fn_maintenance_fee_movements_sync()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_user_id uuid;
    v_target_record RECORD;
    v_created_by uuid;
BEGIN
    v_created_by := auth.uid();

    -- 1. Identify which record to extract foreign keys from
    IF (TG_OP = 'DELETE') THEN
        v_target_record := OLD;
    ELSE
        v_target_record := NEW;
    END IF;
    -- 2. Get the property owner (user_id)
    SELECT p.user_id INTO v_user_id
    FROM maintenance_fees
    WHERE id = v_target_record.id;

    IF (TG_OP = 'INSERT') THEN
        INSERT INTO public.movements(user_id, created_by, amount_in_cents, type, ref_id, date, description)
        VALUES (v_user_id, v_created_by, v_target_record.amount_in_cents, 'maintenance_fee', v_target_record.id::text, v_target_record.created_at, 'Maintenance fee charge');
    END IF;
    
    RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.fn_register_new_payment(p_user_id uuid, p_amount_in_cents integer, p_date timestamp with time zone, p_reference text, p_note text, p_receipt_path text)
 RETURNS public.payments
 LANGUAGE plpgsql
AS $function$
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
$function$
;

grant delete on table "public"."access_logs" to "anon";

grant insert on table "public"."access_logs" to "anon";

grant references on table "public"."access_logs" to "anon";

grant select on table "public"."access_logs" to "anon";

grant trigger on table "public"."access_logs" to "anon";

grant truncate on table "public"."access_logs" to "anon";

grant update on table "public"."access_logs" to "anon";

grant delete on table "public"."access_logs" to "authenticated";

grant insert on table "public"."access_logs" to "authenticated";

grant references on table "public"."access_logs" to "authenticated";

grant select on table "public"."access_logs" to "authenticated";

grant trigger on table "public"."access_logs" to "authenticated";

grant truncate on table "public"."access_logs" to "authenticated";

grant update on table "public"."access_logs" to "authenticated";

grant delete on table "public"."access_logs" to "service_role";

grant insert on table "public"."access_logs" to "service_role";

grant references on table "public"."access_logs" to "service_role";

grant select on table "public"."access_logs" to "service_role";

grant trigger on table "public"."access_logs" to "service_role";

grant truncate on table "public"."access_logs" to "service_role";

grant update on table "public"."access_logs" to "service_role";

grant delete on table "public"."communities" to "anon";

grant insert on table "public"."communities" to "anon";

grant references on table "public"."communities" to "anon";

grant select on table "public"."communities" to "anon";

grant trigger on table "public"."communities" to "anon";

grant truncate on table "public"."communities" to "anon";

grant update on table "public"."communities" to "anon";

grant delete on table "public"."communities" to "authenticated";

grant insert on table "public"."communities" to "authenticated";

grant references on table "public"."communities" to "authenticated";

grant select on table "public"."communities" to "authenticated";

grant trigger on table "public"."communities" to "authenticated";

grant truncate on table "public"."communities" to "authenticated";

grant update on table "public"."communities" to "authenticated";

grant delete on table "public"."communities" to "service_role";

grant insert on table "public"."communities" to "service_role";

grant references on table "public"."communities" to "service_role";

grant select on table "public"."communities" to "service_role";

grant trigger on table "public"."communities" to "service_role";

grant truncate on table "public"."communities" to "service_role";

grant update on table "public"."communities" to "service_role";

grant delete on table "public"."error_logs" to "anon";

grant insert on table "public"."error_logs" to "anon";

grant references on table "public"."error_logs" to "anon";

grant select on table "public"."error_logs" to "anon";

grant trigger on table "public"."error_logs" to "anon";

grant truncate on table "public"."error_logs" to "anon";

grant update on table "public"."error_logs" to "anon";

grant delete on table "public"."error_logs" to "authenticated";

grant insert on table "public"."error_logs" to "authenticated";

grant references on table "public"."error_logs" to "authenticated";

grant select on table "public"."error_logs" to "authenticated";

grant trigger on table "public"."error_logs" to "authenticated";

grant truncate on table "public"."error_logs" to "authenticated";

grant update on table "public"."error_logs" to "authenticated";

grant delete on table "public"."error_logs" to "service_role";

grant insert on table "public"."error_logs" to "service_role";

grant references on table "public"."error_logs" to "service_role";

grant select on table "public"."error_logs" to "service_role";

grant trigger on table "public"."error_logs" to "service_role";

grant truncate on table "public"."error_logs" to "service_role";

grant update on table "public"."error_logs" to "service_role";

grant delete on table "public"."invitations" to "anon";

grant insert on table "public"."invitations" to "anon";

grant references on table "public"."invitations" to "anon";

grant select on table "public"."invitations" to "anon";

grant trigger on table "public"."invitations" to "anon";

grant truncate on table "public"."invitations" to "anon";

grant update on table "public"."invitations" to "anon";

grant delete on table "public"."invitations" to "authenticated";

grant insert on table "public"."invitations" to "authenticated";

grant references on table "public"."invitations" to "authenticated";

grant select on table "public"."invitations" to "authenticated";

grant trigger on table "public"."invitations" to "authenticated";

grant truncate on table "public"."invitations" to "authenticated";

grant update on table "public"."invitations" to "authenticated";

grant delete on table "public"."invitations" to "service_role";

grant insert on table "public"."invitations" to "service_role";

grant references on table "public"."invitations" to "service_role";

grant select on table "public"."invitations" to "service_role";

grant trigger on table "public"."invitations" to "service_role";

grant truncate on table "public"."invitations" to "service_role";

grant update on table "public"."invitations" to "service_role";

grant delete on table "public"."maintenance_contracts" to "anon";

grant insert on table "public"."maintenance_contracts" to "anon";

grant references on table "public"."maintenance_contracts" to "anon";

grant select on table "public"."maintenance_contracts" to "anon";

grant trigger on table "public"."maintenance_contracts" to "anon";

grant truncate on table "public"."maintenance_contracts" to "anon";

grant update on table "public"."maintenance_contracts" to "anon";

grant delete on table "public"."maintenance_contracts" to "authenticated";

grant insert on table "public"."maintenance_contracts" to "authenticated";

grant references on table "public"."maintenance_contracts" to "authenticated";

grant select on table "public"."maintenance_contracts" to "authenticated";

grant trigger on table "public"."maintenance_contracts" to "authenticated";

grant truncate on table "public"."maintenance_contracts" to "authenticated";

grant update on table "public"."maintenance_contracts" to "authenticated";

grant delete on table "public"."maintenance_contracts" to "service_role";

grant insert on table "public"."maintenance_contracts" to "service_role";

grant references on table "public"."maintenance_contracts" to "service_role";

grant select on table "public"."maintenance_contracts" to "service_role";

grant trigger on table "public"."maintenance_contracts" to "service_role";

grant truncate on table "public"."maintenance_contracts" to "service_role";

grant update on table "public"."maintenance_contracts" to "service_role";

grant delete on table "public"."maintenance_fees" to "anon";

grant insert on table "public"."maintenance_fees" to "anon";

grant references on table "public"."maintenance_fees" to "anon";

grant select on table "public"."maintenance_fees" to "anon";

grant trigger on table "public"."maintenance_fees" to "anon";

grant truncate on table "public"."maintenance_fees" to "anon";

grant update on table "public"."maintenance_fees" to "anon";

grant delete on table "public"."maintenance_fees" to "authenticated";

grant insert on table "public"."maintenance_fees" to "authenticated";

grant references on table "public"."maintenance_fees" to "authenticated";

grant select on table "public"."maintenance_fees" to "authenticated";

grant trigger on table "public"."maintenance_fees" to "authenticated";

grant truncate on table "public"."maintenance_fees" to "authenticated";

grant update on table "public"."maintenance_fees" to "authenticated";

grant delete on table "public"."maintenance_fees" to "service_role";

grant insert on table "public"."maintenance_fees" to "service_role";

grant references on table "public"."maintenance_fees" to "service_role";

grant select on table "public"."maintenance_fees" to "service_role";

grant trigger on table "public"."maintenance_fees" to "service_role";

grant truncate on table "public"."maintenance_fees" to "service_role";

grant update on table "public"."maintenance_fees" to "service_role";

grant delete on table "public"."movements" to "anon";

grant insert on table "public"."movements" to "anon";

grant references on table "public"."movements" to "anon";

grant select on table "public"."movements" to "anon";

grant trigger on table "public"."movements" to "anon";

grant truncate on table "public"."movements" to "anon";

grant update on table "public"."movements" to "anon";

grant delete on table "public"."movements" to "authenticated";

grant insert on table "public"."movements" to "authenticated";

grant references on table "public"."movements" to "authenticated";

grant select on table "public"."movements" to "authenticated";

grant trigger on table "public"."movements" to "authenticated";

grant truncate on table "public"."movements" to "authenticated";

grant update on table "public"."movements" to "authenticated";

grant delete on table "public"."movements" to "service_role";

grant insert on table "public"."movements" to "service_role";

grant references on table "public"."movements" to "service_role";

grant select on table "public"."movements" to "service_role";

grant trigger on table "public"."movements" to "service_role";

grant truncate on table "public"."movements" to "service_role";

grant update on table "public"."movements" to "service_role";

grant delete on table "public"."payments" to "anon";

grant insert on table "public"."payments" to "anon";

grant references on table "public"."payments" to "anon";

grant select on table "public"."payments" to "anon";

grant trigger on table "public"."payments" to "anon";

grant truncate on table "public"."payments" to "anon";

grant update on table "public"."payments" to "anon";

grant delete on table "public"."payments" to "authenticated";

grant insert on table "public"."payments" to "authenticated";

grant references on table "public"."payments" to "authenticated";

grant select on table "public"."payments" to "authenticated";

grant trigger on table "public"."payments" to "authenticated";

grant truncate on table "public"."payments" to "authenticated";

grant update on table "public"."payments" to "authenticated";

grant delete on table "public"."payments" to "service_role";

grant insert on table "public"."payments" to "service_role";

grant references on table "public"."payments" to "service_role";

grant select on table "public"."payments" to "service_role";

grant trigger on table "public"."payments" to "service_role";

grant truncate on table "public"."payments" to "service_role";

grant update on table "public"."payments" to "service_role";

grant delete on table "public"."properties" to "anon";

grant insert on table "public"."properties" to "anon";

grant references on table "public"."properties" to "anon";

grant select on table "public"."properties" to "anon";

grant trigger on table "public"."properties" to "anon";

grant truncate on table "public"."properties" to "anon";

grant update on table "public"."properties" to "anon";

grant delete on table "public"."properties" to "authenticated";

grant insert on table "public"."properties" to "authenticated";

grant references on table "public"."properties" to "authenticated";

grant select on table "public"."properties" to "authenticated";

grant trigger on table "public"."properties" to "authenticated";

grant truncate on table "public"."properties" to "authenticated";

grant update on table "public"."properties" to "authenticated";

grant delete on table "public"."properties" to "service_role";

grant insert on table "public"."properties" to "service_role";

grant references on table "public"."properties" to "service_role";

grant select on table "public"."properties" to "service_role";

grant trigger on table "public"."properties" to "service_role";

grant truncate on table "public"."properties" to "service_role";

grant update on table "public"."properties" to "service_role";

grant delete on table "public"."user_community" to "anon";

grant insert on table "public"."user_community" to "anon";

grant references on table "public"."user_community" to "anon";

grant select on table "public"."user_community" to "anon";

grant trigger on table "public"."user_community" to "anon";

grant truncate on table "public"."user_community" to "anon";

grant update on table "public"."user_community" to "anon";

grant delete on table "public"."user_community" to "authenticated";

grant insert on table "public"."user_community" to "authenticated";

grant references on table "public"."user_community" to "authenticated";

grant select on table "public"."user_community" to "authenticated";

grant trigger on table "public"."user_community" to "authenticated";

grant truncate on table "public"."user_community" to "authenticated";

grant update on table "public"."user_community" to "authenticated";

grant delete on table "public"."user_community" to "service_role";

grant insert on table "public"."user_community" to "service_role";

grant references on table "public"."user_community" to "service_role";

grant select on table "public"."user_community" to "service_role";

grant trigger on table "public"."user_community" to "service_role";

grant truncate on table "public"."user_community" to "service_role";

grant update on table "public"."user_community" to "service_role";

grant delete on table "public"."users" to "anon";

grant insert on table "public"."users" to "anon";

grant references on table "public"."users" to "anon";

grant select on table "public"."users" to "anon";

grant trigger on table "public"."users" to "anon";

grant truncate on table "public"."users" to "anon";

grant update on table "public"."users" to "anon";

grant delete on table "public"."users" to "authenticated";

grant insert on table "public"."users" to "authenticated";

grant references on table "public"."users" to "authenticated";

grant select on table "public"."users" to "authenticated";

grant trigger on table "public"."users" to "authenticated";

grant truncate on table "public"."users" to "authenticated";

grant update on table "public"."users" to "authenticated";

grant delete on table "public"."users" to "service_role";

grant insert on table "public"."users" to "service_role";

grant references on table "public"."users" to "service_role";

grant select on table "public"."users" to "service_role";

grant trigger on table "public"."users" to "service_role";

grant truncate on table "public"."users" to "service_role";

grant update on table "public"."users" to "service_role";

grant delete on table "public"."visitors" to "anon";

grant insert on table "public"."visitors" to "anon";

grant references on table "public"."visitors" to "anon";

grant select on table "public"."visitors" to "anon";

grant trigger on table "public"."visitors" to "anon";

grant truncate on table "public"."visitors" to "anon";

grant update on table "public"."visitors" to "anon";

grant delete on table "public"."visitors" to "authenticated";

grant insert on table "public"."visitors" to "authenticated";

grant references on table "public"."visitors" to "authenticated";

grant select on table "public"."visitors" to "authenticated";

grant trigger on table "public"."visitors" to "authenticated";

grant truncate on table "public"."visitors" to "authenticated";

grant update on table "public"."visitors" to "authenticated";

grant delete on table "public"."visitors" to "service_role";

grant insert on table "public"."visitors" to "service_role";

grant references on table "public"."visitors" to "service_role";

grant select on table "public"."visitors" to "service_role";

grant trigger on table "public"."visitors" to "service_role";

grant truncate on table "public"."visitors" to "service_role";

grant update on table "public"."visitors" to "service_role";

CREATE TRIGGER trg_maintenance_fee_movements_sync AFTER INSERT OR DELETE OR UPDATE ON public.maintenance_fees FOR EACH ROW EXECUTE FUNCTION public.fn_maintenance_fee_movements_sync();


