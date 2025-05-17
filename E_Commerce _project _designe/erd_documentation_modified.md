
ERD Documentation

1. Entity Classification

Strong Entities:
  Customer, Product, Inventory, Orders

Weak Entities:
  User, Review, Inventory (item), Transaction

2. Supertype and Subtype

Supertype:
  Customer

Subtypes:

  User
    Inherits from Customer
    Primary Key: UserID
    Attributes: Address, RegistrationDate


3. Entities and Attributes

Customer
 CustomerID (Required, Unique)
 Email (Required)
 Address (Required)
 

User

 UserID (Required, Unique)
 Email (Required, Unique)
 Username (Required, Unique)
 Password
 RegistrationDate (Required)

Product

 ProductID (Required, Unique)
 Name (Required)
 Description (Required)
 MSRP (Required)
 Cost (Required)
 Category (Required)
 StockQuantity (Required)

Inventory

 ProductID (Required, Unique)
 Quantity (Required)

Order

 OrderID (Required, Unique)
 CustomerID (Required)
 OrderDate (Required)

Transaction

 TransactionID (Required, Unique)
 OrderID (Required)
 PaymentAmount (Required)
 PaymentDate (Required)

Review

 ReviewID (Required, Unique)
 CustomerID (Required)
 ProductID (Required)
 Rating (Required)
 Comment (Required)
 ReviewDate (Required)

4. Relationships and Cardinalities

All relationships use Crow’s-foot notation with clearly defined minimum and maximum cardinalities.

 Customer  to  Order (one to many)

 
 Order     to Transaction (one to one)


 Transaction to Product (many to many)

 
 Product   to  Inventory (one to one)

 
 Product   to Review (one to many)

 
 Customer  to  Review (one to many)
 

 Customer      to User (supertye and subtype)
 
