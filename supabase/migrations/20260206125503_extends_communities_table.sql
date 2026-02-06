alter table "public"."communities" add column "description" text;

alter table "public"."communities" add column "key" text not null;

alter table "public"."communities" add column "location" text not null;

CREATE UNIQUE INDEX communities_key_key ON public.communities USING btree (key);

alter table "public"."communities" add constraint "communities_key_key" UNIQUE using index "communities_key_key";


