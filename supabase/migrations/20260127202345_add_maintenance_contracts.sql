
  create table "public"."maintenance_contracts" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "property_id" uuid not null,
    "created_at" timestamp with time zone not null default now(),
    "period" text not null,
    "amount_in_cents" integer not null,
    "from_date" timestamp with time zone not null,
    "to_date" timestamp with time zone not null,
    "description" text
      );


CREATE UNIQUE INDEX maintenance_contracts_pkey ON public.maintenance_contracts USING btree (id);

alter table "public"."maintenance_contracts" add constraint "maintenance_contracts_pkey" PRIMARY KEY using index "maintenance_contracts_pkey";

alter table "public"."maintenance_contracts" add constraint "maintenance_contracts_period_check" CHECK ((period = 'monthly'::text)) not valid;

alter table "public"."maintenance_contracts" validate constraint "maintenance_contracts_period_check";

alter table "public"."maintenance_contracts" add constraint "maintenance_contracts_property_id_fkey" FOREIGN KEY (property_id) REFERENCES public.properties(id) not valid;

alter table "public"."maintenance_contracts" validate constraint "maintenance_contracts_property_id_fkey";

alter table "public"."maintenance_contracts" add constraint "maintenance_contracts_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) not valid;

alter table "public"."maintenance_contracts" validate constraint "maintenance_contracts_user_id_fkey";

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


