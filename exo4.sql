--- Une vue basé sur un select pertinent (Potentiellement un select dans votre select) 
CREATE VIEW product_category_count AS
SELECT
   c.name AS category,
   (
      SELECT
         COUNT(*)
      FROM
         product p
      WHERE
         p.id IN (
            SELECT
               product_id
            FROM
               product_category
            WHERE
               category_id = c.id
         )
   ) AS count
FROM
   category c;

--- Une vue basé sur un select avec des jointures 
CREATE VIEW ecommerce_view AS
SELECT
   p.id AS product_id,
   p.name AS product_name,
   p.description,
   p.price,
   c.id AS category_id,
   c.name AS category_name,
   i.id AS image_id,
   i.link AS image_link,
   r.id AS review_id,
   r.rating,
   r.comment,
   r.date_created AS review_date,
   o.id AS order_id,
   o.order_date,
   o.price AS order_price,
   o.payment_status,
   pm.id AS payment_method_id,
   pm.name AS payment_method_name,
   u.id AS user_id,
   u.username,
   u.email,
   a.id AS address_id,
   a.zip,
   a.number,
   a.street,
   a.city,
   a.country
FROM
   product p
   LEFT JOIN product_category pc ON p.id = pc.product_id
   LEFT JOIN category c ON pc.category_id = c.id
   LEFT JOIN illustrates il ON p.id = il.product_id
   LEFT JOIN image i ON il.image_id = i.id
   LEFT JOIN review r ON p.id = r.product_id
   LEFT JOIN orders o ON p.id = o.id
   LEFT JOIN payment_method pm ON o.payment_method_id = pm.id
   LEFT JOIN users u ON o.users_id = u.id
   LEFT JOIN adress a ON o.adress_id = a.id;


--- 0.185s requête basé sur un champ autre la clef première AVANT la mise en place d’un index sur ce champs
SELECT p.id, p.name, COUNT(*) as orders_count
FROM product p
JOIN fullfils f ON p.id = f.product_id
JOIN orders o ON f.orders_id = o.id
WHERE o.payment_status = 'PAID'
GROUP BY p.id, p.name;

--- Creation d'un index
CREATE INDEX idx_order_date ON orders (order_date);

--- 0.183s Select sur le champ indexé
SELECT p.id, p.name, COUNT(*) as orders_count
FROM product p
JOIN fullfils f ON p.id = f.product_id
JOIN orders o ON f.orders_id = o.id
WHERE o.payment_status = 'PAID'
GROUP BY p.id, p.name;