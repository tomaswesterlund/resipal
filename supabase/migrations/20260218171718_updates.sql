
  create table "public"."community_members" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "user_id" uuid not null,
    "community_id" uuid not null,
    "is_admin" boolean not null,
    "is_resident" boolean not null,
    "is_security" boolean not null
      );


CREATE UNIQUE INDEX community_members_pkey ON public.community_members USING btree (id);

CREATE UNIQUE INDEX community_members_user_id_community_id_key ON public.community_members USING btree (user_id, community_id);

alter table "public"."community_members" add constraint "community_members_pkey" PRIMARY KEY using index "community_members_pkey";

alter table "public"."community_members" add constraint "community_members_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) ON DELETE CASCADE not valid;

alter table "public"."community_members" validate constraint "community_members_community_id_fkey";

alter table "public"."community_members" add constraint "community_members_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."community_members" validate constraint "community_members_created_by_fkey";

alter table "public"."community_members" add constraint "community_members_user_id_community_id_key" UNIQUE using index "community_members_user_id_community_id_key";

alter table "public"."community_members" add constraint "community_members_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE not valid;

alter table "public"."community_members" validate constraint "community_members_user_id_fkey";

grant delete on table "public"."community_members" to "anon";

grant insert on table "public"."community_members" to "anon";

grant references on table "public"."community_members" to "anon";

grant select on table "public"."community_members" to "anon";

grant trigger on table "public"."community_members" to "anon";

grant truncate on table "public"."community_members" to "anon";

grant update on table "public"."community_members" to "anon";

grant delete on table "public"."community_members" to "authenticated";

grant insert on table "public"."community_members" to "authenticated";

grant references on table "public"."community_members" to "authenticated";

grant select on table "public"."community_members" to "authenticated";

grant trigger on table "public"."community_members" to "authenticated";

grant truncate on table "public"."community_members" to "authenticated";

grant update on table "public"."community_members" to "authenticated";

grant delete on table "public"."community_members" to "service_role";

grant insert on table "public"."community_members" to "service_role";

grant references on table "public"."community_members" to "service_role";

grant select on table "public"."community_members" to "service_role";

grant trigger on table "public"."community_members" to "service_role";

grant truncate on table "public"."community_members" to "service_role";

grant update on table "public"."community_members" to "service_role";


