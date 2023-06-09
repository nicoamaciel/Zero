USE [master]
GO
/****** Object:  Database [ProyectoZero]    Script Date: 4/20/2023 8:29:47 PM ******/
CREATE DATABASE [ProyectoZero]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ProyectoZero', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\ProyectoZero.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ProyectoZero_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\ProyectoZero_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [ProyectoZero] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ProyectoZero].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ProyectoZero] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ProyectoZero] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ProyectoZero] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ProyectoZero] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ProyectoZero] SET ARITHABORT OFF 
GO
ALTER DATABASE [ProyectoZero] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ProyectoZero] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ProyectoZero] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ProyectoZero] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ProyectoZero] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ProyectoZero] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ProyectoZero] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ProyectoZero] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ProyectoZero] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ProyectoZero] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ProyectoZero] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ProyectoZero] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ProyectoZero] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ProyectoZero] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ProyectoZero] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ProyectoZero] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ProyectoZero] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ProyectoZero] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ProyectoZero] SET  MULTI_USER 
GO
ALTER DATABASE [ProyectoZero] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ProyectoZero] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ProyectoZero] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ProyectoZero] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ProyectoZero] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ProyectoZero] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [ProyectoZero] SET QUERY_STORE = ON
GO
ALTER DATABASE [ProyectoZero] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [ProyectoZero]
GO
/****** Object:  Table [dbo].[Cargo]    Script Date: 4/20/2023 8:29:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cargo](
	[ID_Cargo] [int] IDENTITY(1,1) NOT NULL,
	[Cargo] [varchar](max) NULL,
	[SueldoPorHora] [numeric](18, 2) NULL,
 CONSTRAINT [PK_Cargo] PRIMARY KEY CLUSTERED 
(
	[ID_Cargo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Personal]    Script Date: 4/20/2023 8:29:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Personal](
	[ID_Personal] [int] IDENTITY(1,1) NOT NULL,
	[Nombres] [varchar](max) NULL,
	[Identificacion] [varchar](max) NULL,
	[Pais] [varchar](max) NULL,
	[ID_Cargo] [int] NULL,
	[SueldoPorHora] [numeric](18, 2) NULL,
	[Estado] [varchar](max) NULL,
	[Codigo] [varchar](max) NULL,
 CONSTRAINT [PK_Personal] PRIMARY KEY CLUSTERED 
(
	[ID_Personal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
ALTER TABLE [dbo].[Personal]  WITH CHECK ADD  CONSTRAINT [FK_Personal_Cargo] FOREIGN KEY([ID_Cargo])
REFERENCES [dbo].[Cargo] ([ID_Cargo])
GO
ALTER TABLE [dbo].[Personal] CHECK CONSTRAINT [FK_Personal_Cargo]
GO
/****** Object:  StoredProcedure [dbo].[editarPersonal]    Script Date: 4/20/2023 8:29:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[editarPersonal]
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
GO
/****** Object:  StoredProcedure [dbo].[InsertarPersonal]    Script Date: 4/20/2023 8:29:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[InsertarPersonal]
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
GO
/****** Object:  StoredProcedure [dbo].[mostrarPersonal]    Script Date: 4/20/2023 8:29:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[mostrarPersonal]
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
GO
USE [master]
GO
ALTER DATABASE [ProyectoZero] SET  READ_WRITE 
GO
