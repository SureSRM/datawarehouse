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


CREATE TABLE Productora
(
	clvEmpresa			INTEGER,
	nombre			VARCHAR(255)		NOT NULL,
	PRIMARY KEY(clvEmpresa));


CREATE TABLE Fecha
(
	clvFecha			INTEGER,
	fecha			DATE		NOT NULL,
	dia			INTEGER		NOT NULL,
	mes			VARCHAR(255),
	anyo			INTEGER,
	PRIMARY KEY(clvFecha));


CREATE TABLE Cast
(
	clvCast			INTEGER,
	PRIMARY KEY(clvCast));


CREATE TABLE Pelicula
(
	clvPelicula			INTEGER,
	clvCast			INTEGER,
	fechaLanzamiento			DATE		NOT NULL,
	titulo			VARCHAR(255)		NOT NULL,
	PRIMARY KEY(clvPelicula),
	FOREIGN KEY(clvCast) REFERENCES Cast (clvCast));

CREATE TABLE Participa
(
	clvActor			INTEGER,
	clvCast			INTEGER,
	PRIMARY KEY(clvActor, clvCast),
	FOREIGN KEY(clvActor) REFERENCES Actor (clvActor),
	FOREIGN KEY(clvCast) REFERENCES Cast (clvCast));

CREATE TABLE Voto
(
	clvPelicula			INTEGER,
	clvEmpresa			INTEGER		NOT NULL,
	clvHora			INTEGER		NOT NULL,
	clvFecha			INTEGER		NOT NULL,
	nota			INTEGER		NOT NULL,
	PRIMARY KEY(clvPelicula),
	FOREIGN KEY(clvPelicula) REFERENCES Pelicula (clvPelicula),
	FOREIGN KEY(clvEmpresa) REFERENCES Productora (clvEmpresa),
	FOREIGN KEY(clvHora) REFERENCES Hora (clvHora),
	FOREIGN KEY(clvFecha) REFERENCES Fecha (clvFecha));

