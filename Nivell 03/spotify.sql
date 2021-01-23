-- DATABASE SPOTIFY: Base de datos que recoge usuarios, contenidos e interacciones de esta red social.
-- COMENTARIOS:
-- Todas las tablas incluyen un TIMESTAMP para poder trazar la fecha de grabación de cada registro.
-- Las estructura de tablas se basa en los criterios de: (1) mínimo contenido y (2) relación entre tablas.
-- Motivo: es más eficiente recorrer las tablas hacia abajo que hacia la derecha.
-- Requisito: asegurarnos que los JOIN serán ágiles basados en FOREIGN KEYS de tipo ID.

DROP DATABASE IF EXISTS spotify;
CREATE DATABASE spotify CHARACTER SET utf8mb4;
USE spotify;

CREATE TABLE UserType(
	idUserType INT NOT NULL AUTO_INCREMENT,
    UserTypeName VARCHAR(45) NOT NULL,
    Created TIMESTAMP,
    PRIMARY KEY (idUserType)
);

CREATE TABLE User(
	idUser INT NOT NULL AUTO_INCREMENT,
	Email VARCHAR(45) NOT NULL,
	Password VARCHAR(128) NOT NULL,
    Username VARCHAR(45) NOT NULL,
	Birthdate DATE NOT NULL,
    Gender VARCHAR(45) NOT NULL,
    Country VARCHAR(45) NOT NULL,
    PostalCode VARCHAR(45) NOT NULL,
    id_UserType INT NOT NULL,
	Created TIMESTAMP,
	PRIMARY KEY (idUser),
    FOREIGN KEY (id_UserType) REFERENCES UserType(idUserType)
);

CREATE TABLE Artist(
	idArtist INT NOT NULL AUTO_INCREMENT,
    ArtistName VARCHAR(128),
    ArtistPic VARCHAR(128),
    Created TIMESTAMP,
	PRIMARY KEY (idArtist)
);

CREATE TABLE Album(
	idAlbum INT NOT NULL AUTO_INCREMENT,
    id_Artist INT NULL,
    AlbumName VARCHAR(128) NOT NULL,
    AlbumPic VARCHAR(128),
    Created TIMESTAMP,
    PRIMARY KEY (idAlbum),
    FOREIGN KEY (id_Artist) REFERENCES Artist(idArtist)
);

CREATE TABLE Song(
	idSong INT NOT NULL AUTO_INCREMENT,
    id_Album INT NOT NULL,
    SongName VARCHAR(128),
    Song TIME,
    Created TIMESTAMP,
	PRIMARY KEY (idSong),
	FOREIGN KEY (id_Album) REFERENCES Album(idAlbum)
);

CREATE TABLE FavouriteSong(
	idFavouriteSong INT NOT NULL AUTO_INCREMENT,
    id_User INT NOT NULL,
    id_Song INT NOT NULL,
    Created TIMESTAMP,
    PRIMARY KEY (idFavouriteSong),
    FOREIGN KEY (id_User) REFERENCES User(idUser),
    FOREIGN KEY (id_Song) REFERENCES SONG(idSong)
);

CREATE TABLE FavouriteAlbum(
	idFavouriteAlbum INT NOT NULL AUTO_INCREMENT,
    id_User INT NOT NULL,
    id_Album INT NOT NULL,
    Created TIMESTAMP,
    PRIMARY KEY (idFavouriteAlbum),
    FOREIGN KEY (id_User) REFERENCES User(idUser),
    FOREIGN KEY (id_Album) REFERENCES Album(idAlbum)
);

CREATE TABLE FollowingArtist(
	idFollowingArtist INT NOT NULL AUTO_INCREMENT,
    id_User INT NOT NULL,
    id_Artist INT NOT NULL,
    Created TIMESTAMP,
    PRIMARY KEY (idFollowingArtist),
    FOREIGN KEY (id_User) REFERENCES User(idUser),
    FOREIGN KEY (id_Artist) REFERENCES Artist(idArtist)
);

CREATE TABLE RelatedArtist(
	idRelatedArtist INT NOT NULL AUTO_INCREMENT,
    id_Artist INT NOT NULL,
    RelatedArtist INT NOT NULL,
    Created DATETIME,
	PRIMARY KEY (idRelatedArtist),
    FOREIGN KEY (id_Artist) REFERENCES Artist(idArtist)
);

CREATE TABLE PaymentMethod(
	idPaymentMethod INT NOT NULL AUTO_INCREMENT,
    PaymentMethodName VARCHAR(45),
    Created TIMESTAMP,
    PRIMARY KEY (idPaymentMethod)
);

CREATE TABLE PaymentPayPalData(
	idPaymentPayPalData INT NOT NULL AUTO_INCREMENT,
    id_User INT NOT NULL,
    PaypalUsername VARCHAR(45),
    Created TIMESTAMP,
    PRIMARY KEY (idPaymentPayPalData),
    FOREIGN KEY (id_User) REFERENCES User(idUser)
);

CREATE TABLE PaymentCardData(
	idPaymentCardData INT NOT NULL AUTO_INCREMENT,
    id_User INT NOT NULL,
    CardNumber VARCHAR(45) NOT NULL,
    CardExpirationMonth VARCHAR(45) NOT NULL,
    CardExpirationYear VARCHAR(45) NOT NULL,
    CardSecurityCode VARCHAR(45) NOT NULL,
    Created TIMESTAMP,
    PRIMARY KEY (idPaymentCardData),
    FOREIGN KEY (id_User) REFERENCES User(idUser)
);

CREATE TABLE Subscription(
	idSubscription INT NOT NULL AUTO_INCREMENT,
    id_User INT NOT NULL,
	DateStart DATETIME,
    DateRenovation DATETIME,
    id_PaymentMethod INT NOT NULL,
    Created TIMESTAMP,
    PRIMARY KEY (idSubscription),
    FOREIGN KEY (id_User) REFERENCES User(idUser),
    FOREIGN KEY (id_PaymentMethod) REFERENCES PaymentMethod(idPaymentMethod)
);

CREATE TABLE SubscriptionPayment(
	idSubscriptionPayment INT NOT NULL AUTO_INCREMENT,
    id_Subscription INT NOT NULL,
    Created TIMESTAMP,
    PRIMARY KEY (idSubscriptionPayment),
    FOREIGN KEY (id_Subscription) REFERENCES Subscription(idSubscription)
);

CREATE TABLE Playlist(
	idPlaylist INT NOT NULL AUTO_INCREMENT,
	id_User INT NOT NULL,
    idPlaylistName VARCHAR(45) NOT NULL,
	Created TIMESTAMP,
	PRIMARY KEY (idPlaylist),
	FOREIGN KEY (id_User) REFERENCES User(idUser)
);

CREATE TABLE PlaylistVisibility(
	idPlaylistVisibility INT NOT NULL AUTO_INCREMENT,
    id_Playlist INT NOT NULL,
    PlaylistState BOOL,
    Created TIMESTAMP,
    PRIMARY KEY (idPlaylistVisibility),
    FOREIGN KEY (id_Playlist) REFERENCES Playlist(idPlaylist)
);

CREATE TABLE PlaylistSong(
	idPlaylistSong INT NOT NULL AUTO_INCREMENT,
    id_Playlist INT NOT NULL,
    id_Song INT NOT NULL,
    Created TIMESTAMP,
    PRIMARY KEY (idPlaylistSong),
    FOREIGN KEY (id_Playlist) REFERENCES Playlist(idPlaylist),
	FOREIGN KEY (id_Song) REFERENCES Song(idSong)
);

CREATE TABLE PlaylistContribution(
	idPlaylistContribution INT NOT NULL AUTO_INCREMENT,
    id_Playlist INT NOT NULL,
    id_User INT NOT NULL,
    id_Song INT NOT NULL,
    Created TIMESTAMP,
    PRIMARY KEY (idPlaylistContribution),
    FOREIGN KEY (id_User) REFERENCES User(idUser),
    FOREIGN KEY (id_Playlist) REFERENCES Playlist(idPlaylist),
	FOREIGN KEY (id_Song) REFERENCES Song(idSong)
);
