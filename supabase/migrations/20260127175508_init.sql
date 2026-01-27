
  create table "public"."access_logs" (
    "id" uuid not null default gen_random_uuid(),
    "invitation_id" uuid not null,
    "created_at" timestamp with time zone not null default now(),
    "direction" text not null,
    "timestamp" timestamp with time zone not null
      );



  create table "public"."error_logs" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid,
    "created_at" timestamp with time zone not null default now(),
    "error_message" text not null,
    "stack_trace" text,
    "platform" text,
    "app_version" text,
    "feature_area" text,
    "metadata" jsonb
      );



  create table "public"."invitations" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "property_id" uuid not null,
    "visitor_id" uuid not null,
    "created_at" timestamp with time zone not null default now(),
    "qr_code_token" uuid not null,
    "from_date" timestamp with time zone not null,
    "to_date" timestamp with time zone not null,
    "max_entries" integer not null
      );



  create table "public"."movements" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "created_at" timestamp with time zone not null default now(),
    "amount_in_cents" integer not null,
    "type" text not null,
    "ref_source" text not null,
    "ref_id" text not null
      );



  create table "public"."payments" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "created_at" timestamp with time zone not null default now(),
    "amount_in_cents" integer not null,
    "status" text not null,
    "date" timestamp with time zone not null,
    "reference" text,
    "note" text
      );



  create table "public"."properties" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "created_at" timestamp with time zone not null default now(),
    "name" text not null,
    "description" text
      );



  create table "public"."users" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "name" text not null,
    "phone_number" text not null,
    "emergency_phone_number" text not null,
    "email" text not null
      );



  create table "public"."visitors" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "created_at" timestamp with time zone not null default now(),
    "name" text not null
      );


CREATE UNIQUE INDEX access_logs_pkey ON public.access_logs USING btree (id);

CREATE UNIQUE INDEX error_logs_pkey ON public.error_logs USING btree (id);

CREATE INDEX idx_error_logs_created_at ON public.error_logs USING btree (created_at);

CREATE INDEX idx_error_logs_user ON public.error_logs USING btree (user_id);

CREATE UNIQUE INDEX invitations_pkey ON public.invitations USING btree (id);

CREATE UNIQUE INDEX movements_pkey ON public.movements USING btree (id);

CREATE UNIQUE INDEX payments_pkey ON public.payments USING btree (id);

CREATE UNIQUE INDEX properties_pkey ON public.properties USING btree (id);

CREATE UNIQUE INDEX users_pkey ON public.users USING btree (id);

CREATE UNIQUE INDEX visitors_pkey ON public.visitors USING btree (id);

alter table "public"."access_logs" add constraint "access_logs_pkey" PRIMARY KEY using index "access_logs_pkey";

alter table "public"."error_logs" add constraint "error_logs_pkey" PRIMARY KEY using index "error_logs_pkey";

alter table "public"."invitations" add constraint "invitations_pkey" PRIMARY KEY using index "invitations_pkey";

alter table "public"."movements" add constraint "movements_pkey" PRIMARY KEY using index "movements_pkey";

alter table "public"."payments" add constraint "payments_pkey" PRIMARY KEY using index "payments_pkey";

alter table "public"."properties" add constraint "properties_pkey" PRIMARY KEY using index "properties_pkey";

alter table "public"."users" add constraint "users_pkey" PRIMARY KEY using index "users_pkey";

alter table "public"."visitors" add constraint "visitors_pkey" PRIMARY KEY using index "visitors_pkey";

alter table "public"."access_logs" add constraint "access_logs_invitation_id_fkey" FOREIGN KEY (invitation_id) REFERENCES public.invitations(id) not valid;

alter table "public"."access_logs" validate constraint "access_logs_invitation_id_fkey";

alter table "public"."error_logs" add constraint "error_logs_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL not valid;

alter table "public"."error_logs" validate constraint "error_logs_user_id_fkey";

alter table "public"."invitations" add constraint "invitations_property_id_fkey" FOREIGN KEY (property_id) REFERENCES public.properties(id) not valid;

alter table "public"."invitations" validate constraint "invitations_property_id_fkey";

alter table "public"."invitations" add constraint "invitations_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) not valid;

alter table "public"."invitations" validate constraint "invitations_user_id_fkey";

alter table "public"."invitations" add constraint "invitations_visitor_id_fkey" FOREIGN KEY (visitor_id) REFERENCES public.visitors(id) not valid;

alter table "public"."invitations" validate constraint "invitations_visitor_id_fkey";

alter table "public"."movements" add constraint "movements_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) not valid;

alter table "public"."movements" validate constraint "movements_user_id_fkey";

alter table "public"."payments" add constraint "payments_status_check" CHECK ((status = ANY (ARRAY['approved'::text, 'pending_review'::text, 'cancelled'::text]))) not valid;

alter table "public"."payments" validate constraint "payments_status_check";

alter table "public"."payments" add constraint "payments_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) not valid;

alter table "public"."payments" validate constraint "payments_user_id_fkey";

alter table "public"."properties" add constraint "properties_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) not valid;

alter table "public"."properties" validate constraint "properties_user_id_fkey";

alter table "public"."visitors" add constraint "visitors_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) not valid;

alter table "public"."visitors" validate constraint "visitors_user_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fn_after_payment_insert()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO public.movements (
        user_id,
        amount_in_cents,
        type,
        ref_source,
        ref_id,
        created_at
    )
    VALUES (
        NEW.user_id,
        NEW.amount_in_cents,
        'payment',
        'payments_table',
        NEW.id::TEXT,
        NEW.created_at
    );
    RETURN NEW;
END;
$function$
;

CREATE OR REPLACE FUNCTION public.fn_register_new_payment(p_user_id uuid, p_amount_in_cents integer, p_date timestamp with time zone, p_reference text, p_note text)
 RETURNS public.payments
 LANGUAGE plpgsql
AS $function$
DECLARE
    new_row payments;
BEGIN
    -- Validation: Amount in cents is greater than 0, date is not in the future etc.
    INSERT INTO payments(user_id, amount_in_cents, status, date, reference, note)
        VALUES (p_user_id, p_amount_in_cents, 'pending_review', p_date, p_reference, p_note)
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

CREATE TRIGGER trg_after_payment_insert AFTER INSERT ON public.payments FOR EACH ROW EXECUTE FUNCTION public.fn_after_payment_insert();


