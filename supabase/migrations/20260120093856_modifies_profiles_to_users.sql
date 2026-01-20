revoke delete on table "public"."profile" from "anon";

revoke insert on table "public"."profile" from "anon";

revoke references on table "public"."profile" from "anon";

revoke select on table "public"."profile" from "anon";

revoke trigger on table "public"."profile" from "anon";

revoke truncate on table "public"."profile" from "anon";

revoke update on table "public"."profile" from "anon";

revoke delete on table "public"."profile" from "authenticated";

revoke insert on table "public"."profile" from "authenticated";

revoke references on table "public"."profile" from "authenticated";

revoke select on table "public"."profile" from "authenticated";

revoke trigger on table "public"."profile" from "authenticated";

revoke truncate on table "public"."profile" from "authenticated";

revoke update on table "public"."profile" from "authenticated";

revoke delete on table "public"."profile" from "service_role";

revoke insert on table "public"."profile" from "service_role";

revoke references on table "public"."profile" from "service_role";

revoke select on table "public"."profile" from "service_role";

revoke trigger on table "public"."profile" from "service_role";

revoke truncate on table "public"."profile" from "service_role";

revoke update on table "public"."profile" from "service_role";

alter table "public"."profile" drop constraint "profile_pkey";

drop index if exists "public"."profile_pkey";

drop table "public"."profile";


  create table "public"."users" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "name" text not null,
    "phone_number" text not null,
    "emergency_phone_number" text not null,
    "email" text not null
      );


CREATE UNIQUE INDEX users_pkey ON public.users USING btree (id);

alter table "public"."users" add constraint "users_pkey" PRIMARY KEY using index "users_pkey";

alter table "public"."movements" add constraint "movements_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) not valid;

alter table "public"."movements" validate constraint "movements_user_id_fkey";

alter table "public"."payments" add constraint "payments_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) not valid;

alter table "public"."payments" validate constraint "payments_user_id_fkey";

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


