# coursera
# Manage Data for an Online Grocer Using MySQL Workbench

The files added to this repository are:
- An image of a completed database model outlining your database design.
- A script to recreate your fully functioning database populated with sample data.
- A collection of SQL queries/scripts that join tables to demonstrate the validity of the database design. 

## Project Scenario

Greenspot Grocer is a (fictional) small, family-owned online grocery store that is growing rapidly and planning a major expansion. They are currently storing their product data in a spreadsheet format that has become unwieldy and will soon be unable to accommodate their growing inventory.  

They want to examine their current data and design a relational database that will be able provide the ability to organize and store current data, while providing scalability as the business expands its product offerings.  

Project Objectives

1. Examine the current data and reorganize it into relational tables using the modeling tool in MySQL Workbench. 
2. Create and load the database with the sample data provided. 
3. Test the database design and verify the design by generating SQL JOIN queries.  

## The steps took in this project are:
1. Exploration of the sample data, for the fields that can be grouped together.
2. Usage of MySQL Workbench to generate a database model that includes tables, with their fields, and shows relationships between tables with primary keys, and foreign keys where applicable.
3. Implementation of the database design by creating the database and its tables and populating the tables with the sample data provided.
4. Generation of SQL JOIN queries to prove the validity of your database design.
5. Exporting the EER diagram for the tables created.

The raw data had empty data entries, non-reliable column names, and incorrect column data types. First empty data entries are converted to null value. The new tables are created according to data model. 
- Items: table stores everything about the specifics of an item.
- Vendors: table stores vendor details. Vendor id is created using AUTO INCREMENT method to create PRIMARY KEY value.
- Inventory: table stores inventory details of the items. Item number is a FOREIGN KEY to create a relationship with the specifics of an item, and the inventory table stores available quantity, location of the item, puschase date and cost. Also inventory id is created as PRIMARY KEY.
- Sales: table stores details of an item sold, quantity and date of an item sold, customer id who purchased and price. Sale id is created as PRIMARY KEY and item number is connected with items table using FOREIGN KEY.

After the tables are created and relationships between tables are managed, few SQL queries are performed for validation. The validation queries checked the following:
1. Unique values of vendors.
2. Verification of JOIN query between items and vendors tables.
3. Checking inventory details by joining inventory and items tables.
4. Monitor of sales data by sales and items tables.
5. Creating the original data by joining all tables into one. 
