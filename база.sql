USE [master]
GO
/****** Object:  Database [АбонентыИС-319]    Script Date: 21.12.2021 11:36:14 ******/
CREATE DATABASE [АбонентыИС-319]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'АбонентыИС-319', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\АбонентыИС-319.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'АбонентыИС-319_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\АбонентыИС-319_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [АбонентыИС-319] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [АбонентыИС-319].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [АбонентыИС-319] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [АбонентыИС-319] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [АбонентыИС-319] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [АбонентыИС-319] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [АбонентыИС-319] SET ARITHABORT OFF 
GO
ALTER DATABASE [АбонентыИС-319] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [АбонентыИС-319] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [АбонентыИС-319] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [АбонентыИС-319] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [АбонентыИС-319] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [АбонентыИС-319] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [АбонентыИС-319] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [АбонентыИС-319] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [АбонентыИС-319] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [АбонентыИС-319] SET  DISABLE_BROKER 
GO
ALTER DATABASE [АбонентыИС-319] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [АбонентыИС-319] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [АбонентыИС-319] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [АбонентыИС-319] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [АбонентыИС-319] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [АбонентыИС-319] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [АбонентыИС-319] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [АбонентыИС-319] SET RECOVERY FULL 
GO
ALTER DATABASE [АбонентыИС-319] SET  MULTI_USER 
GO
ALTER DATABASE [АбонентыИС-319] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [АбонентыИС-319] SET DB_CHAINING OFF 
GO
ALTER DATABASE [АбонентыИС-319] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [АбонентыИС-319] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [АбонентыИС-319] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'АбонентыИС-319', N'ON'
GO
ALTER DATABASE [АбонентыИС-319] SET QUERY_STORE = OFF
GO
USE [АбонентыИС-319]
GO
/****** Object:  Table [dbo].[Тарифы]    Script Date: 21.12.2021 11:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Тарифы](
	[Цена_тарифа] [int] NULL,
	[Код_абонента] [int] NULL,
	[Номер_телефона] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Абоненты]    Script Date: 21.12.2021 11:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Абоненты](
	[Код_абонента] [int] NULL,
	[ФИО] [nvarchar](50) NULL,
	[Адрес] [nchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Телефоны абонентов]    Script Date: 21.12.2021 11:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Телефоны абонентов](
	[Код_телефона] [nchar](10) NULL,
	[Код_абонента] [nchar](10) NULL,
	[Номер_договора] [nchar](10) NULL,
	[Дата_установки] [nchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Разговоры]    Script Date: 21.12.2021 11:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Разговоры](
	[Код_разговора] [nchar](10) NULL,
	[Код_телефона] [nchar](10) NULL,
	[Город_звонящего] [nchar](10) NULL,
	[Город_принимающего] [nchar](10) NULL,
	[Продолжительность] [nchar](10) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Город]    Script Date: 21.12.2021 11:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Город](
	[Код_города] [int] NOT NULL,
	[Цена_тарифа] [int] NOT NULL,
	[Название] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[Статистика_разговоров]    Script Date: 21.12.2021 11:36:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[Статистика_разговоров]
AS
SELECT        dbo.Абоненты.ФИО, dbo.Тарифы.Номер_телефона
FROM            dbo.Абоненты CROSS JOIN
                         dbo.Город CROSS JOIN
                         dbo.Разговоры CROSS JOIN
                         dbo.Тарифы CROSS JOIN
                         dbo.[Телефоны абонентов]
GO
INSERT [dbo].[Абоненты] ([Код_абонента], [ФИО], [Адрес]) VALUES (4, N'Титова Александра Ивановна', N'          ')
GO
INSERT [dbo].[Город] ([Код_города], [Цена_тарифа], [Название]) VALUES (3, 20, N'Воронеж')
INSERT [dbo].[Город] ([Код_города], [Цена_тарифа], [Название]) VALUES (1, 10, N'Омск')
INSERT [dbo].[Город] ([Код_города], [Цена_тарифа], [Название]) VALUES (4, 10, N'Новосибирск')
INSERT [dbo].[Город] ([Код_города], [Цена_тарифа], [Название]) VALUES (2, 30, N'Москва')
INSERT [dbo].[Город] ([Код_города], [Цена_тарифа], [Название]) VALUES (5, 30, N'Санкт-Петербург')
INSERT [dbo].[Город] ([Код_города], [Цена_тарифа], [Название]) VALUES (3, 30, N'Воронеж')
GO
INSERT [dbo].[Разговоры] ([Код_разговора], [Код_телефона], [Город_звонящего], [Город_принимающего], [Продолжительность]) VALUES (N'4         ', NULL, NULL, NULL, N'5         ')
INSERT [dbo].[Разговоры] ([Код_разговора], [Код_телефона], [Город_звонящего], [Город_принимающего], [Продолжительность]) VALUES (N'7         ', NULL, NULL, NULL, N'10        ')
INSERT [dbo].[Разговоры] ([Код_разговора], [Код_телефона], [Город_звонящего], [Город_принимающего], [Продолжительность]) VALUES (N'2         ', NULL, NULL, NULL, N'2         ')
INSERT [dbo].[Разговоры] ([Код_разговора], [Код_телефона], [Город_звонящего], [Город_принимающего], [Продолжительность]) VALUES (N'8         ', NULL, NULL, NULL, N'3         ')
INSERT [dbo].[Разговоры] ([Код_разговора], [Код_телефона], [Город_звонящего], [Город_принимающего], [Продолжительность]) VALUES (N'11        ', NULL, NULL, NULL, N'3         ')
INSERT [dbo].[Разговоры] ([Код_разговора], [Код_телефона], [Город_звонящего], [Город_принимающего], [Продолжительность]) VALUES (NULL, NULL, NULL, NULL, N'1         ')
INSERT [dbo].[Разговоры] ([Код_разговора], [Код_телефона], [Город_звонящего], [Город_принимающего], [Продолжительность]) VALUES (N'1         ', NULL, NULL, NULL, N'12        ')
INSERT [dbo].[Разговоры] ([Код_разговора], [Код_телефона], [Город_звонящего], [Город_принимающего], [Продолжительность]) VALUES (N'5         ', NULL, NULL, NULL, N'10        ')
INSERT [dbo].[Разговоры] ([Код_разговора], [Код_телефона], [Город_звонящего], [Город_принимающего], [Продолжительность]) VALUES (N'10        ', NULL, NULL, NULL, N'3         ')
INSERT [dbo].[Разговоры] ([Код_разговора], [Код_телефона], [Город_звонящего], [Город_принимающего], [Продолжительность]) VALUES (N'9         ', NULL, NULL, NULL, N'6         ')
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Абоненты"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 212
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Город"
            Begin Extent = 
               Top = 6
               Left = 250
               Bottom = 119
               Right = 424
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Разговоры"
            Begin Extent = 
               Top = 120
               Left = 38
               Bottom = 250
               Right = 254
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Тарифы"
            Begin Extent = 
               Top = 6
               Left = 462
               Bottom = 119
               Right = 647
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Телефоны абонентов"
            Begin Extent = 
               Top = 120
               Left = 292
               Bottom = 250
               Right = 475
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
        ' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Статистика_разговоров'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N' Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Статистика_разговоров'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'Статистика_разговоров'
GO
USE [master]
GO
ALTER DATABASE [АбонентыИС-319] SET  READ_WRITE 
GO
