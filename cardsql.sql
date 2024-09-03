-- Table for storing user accounts
CREATE TABLE users (
    userId INT PRIMARY KEY AUTO_INCREMENT,
    userFullname VARCHAR(150) NOT NULL,
    userEmail VARCHAR(50) UNIQUE NOT NULL,
    userPassword VARCHAR(50) NOT NULL,
    userBalance INT DEFAULT 0,
    userVerified INT DEFAULT 0,
    userAccountType ENUM('regular', 'gold', 'platinum','admin')
);

-- Table for storing groups
CREATE TABLE groups (
    groupId INT PRIMARY KEY AUTO_INCREMENT,
    groupName  VARCHAR(50) UNIQUE NOT NULL,
    groupPhoto VARCHAR(500)
);

-- Table for storing categories
CREATE TABLE categories (
    catId INT PRIMARY KEY AUTO_INCREMENT,
    catName  VARCHAR(50) UNIQUE NOT NULL,
    catNameAr VARCHAR(50) UNIQUE NOT NULL,
    catPhoto VARCHAR(500),
    groupId INT,
    FOREIGN KEY (groupId) REFERENCES groups(groupId)
);

-- Table for storing subcategories
CREATE TABLE subcategory (
    subId  INT PRIMARY KEY AUTO_INCREMENT,
    subName  VARCHAR(50) UNIQUE NOT NULL,
    subNameAr  VARCHAR(50) UNIQUE NOT NULL,
    subPhoto VARCHAR(500),
    catId  INT,
    FOREIGN KEY (catId) REFERENCES categories(catId)
);

-- Table for storing items
CREATE TABLE items (
    itemId INT PRIMARY KEY AUTO_INCREMENT,
    itemName VARCHAR(100) UNIQUE NOT NULL,
    subcategoryId INT,
    FOREIGN KEY (subcategoryId) REFERENCES subcategories(subcategoryId)
);

CREATE TABLE allFields (
    fieldId INT PRIMARY KEY AUTO_INCREMENT,
    fieldName VARCHAR(100) NOT NULL,
    fieldType VARCHAR(50) NOT NULL
);

CREATE TABLE itemFields (
    itemFieldId INT PRIMARY KEY AUTO_INCREMENT,
    itemId INT,
    fieldId INT,
    FOREIGN KEY (itemId) REFERENCES items(itemId),
    FOREIGN KEY (fieldId) REFERENCES allFields(fieldId)
);


-- Table for storing user responses to item details
CREATE TABLE user_responses (
    response_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    item_detail_id INT,
    response_value VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES users(userId),
    FOREIGN KEY (item_detail_id) REFERENCES item_details(item_detail_id)
);

-- Table for storing credits/transactions
CREATE TABLE transactions (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    item_id INT,
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(userId),
    FOREIGN KEY (item_id) REFERENCES items(itemId)
);

CREATE TABLE orders (
    orderId INT PRIMARY KEY AUTO_INCREMENT,
    orderUserId INT,
    orderItemId INT,
    orderPlayerId VARCHAR(100),
    order_uuid VARCHAR(500),
    orderQty INT DEFAULT 1,
    orderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    orderStatus VARCHAR(50) NOT NULL DEFAULT 'new',
    orderTotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (orderUserId) REFERENCES users(userId),
    FOREIGN KEY (orderItemId) REFERENCES items(itemId)
);

CREATE TABLE settings (
  id INT AUTO_INCREMENT PRIMARY KEY,
  key_name VARCHAR(50) NOT NULL UNIQUE,
  value int NOT NULL
);

INSERT INTO settings (key_name, value) VALUES ('under_construction', 0);

CREATE TABLE payments (
  paymentId INT AUTO_INCREMENT PRIMARY KEY,
  paymentCreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  paymentReciept VARCHAR(500),
  paymentUserId INT,
   FOREIGN KEY (paymentUserId) REFERENCES users(userId)
);

CREATE TABLE customPriceItem (
    id INT AUTO_INCREMENT PRIMARY KEY,
    itemId INT,
    userId INT,
    customPrice decimal(30,20) NOT NULL,
    FOREIGN KEY (itemId) REFERENCES items(itemId),
    FOREIGN KEY (userId) REFERENCES users(userId)
)




