drop function if exists "public"."fn_create_visitor"(p_user_id uuid, p_name text, p_identification_path text);

alter table "public"."users" alter column "community_id" set not null;

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fn_create_visitor(p_community_id uuid, p_user_id uuid, p_name text, p_identification_path text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO visitors(community_id, user_id, name, identification_path)
    VALUES (p_community_id, p_user_id, p_name, p_identification_path);
END;
$function$
;


