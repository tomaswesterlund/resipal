-- ENABLE REAL TIME FOR ALL TABLES
DO $$
BEGIN
    IF NOT EXISTS(
        SELECT
            1
        FROM
            pg_publication
        WHERE
            pubname = 'supabase_realtime') THEN
    CREATE PUBLICATION supabase_realtime;
END IF;
END
$$;

-- 2. Alter the publication to include all tables in the public schema
-- This will automatically include tables you create in the future!
ALTER PUBLICATION supabase_realtime
    ADD TABLES IN SCHEMA public;

