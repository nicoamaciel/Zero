create proc mostrarPersonal
@Desde int,
@Hasta int
as
Set Nocount on;
Select 
ID_Personal,Nombres,Identificacion,SueldoPorHora,Cargo,ID_Cargo,Estado,Codigo
from 
(Select ID_Personal,Nombres,Identificacion,Personal.SueldoPorHora, Cargo.Cargo, Personal.ID_Cargo,Estado,Codigo, 
Row_Number() Over(Order by ID_Personal) 'Numero_de_fila'
From Personal
inner join Cargo on Cargo.ID_Cargo = Personal.ID_Cargo) as Paginado
where(Paginado.Numero_de_fila >= @Desde) and (Paginado.Numero_de_fila<=@Hasta)



