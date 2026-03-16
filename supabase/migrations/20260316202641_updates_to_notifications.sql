alter table "public"."notifications" drop constraint "notifications_resident_id_fkey";

alter table "public"."notifications" drop column "resident_id";

alter table "public"."notifications" add column "user_id" uuid;

alter table "public"."notifications" add constraint "notifications_user_id_fkey" FOREIGN KEY (user_id) REFERENCES auth.users(id) not valid;

alter table "public"."notifications" validate constraint "notifications_user_id_fkey";


