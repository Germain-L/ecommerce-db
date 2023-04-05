-- Recherche de produits
CREATE INDEX idx_product_name ON product(name);

-- Trier les avis par date
CREATE INDEX idx_review_date_created ON review(date_created);

-- Recherche de commandes par utilisateur
CREATE INDEX idx_orders_users_id ON orders(users_id);