CREATE VIEW view_Client AS
SELECT C.nume, C.varsta, S.rating, D.nume AS nume_destinatie
FROM Client C
INNER JOIN Sejur S
ON C.cod_c=S.cod_c
INNER JOIN Destinatie D
ON D.cod_d=S.cod_d;

SELECT * FROM view_Client;

CREATE PROCEDURE adaugaClient( @nume VARCHAR(50), @ocupatie VARCHAR(50), @varsta INT)
AS
BEGIN
DECLARE @cod_c AS INT;
DECLARE @esteMajor AS INT;
SET @cod_c=dbo.generareCodClient();
SET @esteMajor=dbo.validareVarsta(@varsta);
IF(@esteMajor=1)
	INSERT INTO Client( cod_c,nume, varsta, ocupatie)
	VALUES (@cod_c,@nume, @varsta, @ocupatie);
ELSE
	PRINT('Clientul trebuie sa fie major!');
END;
GO
EXEC adaugaClient 'Ion','elev',14;
EXEC adaugaClient 'Maria','asistenta',30;
DROP PROCEDURE adaugaClient;

CREATE FUNCTION generareCodClient()
RETURNS INT
AS
BEGIN
	DECLARE @cod AS INT;
	SET @cod=0;
	SELECT @cod=MAX(cod_c) FROM Client;
RETURN @cod+1;
END;
GO

CREATE FUNCTION validareVarsta(@varsta INT)
RETURNS INT
AS
BEGIN
	DECLARE @bool AS INT;
	SET @bool=1;
	IF(@varsta<18)
		SET @bool=0;
RETURN @bool;
END;
GO

CREATE PROCEDURE adaugaCategorie(@denumire VARCHAR(50))
AS
BEGIN
DECLARE @cod AS INT;
SET @cod=dbo.generareCodCategorie();
INSERT INTO Categorie VALUES( @cod,@denumire);
END;
GO
EXEC adaugaCategorie 'munte';

CREATE FUNCTION generareCodCategorie()
RETURNS INT
AS
BEGIN
	DECLARE @cod AS INT;
	SET @cod=0;
	SELECT @cod=MAX(cod_cat) FROM Categorie;
RETURN @cod+100;
END;
GO

CREATE PROCEDURE adaugareSejur(@cod_c INT,@cod_d INT,@rating INT)
AS
BEGIN
DECLARE @sePoateAdauga AS INT;
SET @sePoateAdauga=dbo.validareCoduri(@cod_c,@cod_d);
IF @sePoateAdauga=1
	INSERT INTO Sejur VALUES(@cod_c,@cod_d,@rating);
ELSE
	PRINT('Nu se poate adauga inregistrarea, codurile nu sunt valide!');
END;
GO
EXEC adaugareSejur 3,1234,10;
EXEC adaugareSejur 7,1234,5;

CREATE FUNCTION validareCoduri(@cod_c INT,@cod_d INT)
RETURNS INT
AS
BEGIN 
	DECLARE @bool AS INT;
	DECLARE @nr AS INT;
	SET @bool=1;
	SET @nr=0;
	SELECT @nr=COUNT(cod_c) FROM Client 
	WHERE cod_c=@cod_c;
	IF @nr!=1
		SET @bool=0;
	SELECT @nr=COUNT(cod_d) FROM Destinatie
	WHERE cod_d=@cod_d;
	IF @nr!=1
		SET @bool=0;
	SELECT @nr=COUNT(*) FROM Sejur
	WHERE cod_d=@cod_d AND cod_c=@cod_c;
	IF @nr!=0
		SET @bool=0;
RETURN @bool
END;
GO


CREATE TRIGGER la_adaugare_client
ON Client
FOR INSERT
AS
BEGIN
PRINT 'S-a adaugat in tabelul Client o inregistrare, la data: ';
PRINT CONVERT(VARCHAR(20), getdate());
SELECT * FROM inserted;
END;

CREATE TRIGGER la_stergere_client
ON Client
FOR DELETE 
AS
BEGIN
PRINT 'S-a sters din tabelul Client o inregistrare, la data: ';
PRINT CONVERT(VARCHAR(20), getdate());
SELECT * FROM deleted;
END;

DROP TRIGGER la_adaugare_client;