alter table "public"."access_logs" add constraint "access_logs_direction_check" CHECK ((direction = ANY (ARRAY['entry'::text, 'exit'::text]))) not valid;

alter table "public"."access_logs" validate constraint "access_logs_direction_check";


