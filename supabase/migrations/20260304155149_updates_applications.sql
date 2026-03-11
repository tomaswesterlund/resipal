CREATE UNIQUE INDEX applications_community_id_email_key ON public.applications USING btree (community_id, email);

alter table "public"."applications" add constraint "applications_community_id_email_key" UNIQUE using index "applications_community_id_email_key";


