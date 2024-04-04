-- create schema, name is '560_proj_Group09'
IF SCHEMA_ID(N'560_proj_Group09') IS NULL
    EXEC(N'CREATE SCHEMA [560_proj_Group09];');
GO

-- drop tables if exists 
-- TODO: check if the order of drop statements is correct
DROP TABLE IF EXISTS [560_proj_Group09].TeamSeasonPlayer
DROP TABLE IF EXISTS [560_proj_Group09].TeamSeasonCoach
DROP TABLE IF EXISTS [560_proj_Group09].Player
DROP TABLE IF EXISTS [560_proj_Group09].Coach
DROP TABLE IF EXISTS [560_proj_Group09].TeamSeason
DROP TABLE IF EXISTS [560_proj_Group09].Team
DROP TABLE IF EXISTS [560_proj_Group09].Sport
DROP TABLE IF EXISTS [560_proj_Group09].School
DROP TABLE IF EXISTS [560_proj_Group09].ConferenceSeason
DROP TABLE IF EXISTS [560_proj_Group09].Season
DROP TABLE IF EXISTS [560_proj_Group09].Conference

-- create tables
CREATE TABLE [560_proj_Group09].Sport
(
    SportName NVARCHAR(32) NOT NULL PRIMARY KEY
);

CREATE TABLE [560_proj_Group09].School
(
    SchoolName NVARCHAR(128) NOT NULL PRIMARY KEY
);

CREATE TABLE [560_proj_Group09].Coach
(
    CoachID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(128) NOT NULL,
    Hometown NVARCHAR(128) NOT NULL
);

CREATE TABLE [560_proj_Group09].Player
(
    PlayerID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(128) NOT NULL, 
    PrimaryPosition NVARCHAR(128) NOT NULL, 
    Hometown NVARCHAR(128) NOT NULL
);

CREATE TABLE [560_proj_Group09].Conference
(
    ConferenceName INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    [Name] NVARCHAR(128) NOT NULL,
    ShortName NVARCHAR(32) NOT NULL,

    UNIQUE
    (
        [Name],
        ShortName
    )
);

CREATE TABLE [560_proj_Group09].Season
(
    SeasonID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    [Year] INT NOT NULL, -- TODO: do we want to keep this as year? or use datetimeoffset

    UNIQUE
    (
        [Year]
    )
);

CREATE TABLE [560_proj_Group09].Team
(
    TeamID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    SportName NVARCHAR(32) NOT NULL FOREIGN KEY
        REFERENCES [560_proj_Group09].Sport(SportName),
    SchoolName NVARCHAR(128) NOT NULL FOREIGN KEY
        REFERENCES [560_proj_Group09].School(SchoolName),
);

CREATE TABLE [560_proj_Group09].ConferenceSeason
(
    ConferenceSznID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    ConferenceID INT NOT NULL FOREIGN KEY 
        REFERENCES [560_proj_Group09].Conference(ConferenceName),
    SeasonID INT NOT NULL FOREIGN KEY
        REFERENCES [560_proj_Group09].Season(SeasonID),

    -- TODO: Figure out how to do composite key for ConferenceID and SeasonID
);

CREATE TABLE [560_proj_Group09].TeamSeason
(
    TeamSznID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    TeamID INT NOT NULL FOREIGN KEY
        REFERENCES [560_proj_Group09].Team(TeamID),
    ConferenceSznID INT NOT NULL FOREIGN KEY
        REFERENCES [560_proj_Group09].ConferenceSeason(ConferenceSznID)

    -- TODO: figure out how to do composite key for TeamID and ConferenceSznID
);

CREATE TABLE [560_proj_Group09].TeamSeasonCoach
(
    TeamSznCoachID INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    CoachID INT NOT NULL FOREIGN KEY   
        REFERENCES [560_proj_Group09].Coach(CoachID),
    TeamSznID INT NOT NULL FOREIGN KEY
        REFERENCES [560_proj_Group09].TeamSeason(TeamSznID),
    Title NVARCHAR(128) NOT NULL,
    Position NVARCHAR(128) NOT NULL
);

CREATE TABLE [560_proj_Group09].TeamSeasonPlayer
(
    TeamSznPlayerID INT NOT NULL IDENTITY(1,1) PRIMARY KEY
    PlayerID INT NOT NULL FOREIGN KEY
        REFERENCES [560_proj_Group09].Player(PlayerID),
    TeamSznID INT NOT NULL FOREIGN KEY
        REFERENCES [560_proj_Group09].TeamSeason(TeamSznID),
    [Number] NVARCHAR(2) NOT NULL,
    Position NVARCHAR(128) NOT NULL,
    YearInSchool NVARCHAR(8) NOT NULL,
    [Weight] INT NOT NULL,
    Height INT NOT NULL
);

GO
