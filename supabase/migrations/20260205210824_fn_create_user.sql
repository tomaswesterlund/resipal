alter table "public"."error_logs" drop constraint "error_logs_uid_fkey";

alter table "public"."users" drop constraint "users_community_id_fkey";

alter table "public"."error_logs" drop column "uid";

alter table "public"."users" drop column "community_id";

alter table "public"."users" alter column "id" drop default;

alter table "public"."users" add constraint "users_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."users" validate constraint "users_id_fkey";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fn_create_user(p_user_id uuid, p_email text, p_phone_number text, p_emergency_phone_number text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO users (id, email, phone_number, emergency_phone_number)
    VALUES (p_user_id, p_email, p_phone_number, p_emergency_phone_number);
END;
$function$
;


