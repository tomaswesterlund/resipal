alter table "public"."maintenance_fees" drop column "is_paid";

alter table "public"."maintenance_fees" drop column "last_pay_date";

alter table "public"."maintenance_fees" add column "due_date" timestamp with time zone not null;

alter table "public"."maintenance_fees" add column "payment_date" timestamp with time zone;


