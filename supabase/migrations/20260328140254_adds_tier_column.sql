alter table "public"."communities" add column "tier" text not null default 'free'::text;

alter table "public"."communities" add constraint "communities_tier_check" CHECK ((tier = ANY (ARRAY['free'::text, 'plan_100'::text, 'plan_200'::text, 'plan_300'::text]))) not valid;

alter table "public"."communities" validate constraint "communities_tier_check";


