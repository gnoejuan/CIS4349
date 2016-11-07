USE [master]
GO

IF  EXISTS (SELECT name FROM sys.databases WHERE name = N'weatherDB')

  BEGIN

    ALTER DATABASE [weatherDB] SET  SINGLE_USER WITH ROLLBACK IMMEDIATE

    DROP DATABASE [weatherDB]

  END

GO

/****** Object:  Database [weatherDB]    ******/
CREATE DATABASE [weatherDB]
GO

USE [weatherDB]
GO

/****** Create the Weather Table ******/
CREATE TABLE [dbo].[Weather](
    [Number] int NOT NULL,
	[Date] [datetime] NOT NULL,
	[MaxTemperature] [decimal](18,2),
	[MinTemperature] [decimal](18,2),
	[Humidity] [decimal](18,2),
	[City_Code] [nchar](3),
 CONSTRAINT [PK_Weather] PRIMARY KEY CLUSTERED 
(
	[Number] ASC
)) 

/****** Create the City Tables ******/
CREATE TABLE [dbo].[City](
	[City_Code] [nchar](3) NOT NULL,
	[CityName] [nvarchar](50),
	[Country_Code] [nchar](2),
 CONSTRAINT [PK_City] PRIMARY KEY CLUSTERED 
(
	[City_Code] ASC
)) 

/****** Create the Country Tables ******/
CREATE TABLE [dbo].[Country](
	[Country_Code] [nchar](2) NOT NULL,
	[CountryName] [nvarchar](50),
 CONSTRAINT [PK_Country] PRIMARY KEY CLUSTERED 
(
	[Country_Code] ASC
)) 

-- Creating the weatherDB foreign key constraints

ALTER TABLE [dbo].[Weather]  WITH CHECK ADD  CONSTRAINT [FK_Weather_City] FOREIGN KEY([City_Code])
REFERENCES [dbo].[City] ([City_Code])
GO

ALTER TABLE [dbo].[City]  WITH CHECK ADD  CONSTRAINT [FK_City_Country] FOREIGN KEY([Country_Code])
REFERENCES [dbo].[Country] ([Country_Code])
GO

-- Insert data into weatherDB 
Insert into Country Values('US','United States of America')
Insert into Country Values('FR','France')
Insert into Country Values('JP','Japan')
Insert into Country Values('CN','China')

Insert into City Values('NYC','New York City','US')
Insert into City Values('LA','Los Angles', 'US')
Insert into City Values('PAR','Paris', 'FR')
Insert into City Values('TY','Tokyo','JP')
Insert into City Values('PK','Peking','CN')

Insert into Weather Values(11,'01-01-2010',68.48,48.65,0,'NYC')
Insert into Weather Values(12,'01-02-2010',57.65,43.54,16,'LA')
Insert into Weather Values(13,'01-03-2010',48.48,35.65,80,'PK')
Insert into Weather Values(14,'01-04-2010',38.48,18.65,70,'TY')
Insert into Weather Values(15,'01-05-2010',68.48,54.65,0,'NYC')
Insert into Weather Values(16,'01-06-2010',68.48,48.65,0,'NYC')
Insert into Weather Values(17,'01-07-2010',58.48,40.65,0,'PAR')
Insert into Weather Values(18,'01-08-2010',65.48,50.65,15,'LA')
Insert into Weather Values(19,'01-09-2010',68.48,48.65,0,'NYC')
Insert into Weather Values(20,'01-10-2010',74.48,50.65,0,'NYC')
Insert into Weather Values(21,'01-11-2010',55.42,42.65,40,'PAR')
Insert into Weather Values(22,'01-12-2010',75.43,30.1,0,'PK')
Insert into Weather Values(25,'01-13-2010',68.48,48.5,0,'TY')
Insert into Weather Values(26,'01-14-2010',55.42,48.6,0,'LA')
Insert into Weather Values(27,'01-15-2010',68.48,48.65,20,'NYC')
Insert into Weather Values(30,'01-16-2010',68.48,48.6,0,'PAR')
Insert into Weather Values(31,'01-17-2010',75.43,48.65,20,'NYC')
Insert into Weather Values(32,'01-18-2010',55.42,48.5,15,'NYC')
Insert into Weather Values(33,'01-19-2010',68.48,48.1,0,'LA')
Insert into Weather Values(34,'01-20-2010',68.48,48.65,0,'PK')
Insert into Weather Values(35,'01-21-2010',68.48,48.5,0,'TY')
Insert into Weather Values(36,'01-22-2010',55.42,48.65,0,'PAR')
Insert into Weather Values(37,'01-23-2010',75.43,48.5,0,'LA')
Insert into Weather Values(38,'01-24-2010',68.48,48.65,0,'NYC')
Insert into Weather Values(39,'01-25-2010',68.48,48.5,0,'NYC')
Insert into Weather Values(40,'01-26-2010',55.42,48.65,0,'NYC')
Insert into Weather Values(41,'01-27-2010',68.48,48.5,0,'LA')
Insert into Weather Values(42,'01-28-2010',75.43,48.5,0,'PAR')
Insert into Weather Values(43,'01-29-2010',68.48,48.5,0,'PK')
Insert into Weather Values(44,'01-30-2010',55.42,48.5,0,'TY')
Insert into Weather Values(45,'01-31-2010',68.48,48.65,0,'LA')
Insert into Weather Values(46,'02-01-2010',68.48,48.65,0,'PAR')
Insert into Weather Values(47,'02-02-2010',57.65,43.54,16,'LA')
Insert into Weather Values(48,'02-03-2010',75.43,48.4,0,'NYC')
Insert into Weather Values(49,'02-04-2010',55.42,48.5,0,'NYC')
Insert into Weather Values(111,'02-05-2011',68.48,40.65,0,'TY')
Insert into Weather Values(112,'02-06-2011',68.48,48.65,0,'PAR')
Insert into Weather Values(113,'02-07-2011',68.48,48.65,50,'LA')
Insert into Weather Values(116,'02-08-2011',55.42,28.65,0,'PK')
Insert into Weather Values(117,'02-09-2011',75.43,48.65,30,'TY')
Insert into Weather Values(118,'02-10-2011',68.48,40.65,0,'LA')
Insert into Weather Values(119,'02-11-2011',68.48,48.65,60,'PAR')
Insert into Weather Values(120,'02-12-2011',55.42,50.65,30,'PK')
Insert into Weather Values(121,'02-13-2010',68.48,55.65,20,'TY')
Insert into Weather Values(122,'02-14-2010',75.43,60.65,10,'NYC')
Insert into Weather Values(124,'02-15-2010',68.48,40.65,20,'LA')
Insert into Weather Values(127,'02-16-2010',55.42,31.65,10,'PAR')
Insert into Weather Values(128,'02-17-2010',68.48,55,10,'PK')
Insert into Weather Values(129,'02-18-2010',68.48,43.8,40,'PK')
Insert into Weather Values(139,'02-19-2010',75.43,49.65,0,'PAR')
Insert into Weather Values(991,'02-20-2012',55.42,41.65,0,'LA')
Go

Select [Message] = 'The weatherDB is now created'