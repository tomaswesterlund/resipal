alter table "public"."maintenance_fees" drop constraint "maintenance_fees_status_check";

alter table "public"."maintenance_fees" drop column "status";

alter table "public"."maintenance_fees" add column "is_paid" boolean not null;


