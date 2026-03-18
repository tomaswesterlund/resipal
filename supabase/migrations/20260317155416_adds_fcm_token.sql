alter table "public"."notifications" alter column "user_id" set not null;

alter table "public"."users" add column "fcm_token" text;


