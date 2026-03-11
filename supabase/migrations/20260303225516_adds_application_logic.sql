alter table "public"."users" drop constraint "users_application_status_check";

alter table "public"."users" drop constraint "users_community_id_fkey";

alter table "public"."users" drop constraint "users_id_community_id_key";

drop index if exists "public"."users_id_community_id_key";


  create table "public"."applications" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid,
    "community_id" uuid not null,
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "name" text not null,
    "phone_number" text not null,
    "emergency_phone_number" text,
    "email" text not null,
    "status" text not null,
    "message" text not null,
    "is_admin" boolean not null,
    "is_resident" boolean not null,
    "is_security" boolean not null
      );


alter table "public"."users" drop column "application_message";

alter table "public"."users" drop column "application_status";

alter table "public"."users" drop column "community_id";

CREATE UNIQUE INDEX applications_pkey ON public.applications USING btree (id);

alter table "public"."applications" add constraint "applications_pkey" PRIMARY KEY using index "applications_pkey";

alter table "public"."applications" add constraint "applications_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."applications" validate constraint "applications_community_id_fkey";

alter table "public"."applications" add constraint "applications_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."applications" validate constraint "applications_created_by_fkey";

alter table "public"."applications" add constraint "applications_status_check" CHECK ((status = ANY (ARRAY['pending_approval'::text, 'invited'::text, 'approved'::text, 'rejected'::text, 'revoked'::text]))) not valid;

alter table "public"."applications" validate constraint "applications_status_check";

alter table "public"."applications" add constraint "applications_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) not valid;

alter table "public"."applications" validate constraint "applications_user_id_fkey";

grant delete on table "public"."applications" to "anon";

grant insert on table "public"."applications" to "anon";

grant references on table "public"."applications" to "anon";

grant select on table "public"."applications" to "anon";

grant trigger on table "public"."applications" to "anon";

grant truncate on table "public"."applications" to "anon";

grant update on table "public"."applications" to "anon";

grant delete on table "public"."applications" to "authenticated";

grant insert on table "public"."applications" to "authenticated";

grant references on table "public"."applications" to "authenticated";

grant select on table "public"."applications" to "authenticated";

grant trigger on table "public"."applications" to "authenticated";

grant truncate on table "public"."applications" to "authenticated";

grant update on table "public"."applications" to "authenticated";

grant delete on table "public"."applications" to "service_role";

grant insert on table "public"."applications" to "service_role";

grant references on table "public"."applications" to "service_role";

grant select on table "public"."applications" to "service_role";

grant trigger on table "public"."applications" to "service_role";

grant truncate on table "public"."applications" to "service_role";

grant update on table "public"."applications" to "service_role";


