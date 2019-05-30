DROP TABLE IF EXISTS Hora;
DROP TABLE IF EXISTS Actor;
DROP TABLE IF EXISTS Productora;
DROP TABLE IF EXISTS Fecha;
DROP TABLE IF EXISTS Cast;
DROP TABLE IF EXISTS Pelicula;
DROP TABLE IF EXISTS Participa;
DROP TABLE IF EXISTS Voto;

CREATE TABLE Hora
(
	clvHora			INTEGER PRIMARY KEY,
	timestamp			TIME		NOT NULL,
	hora			INTEGER,
	minuto			INTEGER,
	segundo			INTEGER
);


CREATE TABLE Fecha
(
	clvFecha			INTEGER PRIMARY KEY,
	fecha			DATE		NOT NULL,
	dia			INTEGER		NOT NULL,
	mes			VARCHAR(255),
	anyo			INTEGER
);

CREATE TABLE Pelicula
(
	clvPelicula			INTEGER PRIMARY KEY,
	idNatural			INTEGER		NOT NULL,
	titulo			VARCHAR(255)		NOT NULL,
	anyoLanzamiento			INTEGER		NOT NULL
);


CREATE TABLE Voto
(
	clvPelicula			INTEGER NOT NULL,
	clvHora			INTEGER		NOT NULL,
	clvFecha			INTEGER		NOT NULL,
	nota			DOUBLE		NOT NULL,
	FOREIGN KEY(clvPelicula) REFERENCES Pelicula (clvPelicula),
	FOREIGN KEY(clvHora) REFERENCES Hora (clvHora),
	FOREIGN KEY(clvFecha) REFERENCES Fecha (clvFecha)
);
