
  create table "public"."payments" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "created_at" timestamp with time zone not null default now(),
    "amount_in_cents" integer not null,
    "date" timestamp with time zone not null,
    "reference" text,
    "note" text
      );


CREATE UNIQUE INDEX payments_pkey ON public.payments USING btree (id);

alter table "public"."payments" add constraint "payments_pkey" PRIMARY KEY using index "payments_pkey";

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

CREATE TRIGGER trg_after_payment_insert AFTER INSERT ON public.payments FOR EACH ROW EXECUTE FUNCTION public.fn_after_payment_insert();


