alter table "public"."community_applications" drop constraint "community_applications_id_fkey";

alter table "public"."community_applications" alter column "id" set default gen_random_uuid();


