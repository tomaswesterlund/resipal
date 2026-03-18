drop function if exists "public"."fn_check_is_admin"(p_user_id uuid, p_community_id uuid);

drop function if exists "public"."fn_create_application"(p_community_id uuid, p_user_id uuid);

drop function if exists "public"."fn_create_community"(p_name text, p_description text, p_location text);

drop function if exists "public"."fn_create_contract"(p_community_id uuid, p_name text, p_amount_in_cents integer, p_period text, p_description text);

drop function if exists "public"."fn_create_membership"(p_community_id uuid, p_user_id uuid, p_is_admin boolean, p_is_resident boolean, p_is_security boolean);


