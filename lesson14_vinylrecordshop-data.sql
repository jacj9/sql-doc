/*
Lesson 14: Adding Data to the Vinyl Record Shop Database
Written on: January 1, 2025
*/

USE vinylrecordshop;

-- Listing 14.1: Updating the albumId
USE vinylrecordshop;
UPDATE album
	SET albumId = 5
WHERE albumTitle = 'Clouds';


-- Listing 14.2: Updating the Smiley Smile albumId
USE vinylrecordshop;
UPDATE album
	SET albumId = 9
WHERE albumTitle = 'Smiley Smile';

-- Listing 14.3: Deleting Artist Records
USE vinylrecordshop;
DELETE FROM artist WHERE artistid < 30;


-- Listing 14.4: Loading the artist.csv File
LOAD DATA LOCAL INFILE 'D:\Local Disk\Job Ready SQL\JobReadySQL-companionFiles\vinylrecordshop-data\album.csv'
INTO TABLE vinylrecordshop.album
FIELDS TERMINATED BY ',';
/*
Error Code: 2068. LOAD DATA LOCAL INFILE file request rejected due to restriction on access.
*/


/*
- Import the File using import wizard
- Right click on 'vinylrecordshop' database and select "Table Data Import Wizard"
- Import the file following the order of the table created in the schema
- Repeat the step of importing the file for all of the tables
- After, Write the query to verify that the file for each table is successfully imported
*/
USE vinylrecordshop;
SELECT *
FROM bandartist;


/*
ADD DATA TO THE SCRIPT
After importing the file into all of the tables, lets add data to the script.
- First, ensure that the file are imported into all of the tables, or else it will not work.
- Search for 'Command Prompt' to export new sql file for each table
- Go to bin directory in the command-line
- You might need to type the following (Note: Your file path may be different): cd C:\Program Files\MySQL Server 8.0\bin 
- Run mysqldump from the command line in this subdirectory. The syntax looks like this:
	mysqldump -p --user=root database table > destination_filepath
	- syntax example:
    mysqldump -p --user=root vinylrecordshop artist > C:/Users/user/Documents/artist.sql
- This will send the new .sql file to the user's Document folder.
- Export the new sql file that you have created on Workbench
- Scan through the file until you see INTER INTO statement 
- Copy the statement form the SQL and paste it at the end of the existing vinylrecordshop-data.sql file. 
- Repeat the steps for the rest of the tables. 
*/
INSERT INTO `album` VALUES (1,'Imagine','Apple','1971-09-09',9.99),(2,'2525 (Exordium & Terminus)','RCA','1969-07-01',25.99),(3,'No One\'s Gonna Change Our World','Regal Starline','1969-12-12',39.35),(4,'Moondance Studio Album','Warner Bros','1969-08-01',14.99),(5,'Clouds','Reprise','1969-05-01',9.99),(6,'Sounds of Silence Studio Album','Columbia','1966-01-17',9.99),(7,'Abbey Road','Apple','1969-01-10',12.99),(9,'Smiley Smile','Capitol','1967-09-18',5.99);

INSERT INTO `artist` VALUES (1,'John','Lennon',1),(2,'Paul','McCartney',1),(3,'George','Harrison',1),(4,'Ringo','Starr',1),(5,'Denny','Zager',0),(6,'Rick','Evans',0),(10,'Van','Morrison',1),(11,'Judy','Collins',0),(12,'Paul','Simon',1),(13,'Art','Garfunkel',0),(14,'Brian','Wilson',0),(15,'Dennis','Wilson',0),(16,'Carl','Wilson',0),(17,'Ricky','Fataar',0),(18,'Blondie','Chaplin',0),(19,'Jimmy','Page',0),(20,'Robert','Plant',0),(21,'John Paul','Jones',0),(22,'John','Bonham',0),(23,'Mike ','Love',0),(24,'Al ','Jardine',0),(25,'David','Marks',0),(26,'Bruce ','Johnston',0);

INSERT INTO `band` VALUES (1,'The Beatles'),(2,'Zager and Evans'),(3,'Van Morrison'),(4,'Judy Collins'),(5,'Simon and Garfunkel'),(7,'Beach Boys'),(8,'Led Zeppelin');

INSERT INTO `bandartist` VALUES (1,1),(1,2),(1,3),(1,4),(2,5),(2,6),(3,10),(4,11),(5,12),(5,13),(7,14),(7,15),(7,16),(7,17),(7,18),(8,19),(8,20),(8,21),(8,22),(7,23),(7,24),(7,25),(7,26);

INSERT INTO `song` VALUES (1,'Imagine','https://youtu.be/DVg2EJvvlF8',1),(2,'In the Year 2525','https://youtu.be/izQB2-Kmiic',2),(3,'Across the Universe','https://youtu.be/Tjq9LmSO1eI',1),(4,'Moondance','https://youtu.be/6lFxGBB4UG',3),(5,'Both Sides Now','https://youtu.be/rQOuxByR5VI',4),(6,'Sounds of Silence','https://youtu.be/qn0QBXMYXsM',5),(7,'Something','https://youtu.be/xLGe-QzCK4Q',1),(9,'Good Vibrations','https://youtu.be/d8rd53WuojE',7),(10,'Come Together','https://youtu.be/_HONxwhwmgU',1),(11,'Something','https://youtu.be/UKAp-jRUp2o',1),(12,'Maxwell\'s Silver Hammer','https://youtu.be/YQgsob_o1io',1);

INSERT INTO `songalbum` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(10,7),(11,7),(12,7),(9,9);


-- Quick check to verify that each table has the correct number of records
SELECT * FROM album; -- 8 records
SELECT * FROM artist; -- 23 records
SELECT * FROM song; -- 11 records
SELECT * FROM band; -- 7 records
SELECT * FROM bandartist; -- 23 records
SELECT * FROM songalbum; -- 11 records