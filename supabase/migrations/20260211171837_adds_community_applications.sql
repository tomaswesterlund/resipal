
  create table "public"."community_applications" (
    "id" uuid not null,
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "community_id" uuid not null,
    "user_id" uuid not null,
    "message" text
      );


CREATE UNIQUE INDEX community_applications_pkey ON public.community_applications USING btree (id);

alter table "public"."community_applications" add constraint "community_applications_pkey" PRIMARY KEY using index "community_applications_pkey";

alter table "public"."community_applications" add constraint "community_applications_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."community_applications" validate constraint "community_applications_community_id_fkey";

alter table "public"."community_applications" add constraint "community_applications_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."community_applications" validate constraint "community_applications_created_by_fkey";

alter table "public"."community_applications" add constraint "community_applications_id_fkey" FOREIGN KEY (id) REFERENCES auth.users(id) ON DELETE CASCADE not valid;

alter table "public"."community_applications" validate constraint "community_applications_id_fkey";

alter table "public"."community_applications" add constraint "community_applications_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) not valid;

alter table "public"."community_applications" validate constraint "community_applications_user_id_fkey";

grant delete on table "public"."community_applications" to "anon";

grant insert on table "public"."community_applications" to "anon";

grant references on table "public"."community_applications" to "anon";

grant select on table "public"."community_applications" to "anon";

grant trigger on table "public"."community_applications" to "anon";

grant truncate on table "public"."community_applications" to "anon";

grant update on table "public"."community_applications" to "anon";

grant delete on table "public"."community_applications" to "authenticated";

grant insert on table "public"."community_applications" to "authenticated";

grant references on table "public"."community_applications" to "authenticated";

grant select on table "public"."community_applications" to "authenticated";

grant trigger on table "public"."community_applications" to "authenticated";

grant truncate on table "public"."community_applications" to "authenticated";

grant update on table "public"."community_applications" to "authenticated";

grant delete on table "public"."community_applications" to "service_role";

grant insert on table "public"."community_applications" to "service_role";

grant references on table "public"."community_applications" to "service_role";

grant select on table "public"."community_applications" to "service_role";

grant trigger on table "public"."community_applications" to "service_role";

grant truncate on table "public"."community_applications" to "service_role";

grant update on table "public"."community_applications" to "service_role";


