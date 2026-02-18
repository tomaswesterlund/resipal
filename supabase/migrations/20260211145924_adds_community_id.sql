drop trigger if exists "trg_maintenance_fee_movements_sync" on "public"."maintenance_fees";

revoke delete on table "public"."movements" from "anon";

revoke insert on table "public"."movements" from "anon";

revoke references on table "public"."movements" from "anon";

revoke select on table "public"."movements" from "anon";

revoke trigger on table "public"."movements" from "anon";

revoke truncate on table "public"."movements" from "anon";

revoke update on table "public"."movements" from "anon";

revoke delete on table "public"."movements" from "authenticated";

revoke insert on table "public"."movements" from "authenticated";

revoke references on table "public"."movements" from "authenticated";

revoke select on table "public"."movements" from "authenticated";

revoke trigger on table "public"."movements" from "authenticated";

revoke truncate on table "public"."movements" from "authenticated";

revoke update on table "public"."movements" from "authenticated";

revoke delete on table "public"."movements" from "service_role";

revoke insert on table "public"."movements" from "service_role";

revoke references on table "public"."movements" from "service_role";

revoke select on table "public"."movements" from "service_role";

revoke trigger on table "public"."movements" from "service_role";

revoke truncate on table "public"."movements" from "service_role";

revoke update on table "public"."movements" from "service_role";

alter table "public"."movements" drop constraint "movements_created_by_fkey";

alter table "public"."movements" drop constraint "movements_type_check";

alter table "public"."movements" drop constraint "movements_user_id_fkey";

alter table "public"."user_community" drop constraint "user_community_status_check";

drop function if exists "public"."fn_maintenance_fee_movements_sync"();

alter table "public"."movements" drop constraint "movements_pkey";

drop index if exists "public"."movements_pkey";

drop table "public"."movements";

alter table "public"."access_logs" add column "community_id" uuid not null;

alter table "public"."error_logs" add column "community_id" uuid not null;

alter table "public"."invitations" add column "community_id" uuid not null;

alter table "public"."maintenance_contracts" add column "community_id" uuid not null;

alter table "public"."maintenance_fees" add column "community_id" uuid not null;

alter table "public"."payments" add column "community_id" uuid not null;

alter table "public"."visitors" add column "community_id" uuid not null;

alter table "public"."access_logs" add constraint "access_logs_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."access_logs" validate constraint "access_logs_community_id_fkey";

alter table "public"."error_logs" add constraint "error_logs_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."error_logs" validate constraint "error_logs_community_id_fkey";

alter table "public"."invitations" add constraint "invitations_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."invitations" validate constraint "invitations_community_id_fkey";

alter table "public"."maintenance_contracts" add constraint "maintenance_contracts_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."maintenance_contracts" validate constraint "maintenance_contracts_community_id_fkey";

alter table "public"."maintenance_fees" add constraint "maintenance_fees_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."maintenance_fees" validate constraint "maintenance_fees_community_id_fkey";

alter table "public"."payments" add constraint "payments_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."payments" validate constraint "payments_community_id_fkey";

alter table "public"."visitors" add constraint "visitors_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."visitors" validate constraint "visitors_community_id_fkey";

alter table "public"."user_community" add constraint "user_community_status_check" CHECK (((status)::text = ANY ((ARRAY['pending_approval'::character varying, 'approved'::character varying, 'rejected'::character varying])::text[]))) not valid;

alter table "public"."user_community" validate constraint "user_community_status_check";


