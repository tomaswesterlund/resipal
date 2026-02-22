-- -- NOTE: Supabase CLI ignores this SQL when creating the migration file so it must be created manually:
-- -- Create a new migration file and copy-and-paste the data.

-- 1. Ensure publication exists
DO $$ BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_publication WHERE pubname = 'supabase_realtime') THEN
        CREATE PUBLICATION supabase_realtime;
    END IF;
END $$;

-- 2. Drop current tables from publication and re-add schema (to avoid "already exists" errors)
-- This is safer for repeating migrations
DROP PUBLICATION IF EXISTS supabase_realtime;
CREATE PUBLICATION supabase_realtime FOR TABLES IN SCHEMA public;