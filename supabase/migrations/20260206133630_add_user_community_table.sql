
  create table "public"."user_community" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "community_id" uuid not null,
    "status" character varying(20) not null default 'pending_approval'::character varying,
    "joined_at" timestamp with time zone default now()
      );


CREATE UNIQUE INDEX user_community_pkey ON public.user_community USING btree (id);

CREATE UNIQUE INDEX user_community_user_id_community_id_key ON public.user_community USING btree (user_id, community_id);

alter table "public"."user_community" add constraint "user_community_pkey" PRIMARY KEY using index "user_community_pkey";

alter table "public"."user_community" add constraint "user_community_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) ON DELETE CASCADE not valid;

alter table "public"."user_community" validate constraint "user_community_community_id_fkey";

alter table "public"."user_community" add constraint "user_community_status_check" CHECK (((status)::text = ANY ((ARRAY['pending_approval'::character varying, 'approved'::character varying, 'rejected'::character varying])::text[]))) not valid;

alter table "public"."user_community" validate constraint "user_community_status_check";

alter table "public"."user_community" add constraint "user_community_user_id_community_id_key" UNIQUE using index "user_community_user_id_community_id_key";

alter table "public"."user_community" add constraint "user_community_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE not valid;

alter table "public"."user_community" validate constraint "user_community_user_id_fkey";

grant delete on table "public"."user_community" to "anon";

grant insert on table "public"."user_community" to "anon";

grant references on table "public"."user_community" to "anon";

grant select on table "public"."user_community" to "anon";

grant trigger on table "public"."user_community" to "anon";

grant truncate on table "public"."user_community" to "anon";

grant update on table "public"."user_community" to "anon";

grant delete on table "public"."user_community" to "authenticated";

grant insert on table "public"."user_community" to "authenticated";

grant references on table "public"."user_community" to "authenticated";

grant select on table "public"."user_community" to "authenticated";

grant trigger on table "public"."user_community" to "authenticated";

grant truncate on table "public"."user_community" to "authenticated";

grant update on table "public"."user_community" to "authenticated";

grant delete on table "public"."user_community" to "service_role";

grant insert on table "public"."user_community" to "service_role";

grant references on table "public"."user_community" to "service_role";

grant select on table "public"."user_community" to "service_role";

grant trigger on table "public"."user_community" to "service_role";

grant truncate on table "public"."user_community" to "service_role";

grant update on table "public"."user_community" to "service_role";


