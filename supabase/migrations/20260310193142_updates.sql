revoke delete on table "public"."error_logs" from "anon";

revoke insert on table "public"."error_logs" from "anon";

revoke references on table "public"."error_logs" from "anon";

revoke select on table "public"."error_logs" from "anon";

revoke trigger on table "public"."error_logs" from "anon";

revoke truncate on table "public"."error_logs" from "anon";

revoke update on table "public"."error_logs" from "anon";

revoke delete on table "public"."error_logs" from "authenticated";

revoke insert on table "public"."error_logs" from "authenticated";

revoke references on table "public"."error_logs" from "authenticated";

revoke select on table "public"."error_logs" from "authenticated";

revoke trigger on table "public"."error_logs" from "authenticated";

revoke truncate on table "public"."error_logs" from "authenticated";

revoke update on table "public"."error_logs" from "authenticated";

revoke delete on table "public"."error_logs" from "service_role";

revoke insert on table "public"."error_logs" from "service_role";

revoke references on table "public"."error_logs" from "service_role";

revoke select on table "public"."error_logs" from "service_role";

revoke trigger on table "public"."error_logs" from "service_role";

revoke truncate on table "public"."error_logs" from "service_role";

revoke update on table "public"."error_logs" from "service_role";

alter table "public"."error_logs" drop constraint "error_logs_created_by_fkey";

drop function if exists "public"."fn_confirm_payment_received"(p_community_id uuid, p_user_id uuid, p_payment_id uuid);

drop function if exists "public"."fn_log_error"(p_error_message text, p_stack_trace text, p_platform text, p_app_version text, p_feature_area text, p_metadata jsonb);

alter table "public"."error_logs" drop constraint "error_logs_pkey";

drop index if exists "public"."error_logs_pkey";

drop table "public"."error_logs";


  create table "public"."logs" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid default auth.uid(),
    "level" text not null default 'ERROR'::text,
    "message" text not null,
    "stack_trace" text,
    "platform" text,
    "app_version" text,
    "feature_area" text,
    "metadata" jsonb default '{}'::jsonb
      );


CREATE INDEX idx_logs_created_at ON public.logs USING btree (created_at DESC);

CREATE INDEX idx_logs_feature_area ON public.logs USING btree (feature_area);

CREATE INDEX idx_logs_level ON public.logs USING btree (level);

CREATE UNIQUE INDEX logs_pkey ON public.logs USING btree (id);

alter table "public"."logs" add constraint "logs_pkey" PRIMARY KEY using index "logs_pkey";

alter table "public"."logs" add constraint "logs_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."logs" validate constraint "logs_created_by_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fn_check_is_admin(p_user_id uuid, p_community_id uuid)
 RETURNS boolean
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
BEGIN
  RETURN EXISTS (
    SELECT 1 FROM users AS u
    INNER JOIN memberships AS m ON m.user_id = u.id
    WHERE u.id = p_user_id 
    AND m.community_id = p_community_id
    AND is_admin = TRUE
  );
END;
$function$
;

grant delete on table "public"."logs" to "anon";

grant insert on table "public"."logs" to "anon";

grant references on table "public"."logs" to "anon";

grant select on table "public"."logs" to "anon";

grant trigger on table "public"."logs" to "anon";

grant truncate on table "public"."logs" to "anon";

grant update on table "public"."logs" to "anon";

grant delete on table "public"."logs" to "authenticated";

grant insert on table "public"."logs" to "authenticated";

grant references on table "public"."logs" to "authenticated";

grant select on table "public"."logs" to "authenticated";

grant trigger on table "public"."logs" to "authenticated";

grant truncate on table "public"."logs" to "authenticated";

grant update on table "public"."logs" to "authenticated";

grant delete on table "public"."logs" to "service_role";

grant insert on table "public"."logs" to "service_role";

grant references on table "public"."logs" to "service_role";

grant select on table "public"."logs" to "service_role";

grant trigger on table "public"."logs" to "service_role";

grant truncate on table "public"."logs" to "service_role";

grant update on table "public"."logs" to "service_role";


