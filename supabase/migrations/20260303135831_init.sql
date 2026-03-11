
  create table "public"."access_logs" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "community_id" uuid not null,
    "invitation_id" uuid not null,
    "direction" text not null,
    "timestamp" timestamp with time zone not null
      );



  create table "public"."communities" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "name" text not null,
    "description" text,
    "location" text not null
      );



  create table "public"."contracts" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "community_id" uuid not null,
    "name" text not null,
    "period" text not null,
    "amount_in_cents" integer not null,
    "description" text
      );



  create table "public"."error_logs" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid default auth.uid(),
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
    "community_id" uuid not null,
    "user_id" uuid not null,
    "property_id" uuid not null,
    "visitor_id" uuid not null,
    "qr_code_token" uuid not null,
    "from_date" timestamp with time zone not null,
    "to_date" timestamp with time zone not null,
    "max_entries" integer not null
      );



  create table "public"."maintenance_fees" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "community_id" uuid not null,
    "contract_id" uuid not null,
    "property_id" uuid not null,
    "amount_in_cents" integer not null,
    "due_date" timestamp with time zone not null,
    "payment_date" timestamp with time zone,
    "from_date" timestamp with time zone not null,
    "to_date" timestamp with time zone not null,
    "note" text
      );



  create table "public"."payments" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "user_id" uuid not null,
    "community_id" uuid not null,
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
    "resident_id" uuid,
    "contract_id" uuid,
    "name" text not null,
    "description" text
      );



  create table "public"."users" (
    "id" uuid not null,
    "community_id" uuid,
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "name" text not null,
    "phone_number" text not null,
    "emergency_phone_number" text,
    "email" text not null,
    "application_status" text not null,
    "application_message" text not null,
    "is_admin" boolean not null,
    "is_resident" boolean not null,
    "is_security" boolean not null
      );



  create table "public"."visitors" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "community_id" uuid not null,
    "user_id" uuid not null,
    "name" text not null,
    "identification_path" text not null
      );


CREATE UNIQUE INDEX access_logs_pkey ON public.access_logs USING btree (id);

CREATE UNIQUE INDEX communities_pkey ON public.communities USING btree (id);

CREATE UNIQUE INDEX contracts_pkey ON public.contracts USING btree (id);

CREATE UNIQUE INDEX error_logs_pkey ON public.error_logs USING btree (id);

CREATE UNIQUE INDEX invitations_pkey ON public.invitations USING btree (id);

CREATE UNIQUE INDEX maintenance_fees_pkey ON public.maintenance_fees USING btree (id);

CREATE UNIQUE INDEX payments_pkey ON public.payments USING btree (id);

CREATE UNIQUE INDEX properties_pkey ON public.properties USING btree (id);

CREATE UNIQUE INDEX users_id_community_id_key ON public.users USING btree (id, community_id);

CREATE UNIQUE INDEX users_pkey ON public.users USING btree (id);

CREATE UNIQUE INDEX visitors_pkey ON public.visitors USING btree (id);

alter table "public"."access_logs" add constraint "access_logs_pkey" PRIMARY KEY using index "access_logs_pkey";

alter table "public"."communities" add constraint "communities_pkey" PRIMARY KEY using index "communities_pkey";

alter table "public"."contracts" add constraint "contracts_pkey" PRIMARY KEY using index "contracts_pkey";

alter table "public"."error_logs" add constraint "error_logs_pkey" PRIMARY KEY using index "error_logs_pkey";

alter table "public"."invitations" add constraint "invitations_pkey" PRIMARY KEY using index "invitations_pkey";

alter table "public"."maintenance_fees" add constraint "maintenance_fees_pkey" PRIMARY KEY using index "maintenance_fees_pkey";

alter table "public"."payments" add constraint "payments_pkey" PRIMARY KEY using index "payments_pkey";

alter table "public"."properties" add constraint "properties_pkey" PRIMARY KEY using index "properties_pkey";

alter table "public"."users" add constraint "users_pkey" PRIMARY KEY using index "users_pkey";

alter table "public"."visitors" add constraint "visitors_pkey" PRIMARY KEY using index "visitors_pkey";

alter table "public"."access_logs" add constraint "access_logs_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."access_logs" validate constraint "access_logs_community_id_fkey";

alter table "public"."access_logs" add constraint "access_logs_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."access_logs" validate constraint "access_logs_created_by_fkey";

alter table "public"."access_logs" add constraint "access_logs_invitation_id_fkey" FOREIGN KEY (invitation_id) REFERENCES public.invitations(id) not valid;

alter table "public"."access_logs" validate constraint "access_logs_invitation_id_fkey";

alter table "public"."communities" add constraint "communities_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."communities" validate constraint "communities_created_by_fkey";

alter table "public"."contracts" add constraint "contracts_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."contracts" validate constraint "contracts_community_id_fkey";

alter table "public"."contracts" add constraint "contracts_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."contracts" validate constraint "contracts_created_by_fkey";

alter table "public"."contracts" add constraint "contracts_period_check" CHECK ((period = 'monthly'::text)) not valid;

alter table "public"."contracts" validate constraint "contracts_period_check";

alter table "public"."error_logs" add constraint "error_logs_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."error_logs" validate constraint "error_logs_created_by_fkey";

alter table "public"."invitations" add constraint "invitations_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."invitations" validate constraint "invitations_community_id_fkey";

alter table "public"."invitations" add constraint "invitations_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."invitations" validate constraint "invitations_created_by_fkey";

alter table "public"."invitations" add constraint "invitations_property_id_fkey" FOREIGN KEY (property_id) REFERENCES public.properties(id) not valid;

alter table "public"."invitations" validate constraint "invitations_property_id_fkey";

alter table "public"."invitations" add constraint "invitations_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) not valid;

alter table "public"."invitations" validate constraint "invitations_user_id_fkey";

alter table "public"."invitations" add constraint "invitations_visitor_id_fkey" FOREIGN KEY (visitor_id) REFERENCES public.visitors(id) not valid;

alter table "public"."invitations" validate constraint "invitations_visitor_id_fkey";

alter table "public"."maintenance_fees" add constraint "maintenance_fees_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."maintenance_fees" validate constraint "maintenance_fees_community_id_fkey";

alter table "public"."maintenance_fees" add constraint "maintenance_fees_contract_id_fkey" FOREIGN KEY (contract_id) REFERENCES public.contracts(id) not valid;

alter table "public"."maintenance_fees" validate constraint "maintenance_fees_contract_id_fkey";

alter table "public"."maintenance_fees" add constraint "maintenance_fees_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."maintenance_fees" validate constraint "maintenance_fees_created_by_fkey";

alter table "public"."maintenance_fees" add constraint "maintenance_fees_property_id_fkey" FOREIGN KEY (property_id) REFERENCES public.properties(id) not valid;

alter table "public"."maintenance_fees" validate constraint "maintenance_fees_property_id_fkey";

alter table "public"."payments" add constraint "payments_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."payments" validate constraint "payments_community_id_fkey";

alter table "public"."payments" add constraint "payments_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."payments" validate constraint "payments_created_by_fkey";

alter table "public"."payments" add constraint "payments_status_check" CHECK ((status = ANY (ARRAY['approved'::text, 'pending_review'::text, 'cancelled'::text]))) not valid;

alter table "public"."payments" validate constraint "payments_status_check";

alter table "public"."payments" add constraint "payments_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) not valid;

alter table "public"."payments" validate constraint "payments_user_id_fkey";

alter table "public"."properties" add constraint "properties_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."properties" validate constraint "properties_community_id_fkey";

alter table "public"."properties" add constraint "properties_contract_id_fkey" FOREIGN KEY (contract_id) REFERENCES public.contracts(id) not valid;

alter table "public"."properties" validate constraint "properties_contract_id_fkey";

alter table "public"."properties" add constraint "properties_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."properties" validate constraint "properties_created_by_fkey";

alter table "public"."properties" add constraint "properties_resident_id_fkey" FOREIGN KEY (resident_id) REFERENCES public.users(id) not valid;

alter table "public"."properties" validate constraint "properties_resident_id_fkey";

alter table "public"."users" add constraint "users_application_status_check" CHECK ((application_status = ANY (ARRAY['pending_approval'::text, 'approved'::text, 'rejected'::text]))) not valid;

alter table "public"."users" validate constraint "users_application_status_check";

alter table "public"."users" add constraint "users_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."users" validate constraint "users_community_id_fkey";

alter table "public"."users" add constraint "users_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."users" validate constraint "users_created_by_fkey";

alter table "public"."users" add constraint "users_id_community_id_key" UNIQUE using index "users_id_community_id_key";

alter table "public"."users" add constraint "users_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) not valid;

alter table "public"."users" validate constraint "users_id_fkey";

alter table "public"."visitors" add constraint "visitors_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."visitors" validate constraint "visitors_community_id_fkey";

alter table "public"."visitors" add constraint "visitors_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."visitors" validate constraint "visitors_created_by_fkey";

alter table "public"."visitors" add constraint "visitors_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) not valid;

alter table "public"."visitors" validate constraint "visitors_user_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fn_check_is_admin(p_user_id uuid, p_community_id uuid)
 RETURNS boolean
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM users 
    WHERE community_id = p_community_id 
    AND id = p_user_id 
    AND is_admin = TRUE
  );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.fn_confirm_payment_received(p_community_id uuid, p_user_id uuid, p_payment_id uuid)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
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
$function$
;

CREATE OR REPLACE FUNCTION public.fn_create_application(p_community_id uuid, p_user_id uuid)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE
    v_email TEXT;
BEGIN
    v_email := auth.jwt() ->> 'email';

    INSERT INTO applications (community_id, user_id, status, message)
    VALUES (
        p_community_id, 
        p_user_id, 
        'pending_review', 
        'Creada para ' || v_email
    );
END;
$function$
;

CREATE OR REPLACE FUNCTION public.fn_create_community(p_user_id uuid, p_name text, p_description text, p_location text, p_is_admin boolean, p_is_security boolean, p_is_user boolean)
 RETURNS uuid
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE
  new_community_id UUID;
BEGIN
  -- 1. Validations
  IF p_name IS NULL OR trim(p_name) = '' THEN
    RAISE EXCEPTION 'El nombre de la comunidad no puede estar vacío';
  END IF;

  IF p_location IS NULL OR trim(p_location) = '' THEN
    RAISE EXCEPTION 'La ubicación es obligatoria';
  END IF;

  -- 2. Insert the Community
  INSERT INTO communities (
    name,
    description,
    location,
    created_by
  ) VALUES (
    p_name,
    p_description,
    p_location,
    p_user_id
  ) RETURNING id INTO new_community_id;

  RETURN new_community_id;

END;
$function$
;

CREATE OR REPLACE FUNCTION public.fn_create_contract(p_community_id uuid, p_name text, p_amount_in_cents integer, p_period text, p_description text)
 RETURNS uuid
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE
    v_user_id uuid;
    new_contract_id uuid;
BEGIN
    -- 1. Get current user session for auditing
    v_user_id := auth.uid();
    IF v_user_id IS NULL THEN
        RAISE EXCEPTION 'Usuario no autenticado';
    END IF;
    -- 2. Validations
    IF p_name IS NULL OR trim(p_name) = '' THEN
        RAISE EXCEPTION 'El nombre del contrato es obligatorio';
    END IF;
    IF p_amount_in_cents < 0 THEN
        RAISE EXCEPTION 'El monto no puede ser negativo';
    END IF;
    -- Verify the community exists and the user has permission to add contracts to it
    IF NOT fn_check_is_admin(auth.uid(), p_community_id) THEN
        RAISE EXCEPTION 'No tienes permisos de administrador en esta comunidad';
    END IF;
    -- 3. Insert the Contract
    INSERT INTO contracts(community_id, name, amount_in_cents, period, description, created_by)
        VALUES (p_community_id, p_name, p_amount_in_cents, p_period, p_description, v_user_id)
    RETURNING
        id INTO new_contract_id;
    RETURN new_contract_id;
END;
$function$
;

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
            AND resident_id = p_user_id) THEN
    RAISE EXCEPTION 'Property resident error';
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
    INSERT INTO invitations(community_id, user_id, property_id, visitor_id, qr_code_token, from_date, to_date, max_entries)
        VALUES(p_community_id, p_user_id, p_property_id, p_visitor_id, gen_random_uuid(), p_from_date, p_to_date, 999999);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.fn_create_user(p_name text, p_email text, p_phone_number text, p_emergency_phone_number text, p_application_status text, p_application_message text, p_is_admin boolean, p_is_resident boolean, p_is_security boolean)
 RETURNS uuid
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE
  new_user_id UUID;
BEGIN
    -- Get the ID from the current authenticated session
    new_user_id := auth.uid();

    -- Validation: Ensure we actually have a session
    IF new_user_id IS NULL THEN
        RAISE EXCEPTION 'No se pudo obtener el ID del usuario autenticado.';
    END IF;

    INSERT INTO users (id, name, email, phone_number, emergency_phone_number, application_status, application_message, is_admin, is_resident, is_security)
    VALUES (new_user_id, p_name, p_email, p_phone_number, p_emergency_phone_number, p_application_status, p_application_message, p_is_admin, p_is_resident, p_is_security)
    RETURNING id INTO new_user_id;

    RETURN new_user_id;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.fn_create_visitor(p_community_id uuid, p_user_id uuid, p_name text, p_identification_path text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO visitors(community_id, user_id, name, identification_path)
    VALUES (p_community_id, p_user_id, p_name, p_identification_path);
END;
$function$
;

CREATE OR REPLACE FUNCTION public.fn_log_error(p_error_message text, p_stack_trace text DEFAULT NULL::text, p_platform text DEFAULT NULL::text, p_app_version text DEFAULT NULL::text, p_feature_area text DEFAULT NULL::text, p_metadata jsonb DEFAULT '{}'::jsonb)
 RETURNS uuid
 LANGUAGE plpgsql
AS $function$
DECLARE
    v_new_id UUID;
BEGIN
    INSERT INTO error_logs (
        error_message,
        stack_trace,
        platform,
        app_version,
        feature_area,
        metadata
    )
    VALUES (
        p_error_message,
        p_stack_trace,
        p_platform,
        p_app_version,
        p_feature_area,
        p_metadata
    )
    RETURNING id INTO v_new_id;

    RETURN v_new_id;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.fn_register_payment(p_community_id uuid, p_user_id uuid, p_amount_in_cents integer, p_date timestamp with time zone, p_reference text, p_note text, p_receipt_path text)
 RETURNS public.payments
 LANGUAGE plpgsql
AS $function$
DECLARE
    new_row payments;
BEGIN
    -- Validation: Amount in cents is greater than 0, date is not in the future etc.
    INSERT INTO payments(community_id, user_id, amount_in_cents, status, date, reference, note, receipt_path)
        VALUES (p_community_id, p_user_id, p_amount_in_cents, 'pending_review', p_date, p_reference, p_note, p_receipt_path)
    RETURNING
        * INTO new_row;
    RETURN new_row;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.fn_register_property(p_community_id uuid, p_resident_id uuid, p_contract_id uuid, p_name text, p_description text)
 RETURNS uuid
 LANGUAGE plpgsql
AS $function$
DECLARE
    new_property_id UUID; -- Changed variable type
BEGIN
    INSERT INTO properties(
        created_by, 
        community_id, 
        resident_id, 
        contract_id, 
        name, 
        description
    )
    VALUES (
        auth.uid(),
        p_community_id, 
        p_resident_id, 
        p_contract_id, 
        p_name, 
        p_description
    )
    RETURNING id INTO new_property_id; -- Only return the id column

    RETURN new_property_id;
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

grant delete on table "public"."contracts" to "anon";

grant insert on table "public"."contracts" to "anon";

grant references on table "public"."contracts" to "anon";

grant select on table "public"."contracts" to "anon";

grant trigger on table "public"."contracts" to "anon";

grant truncate on table "public"."contracts" to "anon";

grant update on table "public"."contracts" to "anon";

grant delete on table "public"."contracts" to "authenticated";

grant insert on table "public"."contracts" to "authenticated";

grant references on table "public"."contracts" to "authenticated";

grant select on table "public"."contracts" to "authenticated";

grant trigger on table "public"."contracts" to "authenticated";

grant truncate on table "public"."contracts" to "authenticated";

grant update on table "public"."contracts" to "authenticated";

grant delete on table "public"."contracts" to "service_role";

grant insert on table "public"."contracts" to "service_role";

grant references on table "public"."contracts" to "service_role";

grant select on table "public"."contracts" to "service_role";

grant trigger on table "public"."contracts" to "service_role";

grant truncate on table "public"."contracts" to "service_role";

grant update on table "public"."contracts" to "service_role";

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


