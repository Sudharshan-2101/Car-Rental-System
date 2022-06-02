CREATE DATABASE CarRental

USE CarRental

CREATE TABLE Brands
(
	BrandId INT PRIMARY KEY IDENTITY(1,1),
	BrandName VARCHAR(80) UNIQUE NOT NULL,
	IsActive BIT NOT NULL,
	CreatedDate DATETIME NOT NULL
)

CREATE TABLE Vehicles
(
	VehicleId INT PRIMARY KEY IDENTITY(1,1),
	Name VARCHAR(100) NOT NULL,
	Description VARCHAR(MAX) NOT NULL,
	ImageUrl VARCHAR(MAX) NULL,
	BrandId INT FOREIGN KEY REFERENCES dbo.Brands(BrandId) ON DELETE CASCADE,
	PricePerKM DECIMAL(18,2) NOT NULL,
	SeatingCapacity VARCHAR(50) NOT NULL,
	FuelType VARCHAR(50) NOT NULL,
	Mileage INT NOT NULL,
	Luggage VARCHAR(50) NOT NULL,
	Transmission VARCHAR(50) NOT NULL,
	IsActive BIT NOT NULL,
	CreatedDate DATETIME NOT NULL
)

CREATE TABLE Accessories
(
	AccessoryId INT PRIMARY KEY IDENTITY(1,1),
	Air_Conditioner BIT NOT NULL,
	Power_Door_Locks BIT NOT NULL,
	Antilock_Bracking_System BIT NOT NULL,
	Power_Steering BIT NOT NULL,
	Child_Seat BIT NOT NULL,
	Passengers_Airbag BIT NOT NULL,
	Music BIT NOT NULL,
	Climate_Control BIT NOT NULL,
	GPS BIT NOT NULL,
	Seat_Bealt BIT NOT NULL,
	Bluetooth BIT NOT NULL,
	Remote_Central_Locking BIT NOT NULL,
	VehicleId INT FOREIGN KEY REFERENCES dbo.Vehicles(VehicleId) ON DELETE CASCADE
)

CREATE TABLE Roles
(
	RoleId INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
	RoleName varchar(50) NOT NULL
)

CREATE TABLE Users
(
	UserId int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Name varchar(50) NULL,
	Username varchar(50) UNIQUE NULL,
	Mobile varchar(50) NULL,
	Email varchar(50) NULL,
	License varchar(50) NULL,
	Address varchar(max) NULL,
	PostCode varchar(50) NULL,
	Password varchar(50) NULL,
	ImageUrl varchar(max) NULL,
	RoleId INT FOREIGN KEY REFERENCES Roles(RoleId),
	CreatedDate datetime NULL
)

CREATE TABLE Bookings
(
	BookingId INT PRIMARY KEY IDENTITY(1,1),
	PickUpDate DATE,
	DropOffDate DATE,
	PickUpTime TIME(0),
	OdoMeterStart INT,
	OdoMeterEnd INT,
	Distance DECIMAL(18,2) NOT NULL,
	Price DECIMAL(18,2) NOT NULL,
	VehicleId INT FOREIGN KEY REFERENCES Vehicles(VehicleId) ON DELETE CASCADE,
	UserId INT FOREIGN KEY REFERENCES Users(UserId) ON DELETE CASCADE,
	Status VARCHAR(50),
	IsDeleted BIT,
	BookingDate DATETIME
)

CREATE TABLE Contact
(
	ContactId int PRIMARY KEY IDENTITY(1,1) NOT NULL,
	Name varchar(50) NULL,
	Email varchar(50) NULL,
	Subject varchar(200) NULL,
	Message varchar(max) NULL,
	CreatedDate datetime NULL
)

-- Stored Procedures

CREATE PROCEDURE Brand_Crud 
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(20) = NULL,
	@BrandId INT = 0,
	@BrandName VARCHAR(80) = NULL,
	@IsActive BIT = false
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- SELECT 
	IF @Action = 'SELECT'
	BEGIN
		SELECT * FROM dbo.Brands;
	END

    -- INSERT
	IF @Action = 'INSERT'
	BEGIN
		INSERT INTO dbo.Brands(BrandName,IsActive,CreatedDate) VALUES (@BrandName,@IsActive, GETDATE());
	END

	-- UPDATE
	IF @Action = 'UPDATE'
	BEGIN
		UPDATE dbo.Brands SET BrandName = @BrandName, IsActive = @IsActive WHERE BrandId = @BrandId;
	END

	-- DELETE
	IF @Action = 'DELETE'
	BEGIN
		DELETE FROM dbo.Brands WHERE BrandId = @BrandId;
	END

	-- GET BY ID 
	IF @Action = 'GETBYID'
	BEGIN
		SELECT * FROM dbo.Brands WHERE BrandId = @BrandId;
	END

	-- GET ACTIVE BRAND
	IF @Action = 'ACTIVEBRAND'
	BEGIN
		SELECT * FROM dbo.Brands WHERE IsActive = 1;
	END
END




CREATE PROCEDURE Contact_Crud
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(10),
	@ContactId INT = NULL,
	@Name VARCHAR(50) = NULL,
	@Email VARCHAR(50) = NULL,
	@Subject VARCHAR(200) = NULL,
	@Message VARCHAR(MAX) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --INSERT
	IF @Action = 'INSERT'
      BEGIN
            INSERT INTO dbo.Contact(Name, Email, Subject, Message, CreatedDate)
            VALUES (@Name, @Email, @Subject, @Message, GETDATE())
      END

	--SELECT
    IF @Action = 'SELECT'
      BEGIN
            SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [SrNo],* FROM dbo.Contact
      END

	--DELETE BY ADMIN
    IF @Action = 'DELETE'
      BEGIN
            DELETE FROM dbo.Contact WHERE ContactId = @ContactId
      END
END



CREATE PROCEDURE User_Crud
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(20),
	@UserId INT = NULL,
	@Name varchar(50) = null,
	@Username varchar(50) = null,
	@Mobile varchar(50) = null,
	@Email varchar(50) = null,
	@License varchar(50) = null,
	@Address varchar(max) = null,
	@PostCode varchar(50) = null,
	@Password varchar(50) = null,
	@ImageUrl varchar(max) = null,
	@RoleId INT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--SELECT FOR LOGIN
    IF @Action = 'SELECT4LOGIN'
      BEGIN
            SELECT * FROM dbo.Users WHERE Username = @Username and Password = @Password
      END

	--SELECT FOR USER PROFILE
    IF @Action = 'SELECT4PROFILE'
      BEGIN
            SELECT * FROM dbo.Users WHERE UserId = @UserId
      END

    -- Insert (REGISTRATION)
	IF @Action = 'INSERT'
		BEGIN
			Insert into dbo.Users(Name,Username,Mobile,Email,License,Address,PostCode,Password,ImageUrl,RoleId,CreatedDate) 
			values (@Name,@Username,@Mobile,@Email,@License,@Address,@PostCode,@Password,@ImageUrl,@RoleId,GETDATE())
		END

	--UPDATE USER PROFILE
    IF @Action = 'UPDATE'
      BEGIN
		DECLARE @UPDATE_IMAGE VARCHAR(20)
		SELECT @UPDATE_IMAGE = (CASE WHEN @ImageUrl IS NULL THEN 'NO' ELSE 'YES' END)
		IF @UPDATE_IMAGE = 'NO'
			BEGIN
				UPDATE dbo.Users
				SET Name = @Name, Username = @Username, Mobile = @Mobile, Email = @Email, License = @License,
				Address = @Address, PostCode = @PostCode
				WHERE UserId = @UserId
			END
		ELSE
			BEGIN
				UPDATE dbo.Users
				SET Name = @Name, Username = @Username, Mobile = @Mobile, Email = @Email, License = @License,
				Address = @Address, PostCode = @PostCode, ImageUrl = @ImageUrl
				WHERE UserId = @UserId
			END
      END

	--AUTO PASSWORD UPDATE
	IF @Action = 'AUTOPASSWORDUPDATE'
		BEGIN
			UPDATE dbo.Users 
			SET Password = @Password 
			WHERE Username = @Username
		END

	--FORGOT PASSWORD
	IF @Action = 'FORGOTPASSWORD'
		BEGIN
			SELECT Email,Password FROM Users WHERE Username = @Username
		END

	--SELECT FOR ADMIN
	IF @Action = 'SELECT4ADMIN'
		BEGIN
			SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [SrNo],UserId, Name, 
			Username, Email, License, CreatedDate
			FROM Users WHERE RoleId = 2;
		END
	--DELETE BY ADMIN
    IF @Action = 'DELETE'
      BEGIN
            DELETE FROM dbo.Users WHERE UserId = @UserId
      END
END




CREATE PROCEDURE Vehicle_Crud
	-- Add the parameters for the stored procedure here
	--Car
	@Action VARCHAR(20) = NULL,
	@VehicleId INT = 0,
	@Name VARCHAR(80) = NULL,
	@Description VARCHAR(MAX) = NULL,
	@ImageUrl VARCHAR(MAX) = NULL,
	@BrandId INT = 0,
	@PricePerKM DECIMAL(18,2) = NULL,
	@SeatingCapacity VARCHAR(50) = NULL,
	@FuelType VARCHAR(50) = NULL,
	@Mileage INT = 0,
	@Luggage VARCHAR(50) = NULL,
	@Transmission VARCHAR(50) = NULL,
	@IsActive BIT = false,
	--Accessories
	@Air_Conditioner BIT = false,
	@Power_Door_Locks BIT = false,
	@Antilock_Bracking_System BIT = false,
	@Power_Steering BIT = false,
	@Child_Seat BIT = false,
	@Passengers_Airbag BIT = false,
	@Music BIT = false,
	@Climate_Control BIT = false,
	@GPS BIT = false,
	@Seat_Bealt BIT = false,
	@Bluetooth BIT = false,
	@Remote_Central_Locking BIT = false
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @InsertedId int;

	-- SELECT 
	IF @Action = 'SELECT'
	BEGIN
		SELECT c.VehicleId,c.Name,c.ImageUrl,c.BrandId,b.BrandName,c.PricePerKM FROM dbo.Vehicles c
		INNER JOIN dbo.Brands b ON c.BrandId = b.BrandId
		WHERE c.IsActive = 1;
	END

	-- CAR PRICE
	IF @Action = 'PRICEBYID'
	BEGIN
		SELECT PricePerKM
		FROM dbo.Vehicles
		WHERE VehicleId = @VehicleId
	END

	-- SELECT 
	IF @Action = 'SELECT4ADMIN'
	BEGIN
		SELECT c.VehicleId,c.Name,c.Description,c.ImageUrl,c.BrandId,b.BrandName,c.PricePerKM,c.IsActive,c.CreatedDate
		FROM dbo.Vehicles c
		INNER JOIN dbo.Accessories a ON c.VehicleId = a.VehicleId
		INNER JOIN dbo.Brands b ON c.BrandId = b.BrandId
		ORDER BY c.CreatedDate DESC;
	END

    -- INSERT
	IF @Action = 'INSERT'
	BEGIN
		BEGIN TRANSACTION
			BEGIN TRY

				INSERT INTO dbo.Vehicles(Name,Description,ImageUrl,BrandId,PricePerKM,SeatingCapacity,FuelType,Mileage,
				Luggage,Transmission,IsActive,CreatedDate) 
				VALUES (@Name,@Description,@ImageUrl,@BrandId,@PricePerKM,@SeatingCapacity,@FuelType,@Mileage,
				@Luggage,@Transmission,@IsActive, GETDATE());

				SELECT @InsertedId = SCOPE_IDENTITY();

				INSERT INTO dbo.Accessories(Air_Conditioner,Power_Door_Locks,Antilock_Bracking_System,Power_Steering,
				Child_Seat,Passengers_Airbag,Music,Climate_Control,GPS,Seat_Bealt,Bluetooth,Remote_Central_Locking,VehicleId)
				VALUES(@Air_Conditioner,@Power_Door_Locks,@Antilock_Bracking_System,@Power_Steering,@Child_Seat,
				@Passengers_Airbag,@Music,@Climate_Control,@GPS,@Seat_Bealt,@Bluetooth,@Remote_Central_Locking,@InsertedId);
			-- if not error, commit the transcation
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			-- if error, roll back any chanegs done by any of the sql statements
			ROLLBACK TRANSACTION
		END CATCH
	END

	-- UPDATE
	IF @Action = 'UPDATE'
	BEGIN
		DECLARE @UPDATE_IMAGE VARCHAR(20)
		SELECT @UPDATE_IMAGE = (CASE WHEN @ImageUrl IS NULL THEN 'NO' ELSE 'YES' END)
		PRINT @UPDATE_IMAGE
		BEGIN TRANSACTION
			BEGIN TRY
				IF @UPDATE_IMAGE = 'NO'
					BEGIN
						UPDATE dbo.Vehicles SET Name=@Name,Description=@Description,BrandId=@BrandId,
						PricePerKM=@PricePerKM,SeatingCapacity=@SeatingCapacity,FuelType=@FuelType,Mileage=@Mileage,
						Luggage=@Luggage,Transmission=@Transmission,IsActive=@IsActive
						FROM dbo.Vehicles 
						WHERE VehicleId = @VehicleId;
					END
				ELSE
					BEGIN
						UPDATE dbo.Vehicles SET Name=@Name,Description=@Description,ImageUrl=@ImageUrl,BrandId=@BrandId,
						PricePerKM=@PricePerKM,SeatingCapacity=@SeatingCapacity,FuelType=@FuelType,Mileage=@Mileage,
						Luggage=@Luggage,Transmission=@Transmission,IsActive=@IsActive
						FROM dbo.Vehicles 
						WHERE VehicleId = @VehicleId;
					END
				UPDATE Accessories SET Air_Conditioner=@Air_Conditioner,
				Power_Door_Locks=@Power_Door_Locks,Antilock_Bracking_System=@Antilock_Bracking_System,Power_Steering=@Power_Steering,
				Child_Seat=@Child_Seat,Passengers_Airbag=@Passengers_Airbag,Music=@Music,Climate_Control=@Climate_Control,
				GPS=@GPS,Seat_Bealt=@Seat_Bealt,Bluetooth=@Bluetooth,Remote_Central_Locking=@Remote_Central_Locking
				FROM dbo.Accessories
				WHERE VehicleId = @VehicleId;
			-- if not error, commit the transcation
			COMMIT TRANSACTION
		END TRY
		BEGIN CATCH
			-- if error, roll back any chanegs done by any of the sql statements
		    ROLLBACK TRANSACTION
		END CATCH
	END

	-- DELETE
	IF @Action = 'DELETE'
	BEGIN
		DELETE Vehicles FROM dbo.Vehicles c JOIN dbo.Accessories a ON c.VehicleId = a.VehicleId
		WHERE c.VehicleId = @VehicleId;
	END

	-- GET BY ID 
	IF @Action = 'GETBYID'
	BEGIN
		SELECT * FROM dbo.Vehicles c
		INNER JOIN dbo.Accessories a ON c.VehicleId = a.VehicleId
		INNER JOIN dbo.Brands b ON c.BrandId = b.BrandId
		WHERE c.VehicleId = @VehicleId;
	END

	-- SEARCH BY NAME 
	IF @Action = 'SEARCHBYNAME'
	BEGIN
		SELECT c.VehicleId,c.Name,c.ImageUrl,c.BrandId,b.BrandName,c.PricePerKM FROM dbo.Vehicles c
		INNER JOIN dbo.Brands b ON c.BrandId = b.BrandId
		WHERE c.IsActive = 1 AND c.Name LIKE '%'+ @Name +'%';
	END

	-- GET BY BRAND 
	IF @Action = 'GETBYBRAND'
	BEGIN
		SELECT c.VehicleId,c.Name,c.ImageUrl,c.BrandId,b.BrandName,c.PricePerKM FROM dbo.Vehicles c
		INNER JOIN dbo.Brands b ON c.BrandId = b.BrandId
		WHERE c.IsActive = 1 AND c.BrandId = @BrandId ;
	END
END




CREATE PROCEDURE Booking_Crud
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(20),
	@BookingId INT = NULL,
	@PickUpDate DATE = null,
	@DropOffDate DATE = null,
	@PickUpTime TIME(0) = null,
	@OdoMeterStart INT = NULL,
	@OdoMeterEnd INT = NULL,
	@Distance DECIMAL(18,2) = NULL,
	@Price DECIMAL(18,2) = NULL,
	@VehicleId INT = NULL,
	@UserId INT = NULL,
	@Status VARCHAR(20) = null,
	@IsDeleted BIT = false
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--SELECT FOR USER
    IF @Action = 'SELECTBYUSERID'
      BEGIN
            SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [SrNo],b.BookingId,b.PickUpDate,b.DropOffDate,b.PickUpTime,v.VehicleId,
			v.Name,b.Distance,b.Price,b.Status,b.BookingDate FROM dbo.Bookings b
			INNER JOIN Vehicles v ON b.VehicleId = v.VehicleId
			WHERE b.IsDeleted = 0 and b.UserId = @UserId
      END

    -- INSERT FOR USER
	IF @Action = 'INSERT'
		BEGIN
			INSERT INTO dbo.Bookings(PickUpDate,DropOffDate,PickUpTime,Distance,Price,VehicleId,UserId,Status,IsDeleted,BookingDate) 
			VALUES (@PickUpDate,@DropOffDate,@PickUpTime,@Distance,@Price,@VehicleId,@UserId,@Status,@IsDeleted,GETDATE())
		END

	--UPDATE FOR ADMIN
    IF @Action = 'UPDATEBYADMIN'
      BEGIN
	  DECLARE @CONDITION NVARCHAR(128)
		DECLARE @QUERY NVARCHAR(MAX)
		DECLARE @PARAMS NVARCHAR (1000)
		SELECT @CONDITION = 
		(
			CASE 
				WHEN @Status = 'Rented' THEN ',PickUpDate=GETDATE()' 
				WHEN @Status = 'Returned' THEN ',DropOffDate=GETDATE()' 
				ELSE ' ' END
		)
		SET @QUERY =
			N'UPDATE dbo.Bookings SET OdoMeterStart = @OdoMeterStart, OdoMeterEnd = @OdoMeterEnd, Distance = @Distance,
			Price = @Price, Status = @Status' + @CONDITION +
			N'WHERE BookingId = @BookingId'
		SET @PARAMS = N'@OdoMeterStart INT, @OdoMeterEnd INT, @Distance DECIMAL(18,2), @Price DECIMAL(18,2), @Status VARCHAR(20), @BookingId INT'
		EXECUTE sp_executesql @QUERY, @PARAMS, @OdoMeterStart, @OdoMeterEnd, @Distance, @Price, @Status, @BookingId;
      END

	--CANCEL BOOKING BY USER
    IF @Action = 'CANCELBOOKING'
      BEGIN
			UPDATE dbo.Bookings SET IsDeleted = @IsDeleted
			WHERE BookingId = @BookingId
      END

	--SELECT FOR ADMIN
	IF @Action = 'SELECT4ADMIN'
		BEGIN
			SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS [SrNo],b.BookingId,b.PickUpDate,b.DropOffDate,b.PickUpTime,
			b.Distance,b.Price,b.VehicleId,v.Name,b.UserId,u.Username,b.Status,b.IsDeleted,b.BookingDate FROM Bookings b
			INNER JOIN dbo.Vehicles v ON b.VehicleId = v.VehicleId
			INNER JOIN dbo.Users u ON b.UserId = u.UserId
		END
	--DELETE BY ADMIN
    IF @Action = 'DELETE'
      BEGIN
            DELETE FROM dbo.Bookings WHERE BookingId = @BookingId
      END

	--GET BY BOOKING ID
    IF @Action = 'GETBYID'
      BEGIN
            SELECT b.BookingId,b.OdoMeterStart,b.OdoMeterEnd,b.Distance,b.Price,b.Status,v.PricePerKM FROM dbo.Bookings b
			INNER JOIN Vehicles v ON b.VehicleId = v.VehicleId
			WHERE b.BookingId = @BookingId
      END
END




CREATE PROCEDURE Dashboard
	-- Add the parameters for the stored procedure here
	@Action VARCHAR(20) = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    --1.Brands
	IF @Action = 'BRAND'
	BEGIN
		SELECT COUNT(*) FROM dbo.Brands
	END

	--2.Cars
	IF @Action = 'CAR'
	BEGIN
		SELECT COUNT(*) FROM dbo.Vehicles
	END

	--3.Orders
	IF @Action = 'BOOKING'
	BEGIN
		SELECT COUNT(*) FROM dbo.Bookings
	END

	--4.Users
	IF @Action = 'USER'
	BEGIN
		SELECT COUNT(*) FROM dbo.Users
	END

	--5.Contact
	IF @Action = 'CONTACT'
	BEGIN
		SELECT COUNT(*) FROM dbo.Contact
	END
END