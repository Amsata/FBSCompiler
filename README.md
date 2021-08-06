# FBSCompiler

Create an Shiny application to compile Food Balance Sheet. The advantage of the bellow application is that is connects to a `PostgresSQL` database. Compare to the standard application, the below application has the advantage to Backup and restore restore the FBS database in `R` localhost environment.

**Avantages**

* Allow to restore and Backup the FBS database in a localhost environment.

* Provide a better way to extract, process and save back the different SUA/FBS files. (doing this work with different `csv` files is not user-friendly)

* This infrastructure can be deployed (if means are there) in a web-base environment and can make the team work betters.

* Modifications are better managed in this App than in the standard one

**limitations**

* the application users should have some basic knowledge in R

* the application users should have basic `SQL` knowledge (optional)


# Application setup

Before running the application, the user should install postgres and postgrees OECD driver

* [Download postgres SQL](https://www.postgresql.org/download/)

Driver options
The official PostgreSQL website provides instructions on how to download and setup their driver
* [download postgres ODBC driver](https://odbc.postgresql.org/)

After that, the user need to create an empty database in postgres `pgAdmin`.

The application is setup using a standard `SQL`. The `SQL` creates all the table required like the SUA, SUA items, FBS items, Elements, etc. Once those reference tables are created, there is an `R` script that fill all the references. 


