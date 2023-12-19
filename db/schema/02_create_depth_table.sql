CREATE TABLE order_details (
    order_update_id INT,
    type TEXT, -- 'a' or 'b'
    p FLOAT,
    v FLOAT,
    FOREIGN KEY (order_update_id) REFERENCES order_updates(id)
);