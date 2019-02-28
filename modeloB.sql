CREATE TABLE Hora
(
	clvHora			INTEGER,
	timestamp			TIME		NOT NULL,
	hora			INTEGER,
	minuto			INTEGER,
	segundo			INTEGER,
	PRIMARY KEY(clvHora));


CREATE TABLE Actor
(
	clvActor			INTEGER,
	nombre			VARCHAR(255)		NOT NULL,
	nacionalidad			VARCHAR(255)		NOT NULL,
	genero			VARCHAR(255)		NOT NULL,
	PRIMARY KEY(clvActor));


CREATE TABLE Fecha
(
	clvFecha			INTEGER,
	fecha			DATE		NOT NULL,
	dia			INTEGER		NOT NULL,
	mes			VARCHAR(255),
	anyo			INTEGER,
	PRIMARY KEY(clvFecha));


CREATE TABLE Papel
(
	clvPapel			INTEGER,
	genero			VARCHAR(255)		NOT NULL,
	planetaDeOrigen			VARCHAR(255)		NOT NULL,
	PRIMARY KEY(clvPapel));


CREATE TABLE Pelicula
(
	clvPelicula			INTEGER,
	fechaLanzamiento			INTEGER,
	titulo			VARCHAR(255)		NOT NULL,
	clvCast			INTEGER		NOT NULL		UNIQUE,
	productora			VARCHAR(255)		NOT NULL,
	PRIMARY KEY(clvPelicula),
	FOREIGN KEY(fechaLanzamiento) REFERENCES Fecha (clvFecha));

CREATE TABLE Actua
(
	clvPelicula			INTEGER,
	clvActor			INTEGER,
	clvPapel			INTEGER		NOT NULL,
	minutosEnPantalla			INTEGER		NOT NULL,
	participaciones			INTEGER		NOT NULL,
	PRIMARY KEY(clvPelicula, clvActor),
	FOREIGN KEY(clvPelicula) REFERENCES Pelicula (clvPelicula),
	FOREIGN KEY(clvActor) REFERENCES Actor (clvActor),
	FOREIGN KEY(clvPapel) REFERENCES Papel (clvPapel));

CREATE TABLE Voto
(
	clvPelicula			INTEGER,
	clvHora			INTEGER		NOT NULL,
	clvFecha			INTEGER		NOT NULL,
	nota			INTEGER		NOT NULL,
	PRIMARY KEY(clvPelicula),
	FOREIGN KEY(clvPelicula) REFERENCES Pelicula (clvPelicula),
	FOREIGN KEY(clvHora) REFERENCES Hora (clvHora),
	FOREIGN KEY(clvFecha) REFERENCES Fecha (clvFecha));

