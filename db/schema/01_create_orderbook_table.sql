CREATE TABLE order_updates (
    id SERIAL PRIMARY KEY,
    ex TEXT,
    base TEXT,
    quote TEXT,
    inst TEXT,
    ts BIGINT,
    u BIGINT,
    pu BIGINT,
    a JSONB,
    b JSONB,
    time TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

SELECT create_hypertable('order_updates', 'time');