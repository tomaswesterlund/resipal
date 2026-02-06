alter table "public"."user_community" drop constraint "user_community_status_check";

alter table "public"."user_community" alter column "status" drop default;

alter table "public"."user_community" add constraint "user_community_status_check" CHECK (((status)::text = ANY ((ARRAY['pending_approval'::character varying, 'approved'::character varying, 'rejected'::character varying])::text[]))) not valid;

alter table "public"."user_community" validate constraint "user_community_status_check";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fn_join_community(p_user_id uuid, p_community_id text)
 RETURNS void
 LANGUAGE plpgsql
AS $function$
BEGIN
    INSERT INTO user_community (user_id, community_id, status)
    VALUES (p_user_id, p_community_id, 'pending_approval');
END;
$function$
;


