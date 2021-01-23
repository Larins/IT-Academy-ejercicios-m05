-- DATABASE YOUTUBE: Base de datos que recoge usuarios, contenidos e interacciones de esta red social.
-- COMENTARIOS:
-- Todas las tablas incluyen un TIMESTAMP para poder trazar la fecha de grabación de cada registro.
-- Las estructura de tablas se basa en los criterios de: (1) mínimo contenido y (2) relación entre tablas.
-- Motivo: es más eficiente recorrer las tablas hacia abajo que hacia la derecha.
-- Requisito: asegurarnos que los JOIN serán ágiles basados en FOREIGN KEYS de tipo ID.

DROP DATABASE IF EXISTS youtube;
CREATE DATABASE youtube CHARACTER SET utf8mb4;
USE youtube;

CREATE TABLE User(
	idUser INT NOT NULL AUTO_INCREMENT,
	Email VARCHAR(45) NOT NULL,
	Password VARCHAR(128) NOT NULL,
    Username VARCHAR(45) NOT NULL,
	Birthdate DATE NOT NULL,
    Gender VARCHAR(45) NOT NULL,
    Country VARCHAR(45) NOT NULL,
    PostalCode VARCHAR(45) NOT NULL,
	Created TIMESTAMP,
	PRIMARY KEY (idUser)
);

CREATE TABLE FollowUsers(
    idFollowUser INT NOT NULL AUTO_INCREMENT,
    id_User INT NOT NULL,
    Follower INT NOT NULL,
    FollowState BOOL,
    Created TIMESTAMP,
    PRIMARY KEY (idFollowUser),
    FOREIGN KEY (id_User) REFERENCES User(idUser)
);

CREATE TABLE Video(
	idVideo INT NOT NULL AUTO_INCREMENT,
    id_User INT NOT NULL,
    VideoName VARCHAR(45) NOT NULL,
    VideoDesc VARCHAR(128),
    FileName VARCHAR(45),
    Created TIMESTAMP,
    PRIMARY KEY (idVideo),
    FOREIGN KEY (id_User) REFERENCES User(idUser)
);

CREATE TABLE Tag(
	idTag INT NOT NULL AUTO_INCREMENT,
    TagName CHAR(45) NOT NULL,
    PRIMARY KEY (idTag)
);

CREATE TABLE VideoTag(
	idVideoTag INT NOT NULL AUTO_INCREMENT,
    id_Video INT NOT NULL,
    id_Tag INT NOT NULL,
    PRIMARY KEY (idVideoTag),
    FOREIGN KEY (id_Video) REFERENCES Video(idVideo),
    FOREIGN KEY (id_Tag) REFERENCES Tag(idTag)
);

CREATE TABLE VideoVisibilityState(
	idVideoVisibilityState INT NOT NULL AUTO_INCREMENT,
    VideoVisibilityDesc CHAR(45) NOT NULL,
    Created TIMESTAMP,
    PRIMARY KEY (idVideoVisibilityState)
);

CREATE TABLE VideoVisibility(
	idVideoVisibility INT NOT NULL AUTO_INCREMENT,
    id_Video INT NOT NULL,
    id_VideoVisibilityState INT NOT NULL,
    Created TIMESTAMP,
    PRIMARY KEY (idVideoVisibility),
    FOREIGN KEY (id_Video) REFERENCES Video(idVideo),
    FOREIGN KEY (id_VideoVisibilityState) REFERENCES VideoVisibilityState(idVideoVisibilityState)
);

CREATE TABLE InteractionType(
	idInteractionType INT NOT NULL AUTO_INCREMENT,
    Description INT NOT NULL,
    Created TIMESTAMP,
    PRIMARY KEY (idInteractionType)
);

CREATE TABLE InteractionVideos(
	idInteraction INT NOT NULL AUTO_INCREMENT,
    id_InteractionType INT NOT NULL,
    id_User INT NOT NULL,
    id_Video INT NOT NULL,
    InteractionType INT NOT NULL,
    Created TIMESTAMP,
    PRIMARY KEY (idInteraction),
    FOREIGN KEY (id_InteractionType) REFERENCES InteractionType(idInteractionType),
    FOREIGN KEY (id_User) REFERENCES User(idUser),
    FOREIGN KEY (id_Video) REFERENCES Video(idVideo)
);

CREATE TABLE InteractionComments(
	idInteractionComment INT NOT NULL AUTO_INCREMENT,
    id_Interaction INT NOT NULL,
    TextComment VARCHAR(128) NOT NULL,
    Created TIMESTAMP,
    PRIMARY KEY (idInteractionComment),
    FOREIGN KEY (id_Interaction) REFERENCES Interactionvideos(idInteraction)
);

CREATE TABLE Channel(
	idChannel INT NOT NULL AUTO_INCREMENT,
	id_User INT NOT NULL,
    ChannelName VARCHAR(45) NOT NULL,
    ChannelDesc VARCHAR(128) NOT NULL,
	Created TIMESTAMP,
	PRIMARY KEY (idChannel),
	FOREIGN KEY (id_User) REFERENCES User(idUser)
);

CREATE TABLE ChannelVideos(
	idChannelVideo INT NOT NULL AUTO_INCREMENT,
    id_Channel INT NOT NULL,
    id_Video INT NOT NULL,
    id_User INT NOT NULL,
    ChannelState BOOL,
    Created TIMESTAMP,
    PRIMARY KEY (idChannelVideo),
    FOREIGN KEY (id_Channel) REFERENCES Channel(idChannel),
	FOREIGN KEY (id_Video) REFERENCES Video(idVideo),
    FOREIGN KEY (id_User) REFERENCES User(idUser)
);

CREATE TABLE FollowChannel(
    idFollowChannel INT NOT NULL AUTO_INCREMENT,
    id_Channel INT NOT NULL,
    Follower INT NOT NULL,
    FollowState BOOL,
    Created TIMESTAMP,
    PRIMARY KEY (idFollowChannel),
    FOREIGN KEY (id_Channel) REFERENCES Channel(idChannel)
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

CREATE TABLE PlaylistVideos(
	idPlaylistVideo INT NOT NULL AUTO_INCREMENT,
    id_Playlist INT NOT NULL,
    id_Video INT NOT NULL,
    PlaylistVideoState BOOL,
    Created TIMESTAMP,
    PRIMARY KEY (idPlaylistVideo),
    FOREIGN KEY (id_Playlist) REFERENCES Playlist(idPlaylist),
	FOREIGN KEY (id_Video) REFERENCES Video(idVideo)
);