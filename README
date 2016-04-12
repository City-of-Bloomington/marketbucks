README
======
Marketbucks is an application to manage market bucks (gift cerificates) that city citizens can use in farmer market. The program is designed to encourage low income families to purchase items from farmers market by providing them free market bucks against their purchase up to certain amount (currently for every $18 the individual will get another $18).

Beside managing the marketbucks the program create marketbucks using pdf file and barcodes that can be print on similar to checks papers.

To issue marketbucks or gift certificates the application can handle barcode reader type 34 for both to issue or redeem these marketbucks.

The application is writen in java programming language using jsp and structs 2. Mysql is the database of choice.

To install you will need to compile the src code using java compiler and deploy using one of servlet/jsp servers running apache tomcat or other servlet containers.

In the WEB-INF directory, there is a file called web.xml.example, you will need to copy to a file with the name web.xml and set the url's in this file accordingly.

The database setup is in the file context.xml.example in the directory META-INF. You would need to change the file name to context.xml and set the url and password for your database.

The application assumes that you have a CAS authentication server. You will need the url for this server in WEB-INF/web.xml file mentioned before.

You will need to create the database (mysql) with the name marketbucks or any other name and your own password. Use the file scripts/mysql.sql file to create these tables. Database configuration is in META-INF/context.xml where you can set the database name, database user and password.

We use quartz library to schedule emails that will be delivered once a week to report current inventories of MB's and GC's. The jar library is included in WEB-INF/lib/ folder. You need to set the database name, user and password. I used the same database for the system and quartz. You need to copy the file quartz.properties.example to quartz.properties and update what is needed to be updated. The file is located in WEB-INF/classes/ folder. You will need to create the needed tables for quartz to work properly. You can disable email option in testing phase by setting 'activeMail' flag to false in web.xml file.

When database is created you will need to add a list of users who are allowed to use the system, look into database table 'users' and add the users accordingly.

If you create another database other than mysql you will need to change what is in context.xml accordingly. You may also need to change the sentics for database inserts/updates in java classes.

If you add new fields to database tables make sure to add similar attributes to related classes and jsp pages.

When everything is set, you can point your browser to

http://your server url/marketbucks

I used 'ant' to build and compile java classes. If you want to use maven, you may need to restructure the files in maven way.

We are using third party java libraries, such as itext.pdf 2.1.7 (free version) to create pdf files. We use it to create market bucks and gift certificates with check papers.

We are using another java library called barbeque to create bar codes on marketbucks so that these marketbucks can be read using barcode readers both in issuing and redeeming market bucks.

The program assumes that there are a list of vendors that are using farmers market that accept marketbucks. Each vendor will have a vendor name and number. In our city each vendor have an ID card provided by the city that include their name and a barcode with their number. The vendors use their cards to redeem their marketbucks in exchange for money.





 
