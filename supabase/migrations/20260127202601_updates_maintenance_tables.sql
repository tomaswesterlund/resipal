
  create table "public"."maintenance_fees" (
    "id" uuid not null default gen_random_uuid(),
    "contract_id" uuid not null,
    "created_at" timestamp with time zone not null default now(),
    "amount_in_cents" integer not null,
    "status" text not null,
    "from_date" timestamp with time zone not null,
    "to_date" timestamp with time zone not null,
    "note" text
      );


alter table "public"."maintenance_contracts" drop column "from_date";

alter table "public"."maintenance_contracts" drop column "to_date";

CREATE UNIQUE INDEX maintenance_fees_pkey ON public.maintenance_fees USING btree (id);

alter table "public"."maintenance_fees" add constraint "maintenance_fees_pkey" PRIMARY KEY using index "maintenance_fees_pkey";

alter table "public"."maintenance_fees" add constraint "maintenance_fees_contract_id_fkey" FOREIGN KEY (contract_id) REFERENCES public.maintenance_contracts(id) not valid;

alter table "public"."maintenance_fees" validate constraint "maintenance_fees_contract_id_fkey";

alter table "public"."maintenance_fees" add constraint "maintenance_fees_status_check" CHECK ((status = ANY (ARRAY['paid'::text, 'pending'::text]))) not valid;

alter table "public"."maintenance_fees" validate constraint "maintenance_fees_status_check";

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


