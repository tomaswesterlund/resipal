alter table "public"."user_community" drop constraint "user_community_status_check";

alter table "public"."user_community" add constraint "user_community_status_check" CHECK (((status)::text = ANY ((ARRAY['pending_approval'::character varying, 'approved'::character varying, 'rejected'::character varying])::text[]))) not valid;

alter table "public"."user_community" validate constraint "user_community_status_check";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fn_create_visitor(p_user_id uuid, p_name text, p_identification_path text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO visitors(user_id, name, identification_path)
    VALUES (p_user_id, p_name, p_identification_path);
END;
$function$
;


