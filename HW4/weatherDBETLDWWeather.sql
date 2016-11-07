Use dwweatherevents
go
ALTER TABLE dimcities drop constraint FK_DimCities_DimCountry
ALTER TABLE dbo.factweather drop constraint FK_factweather_DimCities
ALTER TABLE dbo.factweather drop constraint FK_FactWeather_DimDates
go
truncate table dbo.dimdates
truncate table dbo.dimcountry
truncate table dbo.dimcities
truncate table dbo.factweather
go
use weatherDB
go
insert into [dwweatherevents].[dbo].[dimcountry]
Select
 countryid = cast( [Country_Code] as nchar(2)),
 countryname = cast(CountryName as nvarchar(50))
 from Country
go
insert into dwweatherevents.dbo.dimcities
Select
cityid = cast(City_Code as nchar(4)),
CityName = cast(cityname as nvarchar(50)),
countrykey = dwweatherevents.dbo.dimcountry.countrykey
from City
join dwweatherevents.dbo.dimcountry on Country_Code = dwweatherevents.dbo.dimcountry.countryid
use dwweatherevents
go
Declare @startDate datetime = '01/01/2010'
Declare @endDate datetime = '12/31/2012'
Declare @i datetime
Set @i = @startDate
While @i <= @endDate
Begin
	Insert into dbo.dimdates (
		Date,
		datename,
		month,
		monthname,
		quarter,
		quartername,
		year,
		yearname
	) values (
		@i,
		Convert(nvarchar(50), @i, 110) + ',' + DateName(weekday,@i),
		Month(@i),
		DateName(month,@i),
		DateName(quarter, @i),
		'Q' + DateName(quarter, @i),
		Year(@i),
		Cast(Year(@i) as nvarchar(50))
	)
	Set @i = DateAdd (d, 1, @i)
End
go
use weatherDB
go
insert into dwweatherevents.dbo.factweather
select 
[weathernumber] = cast(Number as int),
[citykey] = dwweatherevents.dbo.dimcities.citykey,
[datekey] = dwweatherevents.dbo.dimdates.datekey,
[maxtemp] = cast(MaxTemperature as decimal(18,4)),
[mintemp] = cast(MinTemperature as decimal(18,4))
from Weather
join dwweatherevents.dbo.dimcities on City_Code = dwweatherevents.dbo.dimcities.cityid
join dwweatherevents.dbo.dimdates on weatherDB.dbo.Weather.Date = dwweatherevents.dbo.dimdates.date
go
use dwweatherevents
go
alter table dbo.dimcities with check add constraint [FK_DimCities_DimCountry] foreign key([countrykey]) 
references [dbo].[dimcountry] ([countrykey])
alter table [dbo].[factweather] with check add constraint [FK_factweather_DimCities] foreign key ([citykey])
references [dbo].[dimcities] ([citykey])
alter table [dbo].[factweather] with check add constraint [FK_FactWeather_DimDates] FOREIGN KEY ([DateKey])
REFERENCES [dbo].[dimdates] ([DateKey])