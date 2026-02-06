alter table "public"."user_community" drop constraint "user_community_status_check";

alter table "public"."user_community" add constraint "user_community_status_check" CHECK (((status)::text = ANY ((ARRAY['pending_approval'::character varying, 'approved'::character varying, 'rejected'::character varying])::text[]))) not valid;

alter table "public"."user_community" validate constraint "user_community_status_check";


