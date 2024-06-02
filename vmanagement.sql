-- Enable UUID Extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Drop tables if they exist
DROP TABLE IF EXISTS Vehicles;
DROP TABLE IF EXISTS VehicleDealers;
DROP TABLE IF EXISTS VehicleTypes;

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

-- Create Vehicles Table
CREATE TABLE Vehicles (
    VehicleID UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    Make VARCHAR(50) NOT NULL,
    Model VARCHAR(50) NOT NULL,
    Year INT NOT NULL,
    VehicleTypeID UUID,
    DealerID UUID,
    FOREIGN KEY (VehicleTypeID) REFERENCES VehicleTypes(VehicleTypeID),
    FOREIGN KEY (DealerID) REFERENCES VehicleDealers(DealerID)
);

-- Insert data into Vehicles
INSERT INTO Vehicles (Make, Model, Year, VehicleTypeID, DealerID)
SELECT 'Toyota', 'Camry', 2021, vt.VehicleTypeID, vd.DealerID
FROM (SELECT VehicleTypeID FROM VehicleTypes WHERE TypeName = 'Sedan') vt,
     (SELECT DealerID FROM VehicleDealers WHERE DealerName = 'Auto World') vd;

INSERT INTO Vehicles (Make, Model, Year, VehicleTypeID, DealerID)
SELECT 'Honda', 'CR-V', 2020, vt.VehicleTypeID, vd.DealerID
FROM (SELECT VehicleTypeID FROM VehicleTypes WHERE TypeName = 'SUV') vt,
     (SELECT DealerID FROM VehicleDealers WHERE DealerName = 'Car Hub') vd;

INSERT INTO Vehicles (Make, Model, Year, VehicleTypeID, DealerID)
SELECT 'Ford', 'F-150', 2019, vt.VehicleTypeID, vd.DealerID
FROM (SELECT VehicleTypeID FROM VehicleTypes WHERE TypeName = 'Truck') vt,
     (SELECT DealerID FROM VehicleDealers WHERE DealerName = 'Best Cars') vd;
