backup database dwweatherevents
to disk = 'c:\data\DWWeatherEvents.bak'
go
if exists(select * from sys.databases where name = 'dwweatherevents')
Begin
	alter database dwweatherevents set single_user with rollback immediate
end
use master
restore database dwweatherevents
from disk = 'c:\data\DWWeatherEvents.bak'
with replace
go