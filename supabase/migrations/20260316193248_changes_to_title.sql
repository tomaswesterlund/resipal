alter table "public"."notifications" drop column "header";

alter table "public"."notifications" add column "title" text not null;


