
  create table "public"."edge_function_logs" (
    "id" uuid not null default gen_random_uuid(),
    "created_at" timestamp with time zone not null default now(),
    "function_name" text not null,
    "status" text not null,
    "execution_time_ms" integer,
    "payload" jsonb,
    "response" jsonb,
    "error_message" text,
    "community_id" uuid
      );


CREATE UNIQUE INDEX edge_function_logs_pkey ON public.edge_function_logs USING btree (id);

CREATE INDEX idx_logs_function_name ON public.edge_function_logs USING btree (function_name, created_at DESC);

alter table "public"."edge_function_logs" add constraint "edge_function_logs_pkey" PRIMARY KEY using index "edge_function_logs_pkey";

alter table "public"."edge_function_logs" add constraint "edge_function_logs_community_id_fkey" FOREIGN KEY (community_id) REFERENCES public.communities(id) not valid;

alter table "public"."edge_function_logs" validate constraint "edge_function_logs_community_id_fkey";

alter table "public"."edge_function_logs" add constraint "edge_function_logs_status_check" CHECK ((status = ANY (ARRAY['success'::text, 'error'::text, 'pending'::text]))) not valid;

alter table "public"."edge_function_logs" validate constraint "edge_function_logs_status_check";

grant delete on table "public"."edge_function_logs" to "anon";

grant insert on table "public"."edge_function_logs" to "anon";

grant references on table "public"."edge_function_logs" to "anon";

grant select on table "public"."edge_function_logs" to "anon";

grant trigger on table "public"."edge_function_logs" to "anon";

grant truncate on table "public"."edge_function_logs" to "anon";

grant update on table "public"."edge_function_logs" to "anon";

grant delete on table "public"."edge_function_logs" to "authenticated";

grant insert on table "public"."edge_function_logs" to "authenticated";

grant references on table "public"."edge_function_logs" to "authenticated";

grant select on table "public"."edge_function_logs" to "authenticated";

grant trigger on table "public"."edge_function_logs" to "authenticated";

grant truncate on table "public"."edge_function_logs" to "authenticated";

grant update on table "public"."edge_function_logs" to "authenticated";

grant delete on table "public"."edge_function_logs" to "service_role";

grant insert on table "public"."edge_function_logs" to "service_role";

grant references on table "public"."edge_function_logs" to "service_role";

grant select on table "public"."edge_function_logs" to "service_role";

grant trigger on table "public"."edge_function_logs" to "service_role";

grant truncate on table "public"."edge_function_logs" to "service_role";

grant update on table "public"."edge_function_logs" to "service_role";


