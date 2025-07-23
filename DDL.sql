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
  orderTotal DECIMAL(10,2) NOT NULL CHECK (orderTotal >= 0),
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
  price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
  description TEXT,
  FOREIGN KEY (aisleID) REFERENCES Aisles(aisleID)
);


-- OrderProducts
CREATE OR REPLACE TABLE OrderProducts (
  orderProductID INT AUTO_INCREMENT PRIMARY KEY,
  orderID INT NOT NULL,
  productID INT NOT NULL,
  qtyOrdered INT NOT NULL CHECK (qtyOrdered >= 1),
  unitPrice DECIMAL(10,2) NOT NULL CHECK (unitPrice >= 0),
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


SET foreign_key_checks = 1;
COMMIT;
