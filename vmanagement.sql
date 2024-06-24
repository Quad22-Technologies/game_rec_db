-- This Is Dominique


-- Enable UUID Extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Drop tables if they exist
DROP TABLE IF EXISTS Vehicles;
DROP TABLE IF EXISTS VehicleDealers;
DROP TABLE IF EXISTS VehicleTypes;
DROP TABLE IF EXISTS Owners;
DROP TABLE IF EXISTS VehicleClasses;

-- Create VehicleTypes Table
CREATE TABLE VehicleTypes (
    VehicleTypeID UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    TypeName VARCHAR(50) NOT NULL
);

-- Insert data into VehicleTypes
INSERT INTO VehicleTypes (TypeName) VALUES
('Sedan'),
('SUV'),
('Truck');

-- Create VehicleDealers Table
CREATE TABLE VehicleDealers (
    DealerID UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    DealerName VARCHAR(100) NOT NULL,
    Location VARCHAR(100)
);

-- Insert data into VehicleDealers
INSERT INTO VehicleDealers (DealerName, Location) VALUES
('Auto World', 'New York'),
('Car Hub', 'Los Angeles'),
('Best Cars', 'Chicago');

-- Create VehicleClasses Table
CREATE TABLE VehicleClasses (
    VehicleClassID UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    ClassName VARCHAR(50) NOT NULL
);

-- Insert data into VehicleClasses
INSERT INTO VehicleClasses (ClassName) VALUES
('Economy'),
('Luxury'),
('Sport');

-- Create Owners Table
CREATE TABLE Owners (
    OwnerID UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    OwnerName VARCHAR(100) NOT NULL,
    ContactInfo VARCHAR(100)
);

-- Insert data into Owners
INSERT INTO Owners (OwnerName, ContactInfo) VALUES
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com'),
('Robert Brown', 'robert@example.com');

-- Create Vehicles Table
CREATE TABLE Vehicles (
    VehicleID UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    Make VARCHAR(50) NOT NULL,
    Model VARCHAR(50) NOT NULL,
    Year INT NOT NULL,
    VehicleTypeID UUID,
    DealerID UUID,
    OwnerID UUID,
    VehicleClassID UUID,
    FOREIGN KEY (VehicleTypeID) REFERENCES VehicleTypes(VehicleTypeID),
    FOREIGN KEY (DealerID) REFERENCES VehicleDealers(DealerID),
    FOREIGN KEY (OwnerID) REFERENCES Owners(OwnerID),
    FOREIGN KEY (VehicleClassID) REFERENCES VehicleClasses(VehicleClassID)
);

-- Insert data into Vehicles
INSERT INTO Vehicles (Make, Model, Year, VehicleTypeID, DealerID, OwnerID, VehicleClassID)
SELECT 'Toyota', 'Camry', 2021, vt.VehicleTypeID, vd.DealerID, o.OwnerID, vc.VehicleClassID
FROM (SELECT VehicleTypeID FROM VehicleTypes WHERE TypeName = 'Sedan') vt,
     (SELECT DealerID FROM VehicleDealers WHERE DealerName = 'Auto World') vd,
     (SELECT OwnerID FROM Owners WHERE OwnerName = 'John Doe') o,
     (SELECT VehicleClassID FROM VehicleClasses WHERE ClassName = 'Economy') vc;

INSERT INTO Vehicles (Make, Model, Year, VehicleTypeID, DealerID, OwnerID, VehicleClassID)
SELECT 'Honda', 'CR-V', 2020, vt.VehicleTypeID, vd.DealerID, o.OwnerID, vc.VehicleClassID
FROM (SELECT VehicleTypeID FROM VehicleTypes WHERE TypeName = 'SUV') vt,
     (SELECT DealerID FROM VehicleDealers WHERE DealerName = 'Car Hub') vd,
     (SELECT OwnerID FROM Owners WHERE OwnerName = 'Jane Smith') o,
     (SELECT VehicleClassID FROM VehicleClasses WHERE ClassName = 'Luxury') vc;

INSERT INTO Vehicles (Make, Model, Year, VehicleTypeID, DealerID, OwnerID, VehicleClassID)
SELECT 'Ford', 'F-150', 2019, vt.VehicleTypeID, vd.DealerID, o.OwnerID, vc.VehicleClassID
FROM (SELECT VehicleTypeID FROM VehicleTypes WHERE TypeName = 'Truck') vt,
     (SELECT DealerID FROM VehicleDealers WHERE DealerName = 'Best Cars') vd,
     (SELECT OwnerID FROM Owners WHERE OwnerName = 'Robert Brown') o,
     (SELECT VehicleClassID FROM VehicleClasses WHERE ClassName = 'Sport') vc;
