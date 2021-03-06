# C
/********************************************************************************/
/*																		        */
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 10C         	*/
/*																		        */
/*	The VRG-CH10C-PQ Database - Create Tables 10C-36-C	                        */
/*	Leave out NationalityValues constraint in ARTIST					        */
/*	These are the MySQL 5.6 SQL code solutions                              	*/
/*																		        */
/********************************************************************************/


CREATE TABLE ARTIST (
	ArtistID 		     Int 				NOT NULL,
	LastName		     Char(25)			NOT NULL,
	FirstName		     Char(25)			NOT NULL,
	Nationality      	 Char(30)			NULL,
	DateOfBirth      	 Numeric(4)			NULL,
	DateDeceased     	 Numeric(4)			NULL,
	CONSTRAINT 	ArtistPK				  PRIMARY KEY(ArtistID),
	CONSTRAINT 	ArtistAK1				  UNIQUE(LastName, FirstName),
	/* CONSTRAINT 	NationalityValues CHECK
					(Nationality IN ('Canadian', 'English', 'French',
					 'German', 'Mexican', 'Russian', 'Spanish',
					 'United States')), */
	CONSTRAINT 	BirthValuesCheck  CHECK (DateOfBirth < DateDeceased),
	CONSTRAINT 	ValidBirthYear 	  CHECK
					(DateOfBirth LIKE '[1-2][0-9][0-9][0-9]'),
	CONSTRAINT 	ValidDeathYear 	  CHECK
					(DateDeceased LIKE '[1-2][0-9][0-9][0-9]')
	);

CREATE TABLE WORK (
	WorkID 			     Int 				NOT NULL,
	Title 				 Char(35) 		 	NOT NULL,
	Copy 				 Char(12)			NOT NULL,
	Medium 			     Char(35) 		 	NULL,
	Description			 Varchar(1000) 		NULL DEFAULT 'Unknown provenance',
	ArtistID 			   Int 				NOT NULL,
	CONSTRAINT 	WorkPK					 PRIMARY KEY(WorkID),
	CONSTRAINT 	WorkAK1				     UNIQUE(Title, Copy),
	CONSTRAINT 	ArtistFK				 FOREIGN KEY(ArtistID)
      						 REFERENCES ARTIST(ArtistID)
 							        ON UPDATE NO ACTION
							        ON DELETE NO ACTION
	);

CREATE TABLE CUSTOMER (
	CustomerID 			 Int 				NOT NULL,
	LastName 			 Char(25) 		 	NOT NULL,
	FirstName 			 Char(25) 			NOT NULL,
	Street 			     Char(30) 		 	NULL,
	City 				 Char(35)	 		NULL,
	State 			     Char(2) 			NULL,
	ZipPostalCode		 Char(9)			NULL,
	Country			     Char(50)			NULL,
	AreaCode 			 Char(3)			NULL,
	PhoneNumber 		 Char(8) 			NULL,
	Email				 Varchar(100)  		NULL,
  CONSTRAINT 	CustomerPK			   	PRIMARY KEY(CustomerID),
	CONSTRAINT 	EmailAK1				UNIQUE(Email)
	);

CREATE TABLE TRANS (
	TransactionID		 Int 				NOT NULL,
	DateAcquired 		 Datetime			NOT NULL,
	AcquisitionPrice 	 Numeric(8,2)	 	NOT NULL,
	DateSold			 Datetime			NULL,
	AskingPrice			 Numeric(8,2)	 	NULL,
	SalesPrice 			 Numeric(8,2)	 	NULL,
	CustomerID			 Int 				NULL,
	WorkID				 Int 				NOT NULL,
	CONSTRAINT 	TransPK				    PRIMARY KEY(TransactionID),
	CONSTRAINT 	TransWorkFK			   	FOREIGN KEY(WorkID)
						       REFERENCES WORK(WorkID)
 							        ON UPDATE NO ACTION
									ON DELETE NO ACTION,
	CONSTRAINT 	TransCustomerFK 	 	FOREIGN KEY(CustomerID)
						       REFERENCES CUSTOMER(CustomerID)
 							        ON UPDATE NO ACTION
							        ON DELETE NO ACTION,
	CONSTRAINT 	SalesPriceRange 	 	CHECK
					         ((SalesPrice > 0) AND (SalesPrice <=500000)),
	CONSTRAINT	ValidTransDate 		 	CHECK (DateAcquired <= DateSold)
	);

CREATE TABLE CUSTOMER_ARTIST_INT(
	ArtistID 			 Int 				NOT NULL,
	CustomerID 			 Int 				NOT NULL,
  CONSTRAINT 	CAIntPK				    PRIMARY KEY(ArtistID, CustomerID),
	CONSTRAINT 	CAInt_ArtistFK		 	FOREIGN KEY(ArtistID)
						       REFERENCES ARTIST(ArtistID)
									ON UPDATE NO ACTION
							        ON DELETE CASCADE,
	CONSTRAINT 	CAInt_CustomerFK   		FOREIGN KEY(CustomerID)
						       REFERENCES CUSTOMER(CustomerID)
							        ON UPDATE NO ACTION
							        ON DELETE CASCADE
	);

/********************************************************************************/
/*																		        */
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 10C         	*/
/*																		        */
/*	The VRG-CH10C-PQ Database - Insert Data				                        */
/*																		        */
/*	These are the MySQL 5.6 SQL code solutions                              	*/
/*																		        */
/********************************************************************************/
/*																				*/
/*	This file contains the initial data for each table.						    */
/*	Thie file also sets the AUTO_INCREMENT property for each table, but         */
/*  on after the non-consecutive surrogate key values are entered.              */
/*																				*/
/********************************************************************************/

/********************************************************************************/

/*	INSERT data for CUSTOMER															                      */


INSERT INTO CUSTOMER
	(CustomerID, LastName, FirstName, Street, City, State, ZipPostalCode, Country,
	 AreaCode, PhoneNumber, Email)
	VALUES (
	1000, 'Janes', 'Jeffrey', '123 W. Elm St', 'Renton', 'WA', '98055', 'USA',
	'425', '543-2345', 'Jeffrey.Janes@somewhere.com');
INSERT INTO CUSTOMER
	(CustomerID, LastName, FirstName, Street, City, State, ZipPostalCode, Country,
	 AreaCode, PhoneNumber, Email)
	VALUES (
 	1001, 'Smith', 'David', '813 Tumbleweed Lane', 'Loveland', 'CO', '81201', 'USA',
 	'970', '654-9876', 'David.Smith@somewhere.com');
INSERT INTO CUSTOMER
	(CustomerID, LastName, FirstName, Street, City, State, ZipPostalCode, Country,
	 AreaCode, PhoneNumber, Email)
	VALUES (
	1015, 'Twilight', 'Tiffany', '88 1st Avenue', 'Langley', 'WA', '98260', 'USA',
	 '360', '765-5566', 'Tiffany.Twilight@somewhere.com');
INSERT INTO CUSTOMER
	(CustomerID, LastName, FirstName, Street, City, State, ZipPostalCode, Country,
	 AreaCode, PhoneNumber, Email)
	VALUES (
	1033, 'Smathers', 'Fred', '10899 88th Ave', 'Bainbridge Island', 'WA', '98110', 'USA',
	'206', '876-9911', 'Fred.Smathers@somewhere.com');
INSERT INTO CUSTOMER
	(CustomerID, LastName, FirstName, Street, City, State, ZipPostalCode, Country,
	 AreaCode, PhoneNumber, Email)
	VALUES (
	1034, 'Frederickson', 'Mary Beth', '25 South Lafayette', 'Denver', 'CO', '80201', 'USA',
	'303', '513-8822', 'MaryBeth.Frederickson@somewhere.com');
INSERT INTO CUSTOMER
	(CustomerID, LastName, FirstName, Street, City, State, ZipPostalCode, Country,
	 AreaCode, PhoneNumber, Email)
	VALUES (
	1036, 'Warning', 'Selma', '205 Burnaby', 'Vancouver', 'BC', 'V6Z 1W2', 'Canada',
	'604', '988-0512', 'Selma.Warning@somewhere.com');
INSERT INTO CUSTOMER
	(CustomerID, LastName, FirstName, Street, City, State, ZipPostalCode, Country,
	 AreaCode, PhoneNumber, Email)
	VALUES (
	1037, 'Wu', 'Susan', '105 Locust Ave', 'Atlanta', 'GA', '30322', 'USA',
	'404', '653-3465', 'Susan.Wu@somewhere.com');
INSERT INTO CUSTOMER
	(CustomerID, LastName, FirstName, Street, City, State, ZipPostalCode, Country,
	 AreaCode, PhoneNumber, Email)
	VALUES (
	1040, 'Gray', 'Donald','55 Bodega Ave', 'Bodega Bay', 'CA', '94923', 'USA',
	'707', '568-4839', 'Donald.Gray@somewhere.com');
INSERT INTO CUSTOMER
	(CustomerID, LastName, FirstName, Street, City, State, ZipPostalCode, Country,
	 AreaCode, PhoneNumber)
	VALUES (
	1041, 'Johnson', 'Lynda', '117 C Street', 'Washington', 'DC', '20003', 'USA',
	'202', '438-5498');
INSERT INTO CUSTOMER
	(CustomerID, LastName, FirstName, Street, City, State, ZipPostalCode, Country,
	 AreaCode, PhoneNumber, Email)
	VALUES (
	1051, 'Wilkens', 'Chris', '87 Highland Drive', 'Olympia', 'WA', '98508', 'USA',
	'360', '765-7766', 'Chris.Wilkens@somewhere.com');

/* Set AUTO_INCREMENT for the CUSTOMER table                                    */

ALTER TABLE TRANS
		DROP FOREIGN KEY TransCustomerFK;

ALTER TABLE CUSTOMER_ARTIST_INT
		DROP FOREIGN KEY CAInt_CustomerFK;

ALTER TABLE CUSTOMER
		MODIFY COLUMN CustomerID INTEGER NOT NULL AUTO_INCREMENT;

ALTER TABLE CUSTOMER AUTO_INCREMENT = 1052;

ALTER TABLE TRANS
		ADD CONSTRAINT TransCustomerFK FOREIGN KEY(CustomerID)
			REFERENCES CUSTOMER(CustomerID)
				ON UPDATE NO ACTION
				ON DELETE NO ACTION;

ALTER TABLE CUSTOMER_ARTIST_INT
		ADD CONSTRAINT CAInt_CustomerFK FOREIGN KEY (CustomerID)
			REFERENCES CUSTOMER(CustomerID)
				ON UPDATE NO ACTION
				ON DELETE CASCADE;

/********************************************************************************/

/*	INSERT data for ARTIST															                        */

INSERT INTO ARTIST
	(ArtistID, LastName, FirstName, Nationality, DateOfBirth, DateDeceased)
	VALUES (
	1, 'Miro', 'Joan', 'Spanish', 1893, 1983);
INSERT INTO ARTIST
	(ArtistID, LastName, FirstName, Nationality, DateOfBirth, DateDeceased)
	VALUES (
	2, 'Kandinsky', 'Wassily', 'Russian', 1866, 1944);
INSERT INTO ARTIST
	(ArtistID, LastName, FirstName, Nationality, DateOfBirth, DateDeceased)
	VALUES (
	3, 'Klee', 'Paul', 'German', 1879, 1940);
INSERT INTO ARTIST
	(ArtistID, LastName, FirstName, Nationality, DateOfBirth, DateDeceased)
	VALUES (
	4, 'Matisse', 'Henri', 'French', 1869, 1954);
INSERT INTO ARTIST
	(ArtistID, LastName, FirstName, Nationality, DateOfBirth, DateDeceased)
	VALUES (
	5, 'Chagall', 'Marc', 'French', 1887, 1985);
INSERT INTO ARTIST
	(ArtistID, LastName, FirstName, Nationality, DateOfBirth, DateDeceased)
	VALUES (
	11, 'Sargent', 'John Singer', 'United States', 1856, 1925);
INSERT INTO ARTIST
	(ArtistID, LastName, FirstName, Nationality, DateOfBirth, DateDeceased)
	VALUES (
	17, 'Tobey', 'Mark', 'United States', 1890, 1976);
INSERT INTO ARTIST
	(ArtistID, LastName, FirstName, Nationality, DateOfBirth, DateDeceased)
	VALUES (
	18, 'Horiuchi', 'Paul', 'United States', 1906, 1999);
INSERT INTO ARTIST
	(ArtistID, LastName, FirstName, Nationality, DateOfBirth, DateDeceased)
	VALUES (
	19, 'Graves', 'Morris', 'United States', 1920, 2001);

/* Set AUTO_INCREMENT for the ARTIST table                                      */

ALTER TABLE WORK
		DROP FOREIGN KEY ArtistFK;

ALTER TABLE CUSTOMER_ARTIST_INT
		DROP FOREIGN KEY CAInt_ArtistFK;

ALTER TABLE ARTIST
  MODIFY COLUMN ArtistID INTEGER NOT NULL AUTO_INCREMENT;

ALTER TABLE ARTIST AUTO_INCREMENT = 20;

ALTER TABLE WORK 
		ADD CONSTRAINT ArtistFK FOREIGN KEY(ArtistID)
			REFERENCES ARTIST(ArtistID)
				ON UPDATE NO ACTION
				ON DELETE NO ACTION;

ALTER TABLE CUSTOMER_ARTIST_INT
		ADD CONSTRAINT CAInt_ArtistFK FOREIGN KEY (ArtistID)
			REFERENCES ARTIST(ArtistID)
				ON UPDATE NO ACTION
				ON DELETE CASCADE;

/********************************************************************************/

/*	INSERT data for CUSTOMER_ARTIST_INT											                    */

INSERT INTO CUSTOMER_ARTIST_INT VALUES (1, 1001);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (1, 1034);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (2, 1001);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (2, 1034);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (4, 1001);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (4, 1034);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (5, 1001);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (5, 1034);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (5, 1036);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (11, 1001);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (11, 1015);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (11, 1036);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (17, 1000);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (17, 1015);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (17, 1033);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (17, 1040);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (17, 1051);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (18, 1000);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (18, 1015);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (18, 1033);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (18, 1040);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (18, 1051);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (19, 1000);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (19, 1015);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (19, 1033);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (19, 1036);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (19, 1040);
INSERT INTO CUSTOMER_ARTIST_INT VALUES (19, 1051);

/********************************************************************************/

/*	INSERT data for WORK															                          */

INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	500, 'Memories IV', 'Unique', 'Casein rice paper collage', '31 x 24.8 in.', 18);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	511, 'Surf and Bird', '142/500', 'High Quality Limited Print',
	'Northwest School Expressionist style', 19);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	521, 'The Tilled Field', '788/1000', 'High Quality Limited Print',
	'Early Surrealist style', 1);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	522, 'La Lecon de Ski', '353/500', 'High Quality Limited Print',
	'Surrealist style', 1);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	523, 'On White II', '435/500', 'High Quality Limited Print',
	'Bauhaus style of Kandinsky', 2);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	524, 'Woman with a Hat', '596/750', 'High Quality Limited Print',
	'A very colorful Impressionist piece', 4);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	537, 'The Woven World', '17/750', 'Color lithograph', 'Signed', 17);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	548, 'Night Bird', 'Unique', 'Watercolor on Paper',
	'50 x 72.5 cm. - Signed', 19);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	551, 'Der Blaue Reiter', '236/1000', 'High Quality Limited Print',
	'The Blue Rider-Early Pointilism influence', 2);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	552, 'Angelus Novus', '659/750', 'High Quality Limited Print',
	'Bauhaus style of Klee', 3);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	553, 'The Dance', '734/1000', 'High Quality Limited Print',
	'An Impressionist masterpiece', 4);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	554, 'I and the Village', '834/1000', 'High Quality Limited Print',
	'Shows Belarusian folk-life themes and symbology', 5);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	555, 'Claude Monet Painting', '684/1000', 'High Quality Limited Print',
	'Shows French Impressionist influence of Monet', 11);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	561, 'Sunflower', 'Unique', 'Watercolor and ink',
	'33.3 x 16.1 cm. - Signed', 19);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	562, 'The Fiddler', '251/1000', 'High Quality Limited Print',
	'Shows Belarusian folk-life themes and symbology', 5);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	563, 'Spanish Dancer', '583/750', 'High Quality Limited Print',
	'American realist style - From work in Spain', 11);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	564, 'Farmer''s Market #2',	'267/500', 'High Quality Limited Print',
	'Northwest School Abstract Expressionist style', 17);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	565, 'Farmer''s Market #2',	'268/500', 'High Quality Limited Print',
	 'Northwest School Abstract Expressionist style', 17);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	566, 'Into Time', '323/500', 'High Quality Limited Print',
	'Northwest School Abstract Expressionist style', 18);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	570, 'Untitled Number 1', 'Unique', 'Monotype with tempera',
	'4.3 x 6.1 in. Signed', 17);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	571, 'Yellow Covers Blue', 'Unique', 'Oil and collage',
	'71 x 78 in. - Signed', 18);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	578, 'Mid-Century Hibernation', '362/500', 'High Quality Limited Print',
	'Northwest School Expressionist style', 19);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	580, 'Forms in Progress I', 'Unique', 'Color aquatint',
	'19.3 x 24.4 in. - Signed', 17);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	581, 'Forms in Progress II', 'Unique', 'Color aquatint',
	'19.3 x 24.4 in. - Signed', 17);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	585, 'The Fiddler', '252/1000', 'High Quality Limited Print',
	'Shows Belarusian folk-life themes and symbology', 5);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	586, 'Spanish Dancer', '588/750', 'High Quality Limited Print',
	'American Realist style - From work in Spain', 11);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	587, 'Broadway Boggie', '433/500', 'High Quality Limited Print',
	'Northwest School Abstract Expressionist style', 17);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	588, 'Universal Field', '114/500', 'High Quality Limited Print',
	'Northwest School Abstract Expressionist style', 17);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	589, 'Color Floating in Time', '487/500', 'High Quality Limited Print',
	'Northwest School Abstract Expressionist style', 18);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	590, 'Blue Interior', 'Unique', 'Tempera on card', '43.9 x 28 in.', 17);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	593, 'Surf and Bird', 'Unique', 'Gouache', '26.5 x 29.75 in. - Signed', 19);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	594, 'Surf and Bird', '362/500', 'High Quality Limited Print',
	'Northwest School Expressionist style', 19);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	595, 'Surf and Bird', '365/500', 'High Quality Limited Print',
	'Northwest School Expressionist style', 19);
INSERT INTO WORK (WorkID, Title, Copy, Medium, Description, ArtistID)
	VALUES (
	596, 'Surf and Bird', '366/500', 'High Quality Limited Print',
	'Northwest School Expressionist style', 19);

ALTER TABLE TRANS
		DROP FOREIGN KEY TransWorkFK;

ALTER TABLE WORK
  MODIFY COLUMN WorkID INTEGER NOT NULL AUTO_INCREMENT;

ALTER TABLE WORK AUTO_INCREMENT = 597;

ALTER TABLE TRANS
		ADD CONSTRAINT TransWorkFK FOREIGN KEY(WorkID)
			REFERENCES WORK(WorkID)
				ON UPDATE NO ACTION
				ON DELETE NO ACTION;

/********************************************************************************/

/*	INSERT data for TRANS	 													                            */

INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	100, '2009-11-04', 30000.00, 45000.00, '2009-12-14', 42500.00, 1000, 500);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	101, '2009-11-07', 250.00, 500.00, '2009-12-19', 500.00,	1015, 511);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	102, '2009-11-17', 125.00, 250.00, '2010-01-18', 200.00, 1001, 521);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	103, '2009-11-17', 250.00, 500.00, '2010-12-12', 400.00, 1034, 522);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	104, '2009-11-17', 250.00, 250.00, '2010-01-18', 200.00, 1001, 523);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	105, '2009-11-17', 200.00, 500.00, '2010-12-12', 400.00, 1034, 524);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	115, '2010-03-03', 1500.00, 3000.00, '2010-06-07', 2750.00, 1033, 537);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	121, '2010-09-21', 15000.00, 30000.00, '2010-11-28', 27500.00,	1015, 548);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	125, '2010-11-21', 125.00, 250.00, '2010-12-18', 200.00, 1001, 551);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, WorkID)
	VALUES (
	126, '2010-11-21', 200.00, 400.00, 552);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	127, '2010-11-21', 125.00, 500.00, '2010-12-22', 400.00, 1034, 553);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	128, '2010-11-21', 125.00, 250.00, '2011-03-16', 225.00, 1036, 554);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	129, '2010-11-21', 125.00, 250.00, '2011-03-16', 225.00, 1036, 555);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	151, '2011-05-07', 10000.00, 20000.00, '2011-06-28', 17500.00, 1036, 561);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	152, '2011-05-18', 125.00, 250.00, '2011-08-15', 225.00, 1001, 562);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	153, '2011-05-18', 200.00, 400.00, '2011-08-15', 350.00, 1001, 563);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	154, '2011-05-18', 250.00, 500.00, '2011-09-28', 400.00, 1040, 564);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, WorkID)
	VALUES (
	155, '2011-05-18', 250.00, 500.00, 565);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	156, '2011-05-18', 250.00, 500.00, '2011-09-27', 400.00, 1040, 566);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	161, '2011-06-28', 7500.00, 15000.00, '2011-09-29', 13750.00, 1033, 570);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	171, '2011-08-23', 35000.00, 60000.00, '2011-09-29', 55000.00, 1000, 571);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	175, '2011-08-23', 40000.00, 75000.00, '2011-12-18', 72500.00, 1036, 500);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, WorkID)
	VALUES (
	181, '2011-10-11', 250.00, 500.00, 578);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	201, '2012-02-28', 2000.00, 3500.00, '2012-04-26', 3250.00,	1040, 580);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	202, '2012-02-28', 2000.00, 3500.00, '2012-04-26', 3250.00, 1040, 581);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	225, '2012-06-08', 125.00, 250.00, '2012-09-27', 225.00, 1051, 585);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, WorkID)
	VALUES (
	226, '2012-06-08', 200.00, 400.00, 586);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	227, '2012-06-08', 250.00, 500.00, '2012-09-27', 475.00, 1051, 587);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, WorkID)
	VALUES (
	228, '2012-06-08', 250.00, 500.00, 588);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, WorkID)
	VALUES (
	229, '2012-06-08', 250.00, 500.00, 589);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, DateSold, SalesPrice, CustomerID, WorkID)
	VALUES (
	241, '2012-08-29', 2500.00, 5000.00, '2012-09-27', 4750.00,	1015, 590);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, WorkID)
	VALUES (
	251, '2012-10-25', 25000.00, 50000.00, 593);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, WorkID)
	VALUES (
	252, '2012-10-27', 250.00, 500.00, 594);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, WorkID)
	VALUES (
	253, '2012-10-27', 250.00, 500.00, 595);
INSERT INTO TRANS (TransactionID, DateAcquired, AcquisitionPrice,
	AskingPrice, WorkID)
	VALUES (
	254, '2012-10-27', 250.00, 500.00, 596);

/* Set AUTO_INCREMENT for the TRANS table                                       */

ALTER TABLE TRANS
  MODIFY COLUMN TransactionID INTEGER NOT NULL AUTO_INCREMENT;

ALTER TABLE TRANS AUTO_INCREMENT = 255;

/********************************************************************************/


SELECT * FROM ARTIST;

SELECT * FROM CUSTOMER;

SELECT * FROM CUSTOMER_ARTIST_INT;

SELECT * FROM WORK;

SELECT * FROM TRANS;



/********************************************************************************/
/*											                                 	*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 10C     		*/
/*																				*/
/*	The VRG-CH10C-PQ Database - Stored Procedure InsertNewArtist			    */
/*																				*/
/*	These are the MySQL 5.6 SQL code solutions for 10C.36.E				                    */
/*																				*/
/********************************************************************************/


DELIMITER //

CREATE PROCEDURE InsertNewArtist
			(IN newLastName		Char(25),
			 IN newFirstName		Char(25),
			 IN newNationality	Char(30),
			 IN newDateOfBirth	Numeric(4),
			 IN newDateDeceased	Numeric(4)
			)

BEGIN

	DECLARE	varRowCount		Int;

	# Check to see if Artist already exists in database
	SELECT		varRowCount = COUNT(*)
	FROM		ARTIST
	WHERE		LastName = newLastName
		AND		FirstName = newFirstName;


	# IF varRowCount > 0 THEN ARTIST already exists.
	IF (varRowCount > 0)
		THEN
			ROLLBACK;
			SELECT 'Customer already exists'
				AS InsertNewArtistErrorMessage;
		END IF;

	# varRowCount = 0 therefore ARTIST does not exist.
	# Insert new ARTIST data.
	INSERT INTO ARTIST
		(LastName, FirstName, Nationality, DateOfBirth, DateDeceased)
		VALUES
		(newLastName, newFirstName, newNationality, newDateOfBirth,
		 newDateDeceased);

	SELECT 'New ARTIST data added to database.'
		AS InsertNewArtistResults;

END
//
DELIMITER ;

/*  Test data  -->                                                                  */

 CALL InsertNewArtist ('Ernst', 'Max', 'German', 1891, 1976);       

 CALL InsertNewArtist ('Alder', 'Jankel', 'German', 1895, 1949);   

 SELECT * FROM ARTIST;


/********************************************************************************/
/*											                                 	*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 10C     		*/
/*																				*/
/*	The VRG-CH10C-PQ Database - Stored Procedure InsertNewArtistAndWork		    */
/*																				*/
/*	These are the MySQL 5.6 SQL code solutions	for 10C.36.F                    */
/*																				*/
/********************************************************************************/


DELIMITER //

CREATE PROCEDURE InsertNewArtistAndWork
			(IN newLastName		Char(25),
			 IN newFirstName		Char(25),
			 IN newNationality	Char(30),
			 IN newDateOfBirth	Numeric(4),
			 IN newDateDeceased	Numeric(4),
			 IN newTitle			Char(35),
			 IN newCopy 			Char(12),
			 IN newMedium			Char(35),
			 IN newDescription	Varchar(1000))

BEGIN

	DECLARE	varRowCount		Int;
	DECLARE	varArtistID		Int;

	# Check to see if Artist already exists in database
	SELECT	COUNT(*) INTO varRowCount
	FROM		ARTIST
	WHERE		LastName = newLastName
		AND		FirstName = newFirstName;

	# IF varRowCount > 0 THEN ARTIST already exists.
	IF (varRowCount > 0)
		THEN
			ROLLBACK;
			SELECT 'Artist already exists'
				AS InsertNewArtistErrorMessage;
		END IF;

	# varRowCount = 0 therefore ARTIST does not exist.
	# Insert new ARTIST data.
	INSERT INTO ARTIST
		(LastName, FirstName, Nationality, DateOfBirth, DateDeceased)
		VALUES
		(newLastName, newFirstName, newNationality, newDateOfBirth,
		 newDateDeceased);

  COMMIT;

	SELECT 'New ARTIST data added to database.'
		AS InsertNewArtistResults;

	# Get new ARTIST ArtistID

	SELECT ArtistID INTO varArtistID
	FROM	ARTIST
	WHERE		LastName = newLastName
		AND		FirstName = newFirstName;

	# Insert new WORK data.
	INSERT INTO WORK
		(Title, Copy, Medium, Description, ArtistID)
		VALUES
		(newTitle, newCopy, newMedium, newDescription, varArtistID);

END
//

DELIMITER ;


# Test data -->                                                                

 CALL InsertNewArtistAndWork ('Monet', 'Claude', 'French', 1840, 1926,
	'Water Lilies - 1907', '567/1000', 'High Quality Limited Print', 
	'French Impressionist');

 
 CALL InsertNewArtistAndWork ('van Gogh', 'Vincent', 'French', 1853, 1890, 
	'Cypresses', '678/1000', 'High Quality Limited Print', 
	'Dutch Post-impressionist');


SELECT * FROM ARTIST;

SELECT * FROM WORK;



/********************************************************************************/
/*											                                 	*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 10C     		*/
/*																				*/
/*	The VRG-CH10C-PQ Database - Stored Procedure UpdatePhone       			    */
/*																				*/
/*	These are the MySQL 5.6 SQL code solutions	for 10C.36.G	                */
/*																				*/
/********************************************************************************/

DELIMITER //

CREATE PROCEDURE UpdatePhone
	(IN CustomerLastName	  Char(25),
	 IN CustomerFirstName	 Char(25),
	 IN priorAreaCode		   Char(3),
	 IN priorPhoneNumber		Char(8),
	 IN newAreaCode			 	Char(3),
	 IN newPhoneNumber			Char(8))

BEGIN

	DECLARE  recCount				  Int;
	DECLARE  readCustomerID		Int;

	/* Check to see if the customer is in the database */

	SELECT COUNT(*) INTO recCount
		FROM 	 CUSTOMER AS C
		WHERE 	C.LastName = CustomerLastName
			AND	 C.FirstName = CustomerFirstName
		  AND 	C.AreaCode = priorAreaCode
	  	AND 	C.PhoneNumber = priorPhoneNumber;

	IF (recCount = 0)
		THEN
			ROLLBACK;
			SELECT 'Customer does not exist.'
				AS UpdatePhoneErrorMessage;
		END IF;

	/* Customer exists, so update phone number */

	SELECT CustomerID INTO readCustomerID
		FROM 		CUSTOMER AS C
		WHERE 		C.LastName = CustomerLastName
			AND		C.FirstName = CustomerFirstName
		   AND 	C.AreaCode = priorAreaCode
	  	   AND 	C.PhoneNumber = priorPhoneNumber;

	UPDATE CUSTOMER
		SET AreaCode = newAreaCode
		WHERE CustomerID = readCustomerID;

	UPDATE CUSTOMER
		SET PhoneNumber = newPhoneNumber
		WHERE CustomerID = readCustomerID;

	SELECT 'Customer phone number updated'
		AS UpdatePhoneResults;

END;
//

Delimiter ;

# Test data --> 

  CALL UpdatePhone ('Twilight', 'Tiffany', '260', '876-1122', '206', '876-1133');

# this next line will generate an error message, customer does not exist
 CALL UpdatePhone ('Joockson', 'Samuel', '460', '865-5566', '306', '976-1122');

 SELECT  CustomerID, LastName, FirstName, AreaCode, PhoneNumber
  FROM    CUSTOMER;
 
# drop procedure UpdatePhone;


/********************************************************************************/
/*											                                 	*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 10C     		*/
/*																				*/
/*	The VRG-CH10C-PQ Database - Create ALLOWED_NATIONALITY Table - Insert Data  */
/*																				*/
/*	These are the MySQL 5.6 SQL code solutions for 10C.36.H	                    */
/*																				*/
/********************************************************************************/

CREATE TABLE ALLOWED_NATIONALITY(
	Nation			Char(30) 					 NOT NULL,
	CONSTRAINT 	Allowed_Nationality_PK 	PRIMARY KEY(Nation)
	);


INSERT INTO ALLOWED_NATIONALITY VALUES('Canadian');
INSERT INTO ALLOWED_NATIONALITY VALUES('English');
INSERT INTO ALLOWED_NATIONALITY VALUES('French');
INSERT INTO ALLOWED_NATIONALITY VALUES('German');
INSERT INTO ALLOWED_NATIONALITY VALUES('Mexican');
INSERT INTO ALLOWED_NATIONALITY VALUES('Russian');
INSERT INTO ALLOWED_NATIONALITY VALUES('Spanish');
INSERT INTO ALLOWED_NATIONALITY VALUES('United States');

SELECT * FROM ALLOWED_NATIONALITY;



/********************************************************************************/
/*											                                 	*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 10C     		*/
/*																				*/
/*	The VRG-CH10C-PQ Database - 												*/
/*                Stored Procedure InsertNewArtistCheckNationality              */
/*																				*/
/*	These are the MySQL 5.6 SQL code solutions for 10C.36.H second part         */
/*																				*/
/********************************************************************************/

DELIMITER //

CREATE PROCEDURE InsertNewArtistCheckNationality
			(IN newLastName		  Char(25),
			 IN newFirstName		Char(25),
			 IN newNationality	Char(30),
			 IN newDateOfBirth	Numeric(4),
			 IN newDateDeceased	Numeric(4))

spicwt:BEGIN

	DECLARE	varRowCount		  Int;
	DECLARE	VarANRowCount		Int;

	# Check to see if ARTIST NATIONALITY is Allowed.
    
	SELECT	COUNT(*) INTO varANRowCount
	FROM		ALLOWED_NATIONALITY
	WHERE		Nation = newNationality;

	# IF varANRowCount = 0 THEN ARTIST NATIONALITY is NOT allowed.
	IF (varANRowCount = 0) THEN
			ROLLBACK;
			SELECT 'ARTIST Nationality is NOT allowed.'
				AS InsertNewArtistCheckNationalityErrorMessage;
       LEAVE spicwt;
    END IF;

	# Check to see if Artist already exists in database
	SELECT	COUNT(*) INTO varRowCount
	FROM		ARTIST
	WHERE		LastName = newLastName
		AND		FirstName = newFirstName;

	# IF varRowCount > 0 THEN ARTIST already exists.
	IF (varRowCount > 0)
		THEN
			ROLLBACK;
			SELECT 'Artist already exists'
				AS InsertNewArtistCheckNationalityErrorMessage;
     END IF;

	# varRowCount = 0 therefore ARTIST does not exist.
	# Insert new Customer data.
  IF (varRowCount = 0)
		THEN
      INSERT INTO ARTIST
		  (LastName, FirstName, Nationality, DateOfBirth, DateDeceased)
		  VALUES
		  (newLastName, newFirstName, newNationality, newDateOfBirth,
		   newDateDeceased);

    SELECT 'New ARTIST data added to database.'
		  AS InsertNewArtistResults;
    END IF;

END spicwt;

//
DELIMITER ;


# Test data --> 

 CALL InsertNewArtistCheckNationality 
    ('Oiticica', 'Helio', 'Brazilian', 1937, 1980);
 

CALL InsertNewArtistCheckNationality
   ('Callahan', 'Kenneth', 'United States', 1905, 1986);
 
 
SELECT * FROM ARTIST;

select * from ALLOWED_NATIONALITY;



/********************************************************************************/
/*											                                 	*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 10C     		*/
/*																				*/
/*	The VRG-CH10C-PQ Database - Create WorkAndTransView							*/
/*																				*/
/*	These are the MySQL 5.6 SQL code solutions for 10C-36-I         			*/
/*																				*/
/********************************************************************************/

CREATE VIEW WorkAndTransView AS
	SELECT   W.Title, W.Copy, W.Medium, W.Description, W.ArtistID,
           T.DateAcquired, T.AcquisitionPrice, T.DateSold,
			     T.AskingPrice, T.SalesPrice, T.CustomerID
	FROM 	   WORK AS W, TRANS AS T
	WHERE	   W.WorkID = T.WorkID;

# To test the view, use -->

SELECT *    FROM WorkAndTransView
ORDER BY    Title, Copy;     

/********************************************************************************/
/*											                                 	*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 10C     		*/
/*																				*/
/*	The VRG-CH10C-PQ Database - 												*/
/*                Stored Procedure Create InsertWorkWithTransaction             */
/*																				*/
/*	These are the MySQL 5.6 SQL code solutions for 10C-36-I part 2              */
/*																				*/
/********************************************************************************/

DELIMITER //

CREATE PROCEDURE InsertWorkWithTransaction
      (IN    WorkTitle             Char(35),
			 IN		WorkCopy					     Char(12),
			 IN		WorkMedium				     Char(35),
			 IN		WorkDescription 		 	 Varchar(1000),
			 IN		WorkArtistID 				   Int,
			 IN		TransDateAcquired		   Datetime,
			 IN		TransAcquisitionPrice  Numeric(8,2),
			 IN		TransDateSold				   Datetime,
			 IN		TransAskingPrice 		   Numeric(8,2),
 			 IN		TransSalesPrice 			 Numeric(8,2),
 			 IN		TransCustomerID 			 Int)

BEGIN

	DECLARE	varRowCount			  Int;
	DECLARE	varArtistID			  Int;
	DECLARE	varCustomerID			Int;
	DECLARE	varWorkID				  Int;
	DECLARE	varTransactionID	 Int;

	# Check to see if WORK already exists in database

	SELECT	COUNT(*) INTO varRowCount
	FROM		WORK
	WHERE	  Title = WorkTitle
		AND	  Copy = WorkCopy;

	# IF varRowCount > 0 THEN WORK already exists.
	IF (varRowCount > 0)
		THEN
		SELECT  'WORK already exists'
			AS     InsertWorkWithTransactionErrorMessage;
		ROLLBACK;
	END IF;

	# IF varRowCount = 0 THEN WORK does not exist in database.

	IF (varRowCount = 0)
		THEN
	# Insert new WORK data.
	  INSERT INTO WORK (Title, Copy, Medium, Description, ArtistID)
		  VALUES
      (WorkTitle, WorkCopy, WorkMedium, WorkDescription, WorkArtistID);

  	SET varWorkID = LAST_INSERT_ID();

    /* This is an alternate for:
     * SELECT	WorkID INTO varWorkID
	   * FROM		WORK
     * WHERE	 Title = WorkTitle
		 *   AND	 Copy = WorkCopy;
     */

  	# Insert new TRANS data.
	  INSERT INTO TRANS (DateAcquired, AcquisitionPrice, DateSold,
      AskingPrice, SalesPrice, CustomerID, WorkID)
		  VALUES(TransDateAcquired, TransAcquisitionPrice,
             TransDateSold, TransAskingPrice, TransSalesPrice,
             TransCustomerID, varWorkID);

	# The transaction is completed. Print message
	  SELECT 'The new WORK and transaction are now in the database.'
	  	AS InsertWorkWithTransactionResults;
	END IF;
END;
//

DELIMITER ;

# To test the stored precedure, use -->

CALL InsertWorkWithTransaction
    ('Yak', '549/1000', 'High quality reproduction',
     'Original was ink on paper, 15 x 17 inches', 21,
     '2011-02-10', 250, '2011-02-13', 500.00, 450.00, 1036);


SELECT *    FROM WorkAndTransView
 ORDER BY    Title, Copy;          
     
 /********************************************************************************/
/*											                                 	*/
/*	Kroenke and Auer - Database Processing (14th Edition) Chapter 10C     		*/
/*	10C.36.J																	*/
/*	The VRG-CH10C-PQ Database - Create WorkAndTransView							*/
/*																				*/
/*	These are the MySQL 5.6 SQL code solutions				                    */
/*																				*/
/********************************************************************************/

CREATE VIEW WorkAndTransView AS
	SELECT   W.Title, W.Copy, W.Medium, W.Description, W.ArtistID,
           T.DateAcquired, T.AcquisitionPrice, T.DateSold,
			     T.AskingPrice, T.SalesPrice, T.CustomerID
	FROM 	   WORK AS W, TRANS AS T
	WHERE	   W.WorkID = T.WorkID;

# To test the view, use -->

SELECT *    FROM WorkAndTransView
ORDER BY    Title, Copy;     








    
     
     
     
     
     
     
     
     
     
     
     
     
     
     




































































































