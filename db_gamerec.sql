---This is a test
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

DROP Table if EXISTS UserToGenre;
drop table IF EXISTs Genre;
drop table IF EXISTs UserProfile;
drop table IF EXISTs AccountInformation;

Create TABLE AccountInformation (
    AccountInfoID UUID  PRIMARY KEY DEFAULT uuid_generate_v4(),
     Password VarChar(100),
    CreatedDate Timestamp Default current_timestamp,
    ModifiedDate Timestamp Default current_timestamp

);


INSERT INTO AccountInformation (AccountInfoID, Password) 
    VALUES ('1e1d3f5e-79db-4d0b-a54d-95c1e7e4b5f4', 'password1'),
    ('2a2d3f5e-79db-4d0b-a54d-95c1e7e4b5f4', 'password2'),
    ('3b3d3f5e-79db-4d0b-a54d-95c1e7e4b5f4', 'password3');



CREATE TABLE UserProfile(
    UserProfileID UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    AccountInfoID UUID,
    FirstName VarChar(25),
    LastName VarChar(25),
    Gamertag VarChar(25),
    Email VARCHAR(25),
    CreatedDate Timestamp Default current_timestamp,
     FOREIGN KEY (AccountInfoID) REFERENCES AccountInformation(AccountInfoID)
);

INSERT into UserProfile (UserProfileID, AccountInfoID, FirstName, LastName, Gamertag, Email) 
    VALUES ('22e46daf-7bf9-4c07-a2c1-a5f3d3bd1ee8','1e1d3f5e-79db-4d0b-a54d-95c1e7e4b5f4', 'Rishi', 'Saldi','Riiishi','test@gmail.com'),
    ('fa036e39-0c54-4430-8f2a-d9c83c1f6f71','2a2d3f5e-79db-4d0b-a54d-95c1e7e4b5f4', 'tester', 'james','jhon','jhon@gmail.com'),
    ('b2036d6f-1b8c-4d2d-98c8-29cd434066e5','3b3d3f5e-79db-4d0b-a54d-95c1e7e4b5f4', 'lebron', 'james','jim','lebron@gmail.com');
	

/*     UserProfileID                          AccountInfoID					    FirstName		
"22e46daf-7bf9-4c07-a2c1-a5f3d3bd1ee8"	"1e1d3f5e-79db-4d0b-a54d-95c1e7e4b5f4"	"Rishi"	    "Saldi"	"Riiishi"
"fa036e39-0c54-4430-8f2a-d9c83c1f6f71"	"2a2d3f5e-79db-4d0b-a54d-95c1e7e4b5f4"	"tester"	"james"	"jhon"
"b2036d6f-1b8c-4d2d-98c8-29cd434066e5"	"3b3d3f5e-79db-4d0b-a54d-95c1e7e4b5f4"	"lebron"	"james"	"jim"
*/

CREATE TABLE Genre(
    GenreID UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
Genres VARCHAR(50) ,
Description VARCHAR(100) 
);
INSERT INTO GENRE (GenreID, Genres, Description ) 
VALUES ('31fd3cf0-3cd0-4e3d-b426-bc145d3f8ad3', 'Action', 'blabla'), 
('8ed27a7d-c7b1-4aea-ae7f-73f8cf5d4e5e', 'Sports', 'testing'),
('4712cc50-5310-4e4a-9640-a62b1375ac6c', 'Horror','test'),
('2cdf9475-907d-4f06-9813-9440d1b44470', 'Adventure', 'blah');

/*

"31fd3cf0-3cd0-4e3d-b426-bc145d3f8ad3"	"Action"	"blabla"
"8ed27a7d-c7b1-4aea-ae7f-73f8cf5d4e5e"	"Sports"	"testing"
"4712cc50-5310-4e4a-9640-a62b1375ac6c"	"Horror"	"test"
"2cdf9475-907d-4f06-9813-9440d1b44470"	"Adventure"	"blah"

*/

CREATE TABLE UserToGenre (
    UserToGenreID UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    UserProfileID UUID,
    GenreID UUID,
    IsActive Boolean,
FOREIGN KEY (UserProfileID) REFERENCES UserProfile(UserProfileID),
    FOREIGN KEY (GenreID) REFERENCES Genre(GenreID)

    );

/*     UserProfileID                          AccountInfoID					    FirstName		
"22e46daf-7bf9-4c07-a2c1-a5f3d3bd1ee8"	"1e1d3f5e-79db-4d0b-a54d-95c1e7e4b5f4"	"Rishi"	    "Saldi"	"Riiishi"
"fa036e39-0c54-4430-8f2a-d9c83c1f6f71"	"2a2d3f5e-79db-4d0b-a54d-95c1e7e4b5f4"	"tester"	"james"	"jhon"
"b2036d6f-1b8c-4d2d-98c8-29cd434066e5"	"3b3d3f5e-79db-4d0b-a54d-95c1e7e4b5f4"	"lebron"	"james"	"jim"
*/

/*

"31fd3cf0-3cd0-4e3d-b426-bc145d3f8ad3"	"Action"	"blabla"
"8ed27a7d-c7b1-4aea-ae7f-73f8cf5d4e5e"	"Sports"	"testing"
"4712cc50-5310-4e4a-9640-a62b1375ac6c"	"Horror"	"test"
"2cdf9475-907d-4f06-9813-9440d1b44470"	"Adventure"	"blah"

*/

Insert INTO UserToGenre  (UserProfileID, GenreID, IsActive) 
    Values ('22e46daf-7bf9-4c07-a2c1-a5f3d3bd1ee8', '31fd3cf0-3cd0-4e3d-b426-bc145d3f8ad3', true ),
    ('fa036e39-0c54-4430-8f2a-d9c83c1f6f71', '8ed27a7d-c7b1-4aea-ae7f-73f8cf5d4e5e', true ),
('b2036d6f-1b8c-4d2d-98c8-29cd434066e5', '4712cc50-5310-4e4a-9640-a62b1375ac6c', true),
('22e46daf-7bf9-4c07-a2c1-a5f3d3bd1ee8', '2cdf9475-907d-4f06-9813-9440d1b44470', true);

SELECT UP.FirstName, UP.LastName, Gs.Genres, Gs. Description FROM UserProfile UP, UserToGenre utg, Genre Gs
WHERE UP.UserProfileID = utg.UserProfileID AND utg.GenreID = Gs.GenreID

CREATE TABLE Games (
    GamesID  UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    GameName VarChar(50),
    Developers VarChar(25),
    Publishers VarChar(25),
    PublishingDate DATE,
    UpdateHistory DATE,
    Links VarChar(200),
    CreatedDate Timestamp Default current_timestamp,
    ModifiedDate Timestamp Default current_timestamp

    );

Insert INTO Games (GamesID, GameName, Developers, Publishers, PublishingDate, UpdateHistory, Links)
     Values ('0e249af7-6c92-4483-a7d6-7dc697fc12f4','Call of duty', 'Rubn', 'Activision','2003-10-29', '2024-05-14', 'https://www.callofduty.com/' );

CREATE TABLE GenreToGames (
    GenreToGamesID UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    GenreID UUID,
    GamesID UUID,
FOREIGN KEY (GenreID) REFERENCES Genre(GenreID),
    FOREIGN KEY (GamesID) REFERENCES Games(GamesID)
);


Insert INTO GenreToGames  (GenreID, GamesID) 
    Values ('31fd3cf0-3cd0-4e3d-b426-bc145d3f8ad3','0e249af7-6c92-4483-a7d6-7dc697fc12f4' );

SELECT Gm.GameName, Gs.Genres, Gs. Description FROM Genre Gs, GenreToGames gtg, Games Gm
WHERE Gm.GamesID = gtg.GamesID AND gtg.GenreID = Gs.GenreID;