
  create table "public"."movements" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "created_at" timestamp with time zone not null default now(),
    "amount_in_cents" integer not null,
    "type" text not null,
    "ref_source" text not null,
    "ref_id" text not null
      );


alter table "public"."profile" add column "user_id" uuid not null;

alter table "public"."profile" alter column "email" set not null;

alter table "public"."profile" alter column "emergency_phone_number" set not null;

alter table "public"."profile" alter column "phone_number" set not null;

CREATE UNIQUE INDEX movements_pkey ON public.movements USING btree (id);

alter table "public"."movements" add constraint "movements_pkey" PRIMARY KEY using index "movements_pkey";

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


