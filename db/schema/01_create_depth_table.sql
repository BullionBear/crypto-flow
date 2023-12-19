DO $$
BEGIN
    -- Check if the table 'order_updates' does not exist
    IF NOT EXISTS (SELECT FROM pg_catalog.pg_tables 
                   WHERE schemaname = 'public' AND tablename  = 'depth') THEN
        
        -- Create the table
        CREATE TABLE depth (
            id INT,
            ex TEXT,
            base TEXT,
            quote TEXT,
            inst TEXT,
            ts TIMESTAMP,
            u BIGINT,
            pu BIGINT,
            a JSONB,
            b JSONB
        );

        -- Convert the table into a hypertable
        SELECT create_hypertable('depth', 'ts');

        -- Optionally, add a unique index
        CREATE UNIQUE INDEX ON depth (id, ts);

    END IF;
END $$;