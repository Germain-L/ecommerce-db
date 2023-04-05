-- Produits les mieux notés
CREATE VIEW best_rated_products AS
SELECT p.id, p.name, p.description, p.price, AVG(r.rating) AS average_rating
FROM product p
JOIN review r ON p.id = r.product_id
GROUP BY p.id, p.name, p.description, p.price
ORDER BY average_rating DESC;


-- Commandes par utilisateur
CREATE VIEW orders_by_user AS
SELECT u.id, u.username, COUNT(o.id) AS total_orders, SUM(o.price) AS total_spent
FROM users u
JOIN orders o ON u.id = o.users_id
GROUP BY u.id, u.username;


-- Ventes par catégorie
CREATE VIEW sales_by_category AS
SELECT c.id, c.name, COUNT(o.id) AS total_sales, SUM(o.price) AS total_revenue
FROM category c
JOIN product_category pc ON c.id = pc.category_id
JOIN product p ON pc.product_id = p.id
JOIN fullfils f ON p.id = f.product_id
JOIN orders o ON f.orders_id = o.id
GROUP BY c.id, c.name;


-- Produits les plus vendus
CREATE VIEW top_selling_products AS
SELECT p.id, p.name, p.description, p.price, COUNT(o.id) AS total_sales, SUM(o.price) AS total_revenue
FROM product p
JOIN fullfils f ON p.id = f.product_id
JOIN orders o ON f.orders_id = o.id
GROUP BY p.id, p.name, p.description, p.price
ORDER BY total_sales DESC, total_revenue DESC;


-- Avis récents
CREATE VIEW recent_reviews AS
SELECT r.id, r.rating, r.comment, r.date_created, p.name AS product_name, u.username AS reviewer
FROM review r
JOIN product p ON r.product_id = p.id
JOIN users u ON r.user_id = u.id
ORDER BY r.date_created DESC;
