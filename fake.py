import time
from faker import Faker
import random
import mysql.connector

fake = Faker()

# connect to the MySQL database
mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    password="example",
    database="ecom"
)

# create a cursor object to execute SQL commands
mycursor = mydb.cursor()

start = time.time()

# generate and insert fake data into the address table
for i in range(100000):
    zip_code = fake.zipcode()
    number = random.randint(1, 1000)
    street = fake.street_name()
    city = fake.city()
    country = fake.country()
    sql = "INSERT INTO adress (zip, number, street, city, country) VALUES (%s, %s, %s, %s, %s)"
    val = (zip_code, number, street, city, country)
    mycursor.execute(sql, val)

    print(mycursor.statement)

    mydb.commit()

# generate and insert fake data into the image table
for i in range(100000):
    link = fake.image_url()
    sql = "INSERT INTO image (link) VALUES (%s)"
    val = (link,)
    mycursor.execute(sql, val)

    print(mycursor.statement)

    mydb.commit()

# generate and insert fake data into the users table
for i in range(100000):
    username = fake.user_name()
    email = fake.email()
    password_hash = fake.password()
    sql = "INSERT INTO users (username, email, password_hash) VALUES (%s, %s, %s)"
    val = (username, email, password_hash)
    mycursor.execute(sql, val)

    print(mycursor.statement)

    mydb.commit()

# generate and insert fake data into the product table
for i in range(100000):
    name = fake.word()
    description = fake.sentence()
    price = round(random.uniform(10, 1000), 2)
    sql = "INSERT INTO product (name, description, price) VALUES (%s, %s, %s)"
    val = (name, description, price)
    mycursor.execute(sql, val)

    print(mycursor.statement)

    mydb.commit()

# generate and insert fake data into the review table
for i in range(60000):
    rating = random.randint(1, 10)
    comment = fake.paragraph()
    date_created = fake.date_time_this_month(
        before_now=True, after_now=False, tzinfo=None)
    product_id = random.randint(1, 99999)
    user_id = random.randint(1, 99999)
    sql = "INSERT INTO review (rating, comment, date_created, product_id, user_id) VALUES (%s, %s, %s, %s, %s)"
    val = (rating, comment, date_created, product_id, user_id)
    mycursor.execute(sql, val)

    print(mycursor.statement)

    mydb.commit()

# generate and insert fake data into the category table
categories = [word for word in fake.words(nb=1000)]
for category in categories:
    sql = "INSERT INTO category (name) VALUES (%s)"
    val = (category,)
    mycursor = mydb.cursor()
    mycursor.execute(sql, val)

    print(mycursor.statement)

    mydb.commit()


# Insert fake data into the "payment_method" table
payment_methods = ["Credit Card", "PayPal", "Apple Pay", "Google Pay"]
for payment_method in payment_methods:
    sql = "INSERT INTO payment_method (name) VALUES (%s)"
    val = (payment_method,)
    mycursor = mydb.cursor()
    mycursor.execute(sql, val)

    print(mycursor.statement)

    mydb.commit()


# Insert fake data into the "orders" table
for i in range(80000):
    order_date = fake.date_time_this_year()
    price = fake.pyfloat(left_digits=3, right_digits=2, positive=True)
    payment_status = fake.random_element(
        elements=('PENDING', 'PAID', 'FAILED'))
    payment_method_id = fake.random_int(min=1, max=4)
    users_id = fake.random_int(min=1, max=99999)
    address_id = fake.random_int(min=1, max=99999)
    sql = "INSERT INTO orders (order_date, price, payment_status, payment_method_id, users_id, adress_id) VALUES (%s, %s, %s, %s, %s, %s)"
    val = (order_date, price, payment_status,
           payment_method_id, users_id, address_id)
    mycursor = mydb.cursor()
    mycursor.execute(sql, val)

    print(mycursor.statement)

    mydb.commit()

# Insert fake data into the "illustrates" table
for i in range(90000):
    image_id = fake.random_int(min=1, max=99999)
    product_id = fake.random_int(min=1, max=99999)
    sql = "INSERT INTO illustrates (image_id, product_id) VALUES (%s, %s)"
    val = (image_id, product_id)
    mycursor = mydb.cursor()
    mycursor.execute(sql, val)

    print(mycursor.statement)

    mydb.commit()

# Insert fake data into the "fullfils" table
for i in range(80000):
    product_id = fake.random_int(min=1, max=88888)
    orders_id = fake.random_int(min=1, max=79999)
    sql = "INSERT INTO fullfils (product_id, orders_id) VALUES (%s, %s)"
    val = (product_id, orders_id)
    mycursor = mydb.cursor()
    mycursor.execute(sql, val)

    print(mycursor.statement)

    mydb.commit()


# Add at least 1 category to a product
for i in range(60942, 100000):
    category_id = random.randint(1, 999)
    sql = "INSERT INTO product_category (product_id, category_id) VALUES (%s, %s)"
    val = (i, category_id)
    mycursor = mydb.cursor()
    mycursor.execute(sql, val)

    print(mycursor.statement)

    mydb.commit()


# add more than 1 category to a product
for i in range(1, 100000):
    product_id = random.randint(1, 99999)
    category_id = random.randint(1, 999)
    sql = "INSERT INTO product_category (product_id, category_id) VALUES (%s, %s)"
    val = (product_id, category_id)
    mycursor = mydb.cursor()
    mycursor.execute(sql, val)

    print(mycursor.statement)

    mydb.commit()

print("Time taken: ", time.time() - start)
