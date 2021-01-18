DROP DATABASE IF EXISTS optica;
CREATE DATABASE optica CHARACTER SET utf8mb4;
USE optica;

CREATE TABLE Customer(
	idCustomer INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(45) NOT NULL,
	Lastname1 VARCHAR(45) NOT NULL,
	Lastname2 VARCHAR(45) NOT NULL,
	Address VARCHAR(45) NOT NULL,
	City VARCHAR(45) NOT NULL,
	PostalCode VARCHAR(45) NOT NULL,
	RegisterDate DATE NOT NULL,
	PRIMARY KEY (idCustomer)
);

CREATE TABLE Provider(
	idProvider INT NOT NULL AUTO_INCREMENT,
	CompanyName VARCHAR(45) NOT NULL,
	Address VARCHAR(45) NOT NULL,
	City VARCHAR(45) NOT NULL,
	Country VARCHAR(45) NOT NULL,
	PostalCode VARCHAR(45) NOT NULL,
	Phone VARCHAR(45) NOT NULL,
	Fax VARCHAR(45) NOT NULL,
	NIF VARCHAR(45) NOT NULL,
	PRIMARY KEY (idProvider)
);

CREATE TABLE Employee(
	idEmployee INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(45) NOT NULL,
	Lastname1 VARCHAR(45) NOT NULL,
	Lastname2 VARCHAR(45) NOT NULL,
	PRIMARY KEY (idEmployee)
);

CREATE TABLE Brand(
	idBrand INT NOT NULL AUTO_INCREMENT,
	id_Provider INT NOT NULL,
	BrandName VARCHAR(45) NOT NULL,
	PRIMARY KEY (idBrand),
	FOREIGN KEY (id_Provider) REFERENCES Provider(idProvider)
);

CREATE TABLE Catalog(
	idCatalog INT NOT NULL AUTO_INCREMENT,
	id_Brand INT NOT NULL,
	id_Provider INT NOT NULL,
	CatalogName VARCHAR(45) NOT NULL,
	PRIMARY KEY (idCatalog), 
	FOREIGN KEY (id_Brand) REFERENCES Brand(idBrand),
	FOREIGN KEY (id_Provider) REFERENCES Provider(idProvider)
);

CREATE TABLE Personalization(
	idPersonalization INT NOT NULL AUTO_INCREMENT,
	id_Customer INT NOT NULL,
	id_Catalog INT NOT NULL,
	PrescriptionRight VARCHAR(45) NOT NULL,
	PrescriptionLeft VARCHAR(45)NOT NULL,
	Frame VARCHAR(45) NOT NULL,
	FrameColour VARCHAR(45) NOT NULL,
	GlassColourRight VARCHAR(45) NOT NULL,
	GlassColourLeft VARCHAR(45) NOT NULL,
	Price DECIMAL NOT NULL,
	PersonalizationDate DATE NOT NULL,
	PRIMARY KEY (idPersonalization),
	FOREIGN KEY (id_Customer) REFERENCES Customer(idCustomer),
	FOREIGN KEY (id_Catalog) REFERENCES Catalog(idCatalog)
);

CREATE TABLE Invoice(
	idInvoice INT NOT NULL AUTO_INCREMENT,
	id_Personalization INT NOT NULL,
	id_Customer INT NOT NULL,
	id_Employee INT NOT NULL,
	InvoiceHash VARCHAR(45) NOT NULL,
	PurchaseDate VARCHAR(45) NOT NULL,
	PRIMARY KEY (idInvoice),
	FOREIGN KEY (id_Personalization) REFERENCES Personalization(idPersonalization),
	FOREIGN KEY (id_Customer) REFERENCES Customer(idCustomer),
	FOREIGN KEY (id_Employee) REFERENCES Employee(idEmployee)
);

CREATE TABLE Recommendation(
	idRecommendation INT NOT NULL AUTO_INCREMENT,
	id_Recommended INT NOT NULL,
	id_Recommender INT NOT NULL,
	PRIMARY KEY (idRecommendation),
	FOREIGN KEY (id_Recommended) REFERENCES Customer(idCustomer),
	FOREIGN KEY (id_Recommender) REFERENCES Customer(idCustomer)
);
