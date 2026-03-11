
  create table "public"."email_invitations" (
    "id" uuid not null default gen_random_uuid(),
    "community_id" uuid not null,
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid(),
    "email" text not null,
    "name" text not null,
    "message" text not null
      );



  create table "public"."email_log" (
    "id" uuid not null default gen_random_uuid(),
    "invitation_id" uuid not null,
    "resend_id" uuid not null,
    "created_at" timestamp with time zone not null default now(),
    "created_by" uuid not null default auth.uid()
      );


CREATE UNIQUE INDEX email_invitations_pkey ON public.email_invitations USING btree (id);

CREATE UNIQUE INDEX email_log_pkey ON public.email_log USING btree (id);

alter table "public"."email_invitations" add constraint "email_invitations_pkey" PRIMARY KEY using index "email_invitations_pkey";

alter table "public"."email_log" add constraint "email_log_pkey" PRIMARY KEY using index "email_log_pkey";

alter table "public"."email_invitations" add constraint "email_invitations_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."email_invitations" validate constraint "email_invitations_community_id_fkey";

alter table "public"."email_invitations" add constraint "email_invitations_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."email_invitations" validate constraint "email_invitations_created_by_fkey";

alter table "public"."email_log" add constraint "email_log_created_by_fkey" FOREIGN KEY (created_by) REFERENCES auth.users(id) not valid;

alter table "public"."email_log" validate constraint "email_log_created_by_fkey";

alter table "public"."email_log" add constraint "email_log_invitation_id_fkey" FOREIGN KEY (invitation_id) REFERENCES public.email_invitations(id) not valid;

alter table "public"."email_log" validate constraint "email_log_invitation_id_fkey";

grant delete on table "public"."email_invitations" to "anon";

grant insert on table "public"."email_invitations" to "anon";

grant references on table "public"."email_invitations" to "anon";

grant select on table "public"."email_invitations" to "anon";

grant trigger on table "public"."email_invitations" to "anon";

grant truncate on table "public"."email_invitations" to "anon";

grant update on table "public"."email_invitations" to "anon";

grant delete on table "public"."email_invitations" to "authenticated";

grant insert on table "public"."email_invitations" to "authenticated";

grant references on table "public"."email_invitations" to "authenticated";

grant select on table "public"."email_invitations" to "authenticated";

grant trigger on table "public"."email_invitations" to "authenticated";

grant truncate on table "public"."email_invitations" to "authenticated";

grant update on table "public"."email_invitations" to "authenticated";

grant delete on table "public"."email_invitations" to "service_role";

grant insert on table "public"."email_invitations" to "service_role";

grant references on table "public"."email_invitations" to "service_role";

grant select on table "public"."email_invitations" to "service_role";

grant trigger on table "public"."email_invitations" to "service_role";

grant truncate on table "public"."email_invitations" to "service_role";

grant update on table "public"."email_invitations" to "service_role";

grant delete on table "public"."email_log" to "anon";

grant insert on table "public"."email_log" to "anon";

grant references on table "public"."email_log" to "anon";

grant select on table "public"."email_log" to "anon";

grant trigger on table "public"."email_log" to "anon";

grant truncate on table "public"."email_log" to "anon";

grant update on table "public"."email_log" to "anon";

grant delete on table "public"."email_log" to "authenticated";

grant insert on table "public"."email_log" to "authenticated";

grant references on table "public"."email_log" to "authenticated";

grant select on table "public"."email_log" to "authenticated";

grant trigger on table "public"."email_log" to "authenticated";

grant truncate on table "public"."email_log" to "authenticated";

grant update on table "public"."email_log" to "authenticated";

grant delete on table "public"."email_log" to "service_role";

grant insert on table "public"."email_log" to "service_role";

grant references on table "public"."email_log" to "service_role";

grant select on table "public"."email_log" to "service_role";

grant trigger on table "public"."email_log" to "service_role";

grant truncate on table "public"."email_log" to "service_role";

grant update on table "public"."email_log" to "service_role";


