DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
USE pizzeria;

CREATE TABLE Province(
	idProvince INT NOT NULL AUTO_INCREMENT,
	ProvinceName VARCHAR(45) NOT NULL,
    Created TIMESTAMP,
	PRIMARY KEY (idProvince)
);

CREATE TABLE City(
	idCity INT NOT NULL AUTO_INCREMENT,
	CityName VARCHAR(45) NOT NULL,
    Created TIMESTAMP,
	PRIMARY KEY (idCity)
);

CREATE TABLE PostalCode(
	idPostalCode INT NOT NULL AUTO_INCREMENT,
	PostalCode VARCHAR(45) NOT NULL,
    id_City INT NOT NULL,
    id_Province INT NOT NULL,
    Created TIMESTAMP,
	PRIMARY KEY (idPostalCode),
    FOREIGN KEY (id_City) REFERENCES City(idCity),
    FOREIGN KEY (id_Province) REFERENCES Province(idProvince)
);

CREATE TABLE Customer(
	idCustomer INT NOT NULL AUTO_INCREMENT,
	Name VARCHAR(45) NOT NULL,
	Lastname1 VARCHAR(45) NOT NULL,
	Lastname2 VARCHAR(45) NOT NULL,
	Address VARCHAR(45) NOT NULL,
    id_PostalCode INT NOT NULL,
	Created TIMESTAMP,
	PRIMARY KEY (idCustomer),
    FOREIGN KEY (id_PostalCode) REFERENCES PostalCode(idPostalCode)
);

CREATE TABLE Shop(
	idShop INT NOT NULL AUTO_INCREMENT,
	Address VARCHAR(45) NOT NULL,
    id_PostalCode INT NOT NULL,
	Created TIMESTAMP,
	PRIMARY KEY (idShop),
    FOREIGN KEY (id_PostalCode) REFERENCES PostalCode(idPostalCode)
);

CREATE TABLE EmployeeRole(
	idRole INT NOT NULL AUTO_INCREMENT,
    RoleName VARCHAR(45) NOT NULL,
    Created TIMESTAMP,
	PRIMARY KEY (idRole)
);

CREATE TABLE Employee(
	idEmployee INT NOT NULL AUTO_INCREMENT,
    id_Role INT NOT NULL,
    id_Shop INT NOT NULL,
	Name VARCHAR(45) NOT NULL,
	Lastname1 VARCHAR(45) NOT NULL,
	Lastname2 VARCHAR(45) NOT NULL,
    NIF VARCHAR(45) NOT NULL,
    Created TIMESTAMP,
	PRIMARY KEY (idEmployee),
    FOREIGN KEY (id_Role) REFERENCES EmployeeRole(idRole),
    FOREIGN KEY (id_Shop) REFERENCES Shop(idShop)
);

CREATE TABLE Product(
	idProduct INT NOT NULL AUTO_INCREMENT,
	ProductName INT NOT NULL,
    Price DECIMAL NOT NULL,
	Created TIMESTAMP,
	PRIMARY KEY (idProduct)
);

CREATE TABLE Categoria(
	idCategoria INT NOT NULL AUTO_INCREMENT,
	CategoriaName INT NOT NULL,
	Created TIMESTAMP,
	PRIMARY KEY (idCategoria)
);

CREATE TABLE Pizza(
	idPizza INT NOT NULL AUTO_INCREMENT,
    PizzaName VARCHAR(45) NOT NULL,
    Ingredients VARCHAR(45) NOT NULL,
    id_Product INT NOT NULL,
    id_Categoria INT NOT NULL,
    Created TIMESTAMP,
	PRIMARY KEY (idPizza),
    FOREIGN KEY (id_Product) REFERENCES Product(idProduct),
    FOREIGN KEY (id_Categoria) REFERENCES Categoria(idCategoria)
);

CREATE TABLE HistoricoPizzaCategoria(
	idHistorico INT NOT NULL AUTO_INCREMENT,
    id_Pizza INT NOT NULL,
	id_Categoria INT NOT NULL,
    FechaIni DATETIME,
    FechaFin DATETIME,
    Created TIMESTAMP,
	PRIMARY KEY (idHistorico),
    FOREIGN KEY (id_Pizza) REFERENCES Pizza(idPizza),
    FOREIGN KEY (id_Categoria) REFERENCES Categoria(idCategoria)
);

CREATE TABLE Invoice(
	idInvoice INT NOT NULL AUTO_INCREMENT,
    id_Customer INT NOT NULL,
    id_Shop INT NOT NULL,
    Created TIMESTAMP,
    PRIMARY KEY (idInvoice),
	FOREIGN KEY (id_Shop) REFERENCES Shop(idShop),
    FOREIGN KEY (id_Customer) REFERENCES Customer(idCustomer)
);

CREATE TABLE OrderItem(
	idItem INT NOT NULL AUTO_INCREMENT,
    id_Invoice INT NOT NULL,
    id_Product INT NOT NULL,
    Created TIMESTAMP,
    PRIMARY KEY (idItem),
    FOREIGN KEY (id_Invoice) REFERENCES Invoice(idInvoice),
    FOREIGN KEY (id_Product) REFERENCES Product(idProduct)
);

CREATE TABLE Delivery(
	idDelivery INT NOT NULL AUTO_INCREMENT,
    id_Invoice INT NOT NULL,
    id_Customer INT NOT NULL,
    id_Employee INT NOT NULL,
    Created TIMESTAMP,
    PRIMARY KEY(idDelivery),
    FOREIGN KEY (id_Invoice) REFERENCES Invoice(idInvoice),
    FOREIGN KEY (id_Customer) REFERENCES Customer(idCustomer),
    FOREIGN KEY (id_Employee) REFERENCES Employee(idEmployee)
);