create proc InsertarPersonal
@Nombres varchar(MAX),
@Identificacion varchar(MAX),
@Pais varchar(MAX),
@ID_Cargo int,
@SueldoPorHora numeric(18,2)
as
declare @Estado varchar(MAX)
declare @Codigo varchar(MAX)
declare @ID_Personal int
set @Estado = 'Activo'
set @Codigo ='-'
if Exists(select Identificacion from Personal where Identificacion=@Identificacion)
Raiserror('Ya existe un registro con esta Identificacion',16,1)
else
insert into Personal
values(@Nombres,
@Identificacion,
@Pais,
@ID_Cargo,
@SueldoPorHora,
@Estado,
@Codigo
)
Select @ID_Personal=scope_identity()
Update Personal set Codigo = @ID_Personal