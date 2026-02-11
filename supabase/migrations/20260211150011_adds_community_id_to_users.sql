revoke delete on table "public"."user_community" from "anon";

revoke insert on table "public"."user_community" from "anon";

revoke references on table "public"."user_community" from "anon";

revoke select on table "public"."user_community" from "anon";

revoke trigger on table "public"."user_community" from "anon";

revoke truncate on table "public"."user_community" from "anon";

revoke update on table "public"."user_community" from "anon";

revoke delete on table "public"."user_community" from "authenticated";

revoke insert on table "public"."user_community" from "authenticated";

revoke references on table "public"."user_community" from "authenticated";

revoke select on table "public"."user_community" from "authenticated";

revoke trigger on table "public"."user_community" from "authenticated";

revoke truncate on table "public"."user_community" from "authenticated";

revoke update on table "public"."user_community" from "authenticated";

revoke delete on table "public"."user_community" from "service_role";

revoke insert on table "public"."user_community" from "service_role";

revoke references on table "public"."user_community" from "service_role";

revoke select on table "public"."user_community" from "service_role";

revoke trigger on table "public"."user_community" from "service_role";

revoke truncate on table "public"."user_community" from "service_role";

revoke update on table "public"."user_community" from "service_role";

alter table "public"."user_community" drop constraint "user_community_community_id_fkey";

alter table "public"."user_community" drop constraint "user_community_created_by_fkey";

alter table "public"."user_community" drop constraint "user_community_status_check";

alter table "public"."user_community" drop constraint "user_community_user_id_community_id_key";

alter table "public"."user_community" drop constraint "user_community_user_id_fkey";

alter table "public"."user_community" drop constraint "user_community_pkey";

drop index if exists "public"."user_community_pkey";

drop index if exists "public"."user_community_user_id_community_id_key";

drop table "public"."user_community";

alter table "public"."users" add column "community_id" uuid not null;

alter table "public"."users" add constraint "users_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."users" validate constraint "users_community_id_fkey";


