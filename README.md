# E-Commerce-Snowflake-Project

## Introduction
This repository contains SQL worksheets designed to analyze an Instacart dataset. The dataset includes information about orders, products, users, and more. By using these scripts, we get insights into customer behavior, product popularity, and other key metrics.

## Overview

The repository includes two main SQL scripts:

1. **InstaCart_Fact_Dim.sql:** This script sets up the database tables in Snowflake and loads the data from CSV files stored in an S3 bucket.
Stage Creation: Creates a stage to load data from an S3 bucket.
File Format Creation: Defines the CSV file format for data loading.
**Table Creation and Data Loading:**
aisles: Creates and populates the aisles table.
departments: Creates and populates the departments table.
orders: Creates and populates the orders table.
products: Creates and populates the products table.
order_products: Creates and populates the order_products table.
**Dimensional Tables:**
dim_users: Creates a dimension table for users from the orders table.
dim_products: Creates a dimension table for products with product details.
2. **InstaCart_Analysis.sql:** This script contains various analytical queries to extract insights from the data

## Services Used
1. Amazon S3
Amazon Simple Storage Service (S3) is used to store the CSV files containing the Instacart data.
2. Snowflake
Snowflake is used as the data warehouse for storing and querying the Instacart dataset.

## Conclusion
By using the scripts provided in this repository, you can easily set up a database with the Instacart dataset and perform various analyses to gain insights into customer behavior and product performance. These insights can help drive business decisions and improve overall strategy.


