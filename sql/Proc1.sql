create proc editarPersonal
@ID_Personal int,
@Nombres as varchar(max),
@Identificacion varchar(max),
@Pais varchar(max),
@ID_Cargo int,
@Sueldo_Por_Hora numeric (18,2)
as 
if Exists(Select Identificacion From Personal where Identificacion=@Identificacion and ID_Personal<>@ID_Personal)
Raiserror('Ya existe un registro con esta identificacion',16,1)
else
Update Personal set	
Nombres=@Nombres, Identificacion=@Identificacion, Pais=@Pais, ID_Cargo=@ID_Cargo, SueldoPorHora=@Sueldo_Por_Hora
where ID_Personal=@ID_Personal