drop function if exists "public"."fn_create_invitation"(p_community_id uuid, p_user_id uuid, p_property_id uuid, p_visitor_id uuid, p_from_date timestamp with time zone, p_to_date timestamp with time zone);

drop function if exists "public"."fn_create_visitor"(p_community_id uuid, p_user_id uuid, p_name text, p_identification_path text);

alter table "public"."invitations" alter column "max_entries" drop not null;


