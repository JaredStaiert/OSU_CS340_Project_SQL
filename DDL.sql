SET foreign_key_checks = 0;
SET AUTOCOMMIT = 0;

-- Customers
CREATE OR REPLACE TABLE Customers (
        customerID INT AUTO_INCREMENT PRIMARY KEY,
        firstName VARCHAR(55) NOT NULL,
        lastName VARCHAR(55) NOT NULL,
        email VARCHAR(255),
        phoneNumber VARCHAR(15)
    );

-- Orders
CREATE OR REPLACE TABLE Orders (
        orderID INT AUTO_INCREMENT PRIMARY KEY,
        customerID INT NOT NULL,
        orderDate DATE NOT NULL,
        pickupDate DATE,
        shipDate DATE,
        hasShipped BOOLEAN NOT NULL DEFAULT FALSE,
        isComplete BOOLEAN NOT NULL DEFAULT FALSE,
        orderTotal DECIMAL(10, 2) NOT NULL CHECK (orderTotal >= 0),
        paymentMethod VARCHAR(50) NOT NULL,
        orderTimestamp TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
        lastUpdated TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        FOREIGN KEY (customerID) REFERENCES Customers(customerID)
    );

-- Products
CREATE OR REPLACE TABLE Products (
        productID INT AUTO_INCREMENT PRIMARY KEY,
        aisleID VARCHAR(55) NOT NULL,
        productName VARCHAR(255) NOT NULL,
        productType VARCHAR(255) NOT NULL,
        qtyOnHand INT NOT NULL CHECK (qtyOnHand >= 0),
        price DECIMAL(10, 2) NOT NULL CHECK (price >= 0),
        description TEXT,
        FOREIGN KEY (aisleID) REFERENCES Aisles(aisleID)
    );


-- OrderProducts
CREATE OR REPLACE TABLE OrderProducts (
        orderProductID INT AUTO_INCREMENT PRIMARY KEY,
        orderID INT NOT NULL,
        productID INT NOT NULL,
        qtyOrdered INT NOT NULL CHECK (qtyOrdered >= 1),
        unitPrice DECIMAL(10, 2) NOT NULL CHECK (unitPrice >= 0),
        FOREIGN KEY (orderID) REFERENCES Orders(orderID),
        FOREIGN KEY (productID) REFERENCES Products(productID)
    );

-- Aisles
CREATE OR REPLACE TABLE Aisles (
        aisleID VARCHAR(55) PRIMARY KEY,
        aisleType VARCHAR(255) NOT NULL,
        description VARCHAR(500),
        isActive BOOLEAN NOT NULL DEFAULT TRUE
    );

INSERT INTO Customers (
        customerID,
        firstName,
        lastName,
        email,
        phoneNumber
    )
VALUES (
        1,
        'Sarah',
        'Johnson',
        'sarah.johnson@oregonstate.edu',
        '541-565-0123'
    ),
    (
        2,
        'Aaron',
        'Rogers',
        'aaron.rogers@oregonstate.edu',
        '541-555-0456'
    ),
    (
        3,
        'Jonathon',
        'Taylor',
        'jonathon.taylor@oregonstate.edu',
        '541-565-0123'
    );

INSERT INTO Products (
        productID,
        aisleID,
        productName,
        productType,
        qtyOnHand,
        price
    )
VALUES (1, 'A1', 'Curse of Strahd', 'RPG Game', 5, 49.99),
    (2, 'A1', 'Catan', 'Board Game', 10, 19.99),
    (3, 'B1', 'D&D Starter Set', 'RPG Game', 5, 55.99);

INSERT INTO Orders (
        orderID,
        customerID,
        orderDate,
        pickupDate,
        shipDate,
        hasShipped,
        isComplete,
        orderTotal,
        paymentMethod,
        orderTimestamp,
        lastUpdated
    )
VALUES (
        101,
        1,
        '2025-07-20',
        '2025-07-21',
        NULL,
        FALSE,
        TRUE,
        49.99,
        'credit',
        '2025-07-20',
        '2025-07-21 09:12:00'
    ),
    (
        102,
        2,
        '2025-07-21',
        NULL,
        '2025-07-23',
        TRUE,
        TRUE,
        39.98,
        'cash',
        '2025-07-21',
        '2025-07-23 18:45:00'
    ),
    (
        103,
        3,
        '2025-07-22',
        NULL,
        NULL,
        FALSE,
        FALSE,
        19.99,
        'credit',
        '2025-07-22 08:10:00',
        '2025-07-22'
    ),
    (
        104,
        4,
        '2025-07-22',
        '2025-07-22',
        NULL,
        FALSE,
        TRUE,
        55.99,
        'debit',
        '2025-07-22',
        '2025-07-22 10:02:00'
    );

INSERT INTO OrderProducts (
        OrderProductID,
        orderID,
        productID,
        qtyOrdered,
        unitPrice
    )
VALUES (301, 101, 1, 1, 49.99),
    (302, 102, 2, 2, 39.98),
    (303, 104, 3, 1, 55.99),
    (304, 105, 1, 1, 49.99),
    (305, 103, 2, 1, 19.99);

INSERT INTO Aisles (aisleID, aisleType, description, isActive)
VALUES (
        'A1',
        'Tabletop Rules',
        'Dnd, Pathfinder, etc',
        TRUE
    ),
    ('B1', 'Box Sets', 'Dnd Box set', TRUE);

SET foreign_key_checks = 1;
COMMIT;
