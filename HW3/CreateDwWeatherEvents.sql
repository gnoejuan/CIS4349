use master
go
if exists(select * from sys.databases where name = N'DWWeatherEvents')
Begin
	Alter database dwweatherevents set single_user with rollback immediate
	drop database dwweatherevents
end
go
create database dwweatherevents
go
use dwweatherevents
go
create table [dbo].[dimcountry](
[countrykey] int not null primary key identity,
[countryid] nchar(2) not null,
[countryname] nvarchar(50) not null
)
create table [dbo].[dimcities](
[citykey] int not null primary key identity,
[cityid] nchar(4) not null,
[cityname] nvarchar(50) not null,
[countrykey] int not null,
constraint [FK_DimCities_DimCountry] foreign key([countrykey]) 
references [dbo].[dimcountry] ([countrykey])
)
create table [dbo].[dimdates](
[datekey] int not null primary key identity,
[date] datetime not null,
[datename] nvarchar(50) not null,
[month] int not null,
[monthname] nvarchar(50) not null,
[quarter] int not null,
[quartername] nvarchar(50) not null,
[year] int not null,
[yearname] nvarchar(50) not null
)
create table [dbo].[factweather](
[weathernumber] int not null,
[citykey] int not null,
[datekey] int not null,
[maxtemp] decimal(18,4),
[mintemp] decimal(18,4)
constraint [pk_factsweather] primary key clustered ([weathernumber] asc, [citykey] asc, [datekey] asc) 
)
alter table [dbo].[factweather] with check add constraint [FK_factweather_DimCities] foreign key ([citykey])
references [dbo].[dimcities] ([citykey])
alter table [dbo].[factweather] with check add constraint [FK_FactWeather_DimDates] FOREIGN KEY ([DateKey])
REFERENCES [dbo].[dimdates] ([DateKey])