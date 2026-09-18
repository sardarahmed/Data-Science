-- %%
CREATE TABLE
    Customers (
        customerID INT PRIMARY KEY,
        customerName VARCHAR(50)
    )

-- %%
cREATE TABLE
    Orders (
        orderID INT PRIMARY KEY,
        customerID INT,
        orderDate DATE,
        FOREIGN KEY (customerID) REFERENCES Customers(customerID)
    )

-- %%
INSERT INTO
    Customers (customerID, customerName)
VALUES
    (1, 'John Doe'),
    (2, 'Jane Smith'),
    (3, 'Alice Johnson'),
    (4, 'Bob Brown'),
    (5, 'Charlie Davis'),
    (6, 'Diana Evans'),
    (7, 'Frank Green'),
    (8, 'Grace Harris'),
    (9, 'Henry Jackson'),
    (10, 'Ivy King');

-- %%
SELECT
    *
FROM
    Customers;

-- %%
INSERT INTO
    orders (orderID, customerID, orderDate)
VALUES
    (1, 1, '2023-01-15'),
    (2, 2, '2023-02-20'),
    (3, 3, '2023-03-10'),
    (4, 4, '2023-04-05'),
    (5, 5, '2023-05-12'),
    (6, 6, '2023-06-18'),
    (7, 7, '2023-07-22'),
    (8, 8, '2023-08-30'),
    (9, 9, '2023-09-14'),
    (10, 10, '2023-10-01');

-- %%
SELECT
    *
FROM
    orders;

-- %%
SELECT
    customers.customerName,
    orders.orderid
FROM
    Customers
    INNER JOIN orders ON customers.customerID = orders.customerID;

-- %%
SELECT
    customers.customerName,
    orders.orderid
FROM
    Customers
    LEFT JOIN orders ON customers.customerID = orders.customerID;

-- %%
SELECT
    customers.customerName,
    orders.orderid
FROM
    Customers
    RIGHT JOIN orders ON customers.customerID = orders.customerID;

-- %%
SELECT
    customers.customerName,
    orders.orderid
FROM
    Customers
    FULL OUTER JOIN orders ON customers.customerID = orders.customerID;

-- %%
drop table if EXISTS customers;
drop table if EXISTS orders;

-- %% [md]
Example pratice


-- %%
CREATE TABLE
    Customers (
        customer_id INT,
        name VARCHAR(50),
        city VARCHAR(50)
    );


CREATE TABLE
    Orders (
        order_id INT,
        customer_id INT,
        product_id INT,
        amount DECIMAL(10, 2)
    );


CREATE TABLE
    Products (
        product_id INT,
        product_name VARCHAR(50),
        category VARCHAR(50)
    );

-- %%
INSERT INTO
    Customers (customer_id, name, city)
VALUES
    (1, 'Ahmed', 'Paris'),
    (2, 'Ali', 'Lyon'),
    (3, 'Sara', 'Lille'),
    (4, 'John', 'Paris'),
    (5, 'Maria', 'Nice'),
    (6, 'David', 'Marseille');

-- %%
INSERT INTO
    Orders (order_id, customer_id, product_id, amount)
VALUES
    (101, 1, 1, 120),
    (102, 2, 2, 80),
    (103, 1, 3, 50),
    (104, 3, 1, 200),
    (105, 7, 2, 90),
    (106, 4, 4, 150);

-- %%
INSERT INTO
    Products (product_id, product_name, category)
VALUES
    (1, 'Laptop', 'Electronics'),
    (2, 'Mouse', 'Electronics'),
    (3, 'Keyboard', 'Electronics'),
    (4, 'Chair', 'Furniture'),
    (5, 'Desk', 'Furniture');

-- %%
SELECT
    customers.customer_id,
    customers.name,
    orders.order_id,
    orders.amount
FROM
    customers
    INNER JOIN orders ON customers.customer_id = orders.customer_id;

-- %%
SELECT
    customers.name,
    orders.order_id,
    products.product_name,
    orders.amount
FROM
    customers
    INNER JOIN orders ON customers.customer_id = orders.customer_id
    INNER JOIN products ON orders.product_id = products.product_id;

-- %%
SELECT
    name,
    order_id,
    amount
FROM
    customers
    LEFT JOIN orders ON customers.customer_id = orders.customer_id;

-- %%
SELECT
    name,
    order_id,
    amount,
    customers.customer_id
FROM
    customers
    RIGHT JOIN orders ON customers.customer_id = orders.customer_id;

-- %%
SELECT
    name,
    order_id,
    amount,
    customers.customer_id
FROM
    customers
    FULL OUTER JOIN orders ON customers.customer_id = orders.customer_id;

-- %%
SELECT
    
    orders.order_id,
    products.product_name,
    orders.amount
FROM
    products
    LEFT JOIN orders ON products.product_id = orders.product_id;

-- %%
SELECT
    customers.name
FROM
    customers
    LEFT JOIN orders ON customers.customer_id = orders.customer_id where orders.customer_id IS NULL;

-- %%
SELECT
    products.product_name
FROM
    products
    LEFT JOIN orders ON products.product_id = orders.product_id where orders.product_id IS NULL;

-- %%
SELECT
    customers.name,
    products.product_name,
    orders.amount
FROM
    customers
    INNER JOIN orders ON customers.customer_id = orders.customer_id 
    INNER JOIN products ON orders.product_id = products.product_id
    where orders.amount > 100;

-- %%
SELECT
    customers.name,
    COALESCE(SUM(orders.amount), 0) AS total_spent
FROM
    customers
    LEFT JOIN orders ON customers.customer_id = orders.customer_id
GROUP BY
    customers.customer_id,
    customers.name;