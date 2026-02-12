drop function if exists "public"."fn_join_community"(p_user_id uuid, p_community_id uuid);

alter table "public"."community_applications" add column "status" text not null;

alter table "public"."community_applications" add constraint "community_applications_status_check" CHECK ((status = ANY (ARRAY['approved'::text, 'pending_review'::text, 'revoked'::text]))) not valid;

alter table "public"."community_applications" validate constraint "community_applications_status_check";

set check_function_bodies = off;

CREATE OR REPLACE FUNCTION public.fn_create_community_application(p_community_id uuid, p_user_id uuid)
 RETURNS void
 LANGUAGE plpgsql
 SECURITY DEFINER
AS $function$
DECLARE
    v_email TEXT;
BEGIN
    v_email := auth.jwt() ->> 'email';

    INSERT INTO community_applications (community_id, user_id, status, message)
    VALUES (
        p_community_id, 
        p_user_id, 
        'pending_review', 
        'Creada para ' || v_email
    );
END;
$function$
;


