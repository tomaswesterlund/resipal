
  create table "public"."notifications" (
    "id" uuid not null default gen_random_uuid(),
    "community_id" uuid not null,
    "resident_id" uuid,
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "app" text not null,
    "header" text not null,
    "message" text not null,
    "read_date" timestamp with time zone
      );


CREATE UNIQUE INDEX notifications_pkey ON public.notifications USING btree (id);

alter table "public"."notifications" add constraint "notifications_pkey" PRIMARY KEY using index "notifications_pkey";

alter table "public"."notifications" add constraint "notifications_app_check" CHECK ((app = ANY (ARRAY['admin'::text, 'resident'::text, 'security'::text]))) not valid;

alter table "public"."notifications" validate constraint "notifications_app_check";

alter table "public"."notifications" add constraint "notifications_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."notifications" validate constraint "notifications_community_id_fkey";

alter table "public"."notifications" add constraint "notifications_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."notifications" validate constraint "notifications_created_by_fkey";

alter table "public"."notifications" add constraint "notifications_resident_id_fkey" FOREIGN KEY (resident_id) REFERENCES public.users(id) not valid;

alter table "public"."notifications" validate constraint "notifications_resident_id_fkey";

grant delete on table "public"."notifications" to "anon";

grant insert on table "public"."notifications" to "anon";

grant references on table "public"."notifications" to "anon";

grant select on table "public"."notifications" to "anon";

grant trigger on table "public"."notifications" to "anon";

grant truncate on table "public"."notifications" to "anon";

grant update on table "public"."notifications" to "anon";

grant delete on table "public"."notifications" to "authenticated";

grant insert on table "public"."notifications" to "authenticated";

grant references on table "public"."notifications" to "authenticated";

grant select on table "public"."notifications" to "authenticated";

grant trigger on table "public"."notifications" to "authenticated";

grant truncate on table "public"."notifications" to "authenticated";

grant update on table "public"."notifications" to "authenticated";

grant delete on table "public"."notifications" to "service_role";

grant insert on table "public"."notifications" to "service_role";

grant references on table "public"."notifications" to "service_role";

grant select on table "public"."notifications" to "service_role";

grant trigger on table "public"."notifications" to "service_role";

grant truncate on table "public"."notifications" to "service_role";

grant update on table "public"."notifications" to "service_role";


