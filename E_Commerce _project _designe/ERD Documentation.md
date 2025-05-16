
ERD Documentation

1. Entity Classification

Strong Entities:
  User, Customer, Admin, Product, Category, Inventory, Order, Transaction, Review

Weak Entities:
  None

2. Supertype and Subtype

Supertype:
  User

Subtypes:

  Customer
    Inherits from User
    Primary Key: UserID
    Attributes: Address, RegistrationDate

  Admin
    Inherits from User
    Primary Key: UserID
    Attribute: AdminPrivileges

Constraint:
  Subtype participation is disjoint and complete:
  Each User must be exactly one subtype — either a Customer or an Admin, not both.
3. Entities and Attributes

User

UserID (Required, Unique)
 Name (Required)
 Email (Required, Unique)

Customer

 CustomerID (Required, Unique)
Address (Required)
 RegistrationDate (Required)

Admine

 AdminID (Required, Unique)
AdminPrivileges (Required)

Category

 CategoryID (Required, Unique)
CategoryName (Required, Unique)

Product

 ProductID (Required, Unique)
 Name (Required)
 Description (Required)
 Price (Required)
CategoryID (Required)
StockQuantity (Required)

Inventory

 InventoryID (Required, Unique)
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

 Customer  to  Order (one or many)

 
 Order     to Transaction (one or more)

 
 Product   to  Inventory (1 to many)

 
 Product   to reviewed in Review (one  or many)

 
 Customer  to  Review (one to many )

 
 Category  to  Product (zero or more)

 
 User      to  admine  (supertye and subtype)
 
