
  create table "public"."invitations" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "property_id" uuid not null,
    "visitor_id" uuid not null,
    "created_at" timestamp with time zone not null default now(),
    "qr_code_token" uuid not null,
    "from_date" timestamp with time zone not null,
    "to_date" timestamp with time zone not null,
    "max_entries" integer not null
      );



  create table "public"."visitors" (
    "id" uuid not null default gen_random_uuid(),
    "user_id" uuid not null,
    "created_at" timestamp with time zone not null default now(),
    "name" text not null
      );


CREATE UNIQUE INDEX invitations_pkey ON public.invitations USING btree (id);

CREATE UNIQUE INDEX visitors_pkey ON public.visitors USING btree (id);

alter table "public"."invitations" add constraint "invitations_pkey" PRIMARY KEY using index "invitations_pkey";

alter table "public"."visitors" add constraint "visitors_pkey" PRIMARY KEY using index "visitors_pkey";

alter table "public"."invitations" add constraint "invitations_property_id_fkey" FOREIGN KEY (property_id) REFERENCES public.properties(id) not valid;

alter table "public"."invitations" validate constraint "invitations_property_id_fkey";

alter table "public"."invitations" add constraint "invitations_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) not valid;

alter table "public"."invitations" validate constraint "invitations_user_id_fkey";

alter table "public"."invitations" add constraint "invitations_visitor_id_fkey" FOREIGN KEY (visitor_id) REFERENCES public.visitors(id) not valid;

alter table "public"."invitations" validate constraint "invitations_visitor_id_fkey";

alter table "public"."visitors" add constraint "visitors_user_id_fkey" FOREIGN KEY (user_id) REFERENCES public.users(id) not valid;

alter table "public"."visitors" validate constraint "visitors_user_id_fkey";

grant delete on table "public"."invitations" to "anon";

grant insert on table "public"."invitations" to "anon";

grant references on table "public"."invitations" to "anon";

grant select on table "public"."invitations" to "anon";

grant trigger on table "public"."invitations" to "anon";

grant truncate on table "public"."invitations" to "anon";

grant update on table "public"."invitations" to "anon";

grant delete on table "public"."invitations" to "authenticated";

grant insert on table "public"."invitations" to "authenticated";

grant references on table "public"."invitations" to "authenticated";

grant select on table "public"."invitations" to "authenticated";

grant trigger on table "public"."invitations" to "authenticated";

grant truncate on table "public"."invitations" to "authenticated";

grant update on table "public"."invitations" to "authenticated";

grant delete on table "public"."invitations" to "service_role";

grant insert on table "public"."invitations" to "service_role";

grant references on table "public"."invitations" to "service_role";

grant select on table "public"."invitations" to "service_role";

grant trigger on table "public"."invitations" to "service_role";

grant truncate on table "public"."invitations" to "service_role";

grant update on table "public"."invitations" to "service_role";

grant delete on table "public"."visitors" to "anon";

grant insert on table "public"."visitors" to "anon";

grant references on table "public"."visitors" to "anon";

grant select on table "public"."visitors" to "anon";

grant trigger on table "public"."visitors" to "anon";

grant truncate on table "public"."visitors" to "anon";

grant update on table "public"."visitors" to "anon";

grant delete on table "public"."visitors" to "authenticated";

grant insert on table "public"."visitors" to "authenticated";

grant references on table "public"."visitors" to "authenticated";

grant select on table "public"."visitors" to "authenticated";

grant trigger on table "public"."visitors" to "authenticated";

grant truncate on table "public"."visitors" to "authenticated";

grant update on table "public"."visitors" to "authenticated";

grant delete on table "public"."visitors" to "service_role";

grant insert on table "public"."visitors" to "service_role";

grant references on table "public"."visitors" to "service_role";

grant select on table "public"."visitors" to "service_role";

grant trigger on table "public"."visitors" to "service_role";

grant truncate on table "public"."visitors" to "service_role";

grant update on table "public"."visitors" to "service_role";


