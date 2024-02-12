CREATE TABLE order_updates (
    id SERIAL PRIMARY KEY,
    ex TEXT NOT NULL,
    base TEXT NOT NULL,
    quote TEXT NOT NULL,
    inst TEXT NOT NULL,
    ts TIMESTAMPTZ NOT NULL, -- using TIMESTAMPTZ for unixtime in milliseconds
    u BIGINT NOT NULL,
    pu BIGINT NOT NULL,
    a_price DOUBLE PRECISION[], -- array of prices in 'a'
    a_size DOUBLE PRECISION[], -- array of sizes in 'a'
    b_price DOUBLE PRECISION[], -- array of prices in 'b'
    b_size DOUBLE PRECISION[] -- array of sizes in 'b'
);
SELECT create_hypertable('order_updates', 'ts');