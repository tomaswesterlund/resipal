
  create table "public"."access_logs" (
    "id" uuid not null default gen_random_uuid(),
    "invitation_id" uuid not null,
    "created_at" timestamp with time zone not null default now(),
    "direction" text not null,
    "timestamp" timestamp with time zone not null
      );


CREATE UNIQUE INDEX access_logs_pkey ON public.access_logs USING btree (id);

alter table "public"."access_logs" add constraint "access_logs_pkey" PRIMARY KEY using index "access_logs_pkey";

alter table "public"."access_logs" add constraint "access_logs_invitation_id_fkey" FOREIGN KEY (invitation_id) REFERENCES public.invitations(id) not valid;

alter table "public"."access_logs" validate constraint "access_logs_invitation_id_fkey";

grant delete on table "public"."access_logs" to "anon";

grant insert on table "public"."access_logs" to "anon";

grant references on table "public"."access_logs" to "anon";

grant select on table "public"."access_logs" to "anon";

grant trigger on table "public"."access_logs" to "anon";

grant truncate on table "public"."access_logs" to "anon";

grant update on table "public"."access_logs" to "anon";

grant delete on table "public"."access_logs" to "authenticated";

grant insert on table "public"."access_logs" to "authenticated";

grant references on table "public"."access_logs" to "authenticated";

grant select on table "public"."access_logs" to "authenticated";

grant trigger on table "public"."access_logs" to "authenticated";

grant truncate on table "public"."access_logs" to "authenticated";

grant update on table "public"."access_logs" to "authenticated";

grant delete on table "public"."access_logs" to "service_role";

grant insert on table "public"."access_logs" to "service_role";

grant references on table "public"."access_logs" to "service_role";

grant select on table "public"."access_logs" to "service_role";

grant trigger on table "public"."access_logs" to "service_role";

grant truncate on table "public"."access_logs" to "service_role";

grant update on table "public"."access_logs" to "service_role";


