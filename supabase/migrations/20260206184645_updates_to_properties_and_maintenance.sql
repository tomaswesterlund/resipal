alter table "public"."maintenance_contracts" drop constraint "maintenance_contracts_property_id_fkey";

alter table "public"."properties" drop constraint "properties_user_id_fkey";

alter table "public"."user_community" drop constraint "user_community_status_check";

alter table "public"."maintenance_contracts" drop column "property_id";

alter table "public"."properties" drop column "user_id";

alter table "public"."properties" add column "community_id" uuid not null;

alter table "public"."properties" add column "contract_id" uuid;

alter table "public"."properties" add column "owner_id" uuid;

alter table "public"."properties" add constraint "properties_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."properties" validate constraint "properties_community_id_fkey";

alter table "public"."properties" add constraint "properties_contract_id_fkey" FOREIGN KEY (contract_id) REFERENCES public.maintenance_contracts(id) not valid;

alter table "public"."properties" validate constraint "properties_contract_id_fkey";

alter table "public"."properties" add constraint "properties_owner_id_fkey" FOREIGN KEY (owner_id) REFERENCES public.users(id) not valid;

alter table "public"."properties" validate constraint "properties_owner_id_fkey";

alter table "public"."user_community" add constraint "user_community_status_check" CHECK (((status)::text = ANY ((ARRAY['pending_approval'::character varying, 'approved'::character varying, 'rejected'::character varying])::text[]))) not valid;

alter table "public"."user_community" validate constraint "user_community_status_check";


