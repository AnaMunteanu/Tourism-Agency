CREATE DATABASE Agentie;
USE Agentie;
CREATE TABLE Client(cod_c INT PRIMARY KEY,
					nume VARCHAR(50),
					varsta INT,
					ocupatie VARCHAR(50));

CREATE TABLE Categorie(cod_cat INT PRIMARY KEY,
						denumire VARCHAR(50));

CREATE TABLE Destinatie(cod_d INT PRIMARY KEY,
						nume VARCHAR(50),
						cod_cat INT FOREIGN KEY REFERENCES Categorie(cod_cat));

CREATE TABLE Sejur(cod_c INT FOREIGN KEY REFERENCES Client(cod_c),
					cod_d INT FOREIGN KEY REFERENCES Destinatie(cod_d),
					CONSTRAINT cod_s PRIMARY KEY (cod_c, cod_d),
					rating INT);

CREATE TABLE Bilet(cod_b INT PRIMARY KEY,
					tip VARCHAR(50),
					pret INT,
					cod_c INT FOREIGN KEY REFERENCES Client(cod_c) ON DELETE CASCADE ON UPDATE CASCADE);
CREATE TABLE Sejur(cod_c INT FOREIGN KEY REFERENCES Client(cod_c) ON DELETE CASCADE ON UPDATE CASCADE,
				cod_d INT FOREIGN KEY REFERENCES Destinatie(cod_d) ON DELETE CASCADE ON UPDATE CASCADE,
				CONSTRAINT cod_s PRIMARY KEY (cod_c, cod_d),
				rating INT);
CREATE TABLE Destinatie(cod_d INT PRIMARY KEY,
						nume VARCHAR(50),
						cod_cat INT FOREIGN KEY REFERENCES Categorie(cod_cat) ON DELETE CASCADE ON UPDATE CASCADE);

INSERT INTO Client VALUES (1, 'Pop', 30, 'programator'), (2, 'Moldovan', 21, 'student'), (3, 'Popescu', 55, 'mecanic'),(4, 'Marian', 30, 'medic');
INSERT INTO Categorie VALUES (100, 'all inclusive'), (200, 'mare'), (300, 'munte');
INSERT INTO Destinatie VALUES (1234, 'Albena', 100), (1235, 'Thassos', 100), (1236, 'Mamaia', 200);
INSERT INTO Sejur VALUES (1, 1235, 9),(3, 1236, 7),(4, 1234, 10);
INSERT INTO Bilet(tip, pret, cod_c,cod_b) VALUES ('avion', 1000,2, 6867), ('autocar', 120, 3, 2356);
