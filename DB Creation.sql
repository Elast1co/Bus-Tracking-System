-- Creating tables at first

CREATE TABLE BUS (
    BusId INT PRIMARY KEY IDENTITY ,
	PlateNumber Varchar(20) NOT NULL , 
	Capacity INT NOT NULL , 
	BusType VARCHAR(50),
	Color VARCHAR(10),
	RegistrationDate Date,
	LastMaintenanceDate Date,
	FuelType VARCHAR(20),
	Notes VARCHAR(50),
	ActiveStatus Varchar(20) DEFAULT 'Active',
	);

CREATE TABLE Driver (
    DriverID Int Primary Key Identity ,
	FirstName Varchar(40),
	LastName Varchar(40),
	Address Varchar(60),
	DateOfBirth Date , 
	LicenseNumber Varchar(50),
	NationalId Varchar(30),
	Phone Varchar(25),
	Email Varchar(50),
	HireDate Date ,
	Rating Int ,
	EmergencyPhone Varchar(25),
	AvailableStatus Varchar(20) Default 'Available',
	Notes Varchar(50),
);


CREATE TABLE Route (
    RouteID INT Primary Key Identity ,
	RouteName VARCHAR(45),
	City VARCHAR(30),
	StartStopID Int,
	EndStopID Int,
	RouteType VARCHAR(30),
	DistanceKM INT,
	EstimatedTimeMins INT ,
	ActiveDays VARCHAR(30),
	FirstTripTime Time,
	LastTripTime Time,
	RouteStatus VARCHAR(20),
	Notes Varchar(50),
);


CREATE TABLE Stop (
    StopId INT Primary Key Identity ,
	StopName VARCHAR(100),
	City VARCHAR(35),
	Latitude INT ,
	Longitude INT ,
	StopType VARCHAR(45),
	StopStatus VARCHAR(20),
	Notes Varchar(50),
);

CREATE TABLE Route_Stop (
    RouteStopID INT Primary Key Identity ,
	RouteId INT NOT NULL ,
	StopID INT NOT NULL ,
	StopOrder INT NOT NULL ,
	EstimatedArrivalTime TIME,
    EstimatedDepartureTime TIME,
    Notes VARCHAR(90),
	FOREIGN KEY (RouteID) REFERENCES Route(RouteID),
    FOREIGN KEY (StopID) REFERENCES Stop(StopID)
);


CREATE TABLE Trip (
    TripID INT PRIMARY KEY IDENTITY,
    BusID INT NOT NULL,
    DriverID INT NOT NULL,
    RouteID INT NOT NULL,
    StartTime DATETIME,
    EndTime DATETIME,
    Status VARCHAR(20) DEFAULT 'Scheduled',
    ActualDistanceKM DECIMAL(6,2),
    ActualDurationMins INT,
    Notes VARCHAR(255),
    FOREIGN KEY (BusID) REFERENCES Bus(BusID),
    FOREIGN KEY (DriverID) REFERENCES Driver(DriverID),
    FOREIGN KEY (RouteID) REFERENCES Route(RouteID)
);


CREATE TABLE Trip_StopTime (
    TripID INT NOT NULL,
    StopID INT NOT NULL,
    ActualArrivalTime DATETIME,
    ActualDepartureTime DATETIME,
    DelayMinutes INT,
    Notes VARCHAR(255),
    PRIMARY KEY (TripID, StopID),
    FOREIGN KEY (TripID) REFERENCES Trip(TripID),
    FOREIGN KEY (StopID) REFERENCES Stop(StopID)
);


CREATE TABLE GPS_Log (
    LogID INT PRIMARY KEY IDENTITY,
    TripID INT NOT NULL,
    Latitude DECIMAL(9,6) NOT NULL,
    Longitude DECIMAL(9,6) NOT NULL,
    SpeedKPH DECIMAL(5,2),
    Direction VARCHAR(20),
    LoggedAt DATETIME DEFAULT GETDATE(),
    Notes VARCHAR(255),
    FOREIGN KEY (TripID) REFERENCES Trip(TripID)
);

CREATE TABLE Passenger (
    PassengerID INT PRIMARY KEY IDENTITY,
    FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
    NationalID VARCHAR(20),
    Phone VARCHAR(20),
    Email VARCHAR(100),
    DateOfBirth DATE,
    Gender CHAR(1),
    Address VARCHAR(255),
    RegistrationDate DATE DEFAULT GETDATE(),
    LoyaltyPoints INT DEFAULT 0,
    PreferredPaymentMethod VARCHAR(50),
    EmergencyContact VARCHAR(100),
    EmergencyPhone VARCHAR(20),
    ProfilePictureURL VARCHAR(255),
    BlacklistStatus BIT DEFAULT 0,
    Notes VARCHAR(255)
);

CREATE TABLE Ticket (
    TicketID INT PRIMARY KEY IDENTITY,
    PassengerID INT NOT NULL,
    TripID INT NOT NULL,
    SeatNumber VARCHAR(10),
    Price DECIMAL(8,2),
    PaymentMethod VARCHAR(50),
    PaymentStatus VARCHAR(20) DEFAULT 'Paid',
    PurchaseTime DATETIME DEFAULT GETDATE(),
    QRCode VARCHAR(255),
    Status VARCHAR(20) DEFAULT 'Active',
    Notes VARCHAR(255),
    FOREIGN KEY (PassengerID) REFERENCES Passenger(PassengerID),
    FOREIGN KEY (TripID) REFERENCES Trip(TripID)
);

CREATE TABLE [User] (
    UserID INT PRIMARY KEY IDENTITY,
    FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
    Username VARCHAR(50) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL,
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Status VARCHAR(20) DEFAULT 'Active',
    CreatedAt DATETIME DEFAULT GETDATE(),
    LastLogin DATETIME,
    Notes VARCHAR(255)
);
