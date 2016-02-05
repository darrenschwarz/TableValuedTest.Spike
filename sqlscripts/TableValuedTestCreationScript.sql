USE [master]
GO

/****** Object:  Database [TableValuedTest]    Script Date: 05/02/2016 00:17:33 ******/
CREATE DATABASE [TableValuedTest]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TableValuedTest', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL\MSSQL\DATA\TableValuedTest.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TableValuedTest_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQL\MSSQL\DATA\TableValuedTest_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

ALTER DATABASE [TableValuedTest] SET COMPATIBILITY_LEVEL = 110
GO

IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TableValuedTest].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO

ALTER DATABASE [TableValuedTest] SET ANSI_NULL_DEFAULT OFF 
GO

ALTER DATABASE [TableValuedTest] SET ANSI_NULLS OFF 
GO

ALTER DATABASE [TableValuedTest] SET ANSI_PADDING OFF 
GO

ALTER DATABASE [TableValuedTest] SET ANSI_WARNINGS OFF 
GO

ALTER DATABASE [TableValuedTest] SET ARITHABORT OFF 
GO

ALTER DATABASE [TableValuedTest] SET AUTO_CLOSE OFF 
GO

ALTER DATABASE [TableValuedTest] SET AUTO_SHRINK OFF 
GO

ALTER DATABASE [TableValuedTest] SET AUTO_UPDATE_STATISTICS ON 
GO

ALTER DATABASE [TableValuedTest] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO

ALTER DATABASE [TableValuedTest] SET CURSOR_DEFAULT  GLOBAL 
GO

ALTER DATABASE [TableValuedTest] SET CONCAT_NULL_YIELDS_NULL OFF 
GO

ALTER DATABASE [TableValuedTest] SET NUMERIC_ROUNDABORT OFF 
GO

ALTER DATABASE [TableValuedTest] SET QUOTED_IDENTIFIER OFF 
GO

ALTER DATABASE [TableValuedTest] SET RECURSIVE_TRIGGERS OFF 
GO

ALTER DATABASE [TableValuedTest] SET  DISABLE_BROKER 
GO

ALTER DATABASE [TableValuedTest] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO

ALTER DATABASE [TableValuedTest] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO

ALTER DATABASE [TableValuedTest] SET TRUSTWORTHY OFF 
GO

ALTER DATABASE [TableValuedTest] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO

ALTER DATABASE [TableValuedTest] SET PARAMETERIZATION SIMPLE 
GO

ALTER DATABASE [TableValuedTest] SET READ_COMMITTED_SNAPSHOT OFF 
GO

ALTER DATABASE [TableValuedTest] SET HONOR_BROKER_PRIORITY OFF 
GO

ALTER DATABASE [TableValuedTest] SET RECOVERY FULL 
GO

ALTER DATABASE [TableValuedTest] SET  MULTI_USER 
GO

ALTER DATABASE [TableValuedTest] SET PAGE_VERIFY CHECKSUM  
GO

ALTER DATABASE [TableValuedTest] SET DB_CHAINING OFF 
GO

ALTER DATABASE [TableValuedTest] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO

ALTER DATABASE [TableValuedTest] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO

ALTER DATABASE [TableValuedTest] SET  READ_WRITE 
GO


USE TableValuedTest;
GO

/*==============================================
Create example TableType, and Store Procedure
================================================*/
/* Create a table type for staffIds. */
CREATE TYPE StaffIdTableType AS TABLE 
( StaffId VARCHAR(50));
GO

/* A simple example procedure to receive our ProjectUID, and StaffIdTableType parameter for staffIds.
 Obvously this massively simplifies the implementation of the search internals :) */
CREATE PROCEDURE dbo.usp_SearchStaffIds
    @ProjectUID int, 
    @TvpStaffIDS StaffIdTableType READONLY
    AS 
    SET NOCOUNT ON
    
	SELECT
		@ProjectUID As AProjectUID, --this is just to demonstrate we are using @ProjectUID 
		'AName' As Name, 
		'ACountry' As Country,  
		'AnEmail' As Email,  
		'AStatus' As Status,   
		StaffId, 
		'APhotoUri' As PhotoUri,
		'AWaveUID' As WaveUID,
		'AWaveName' As WaveName,
		'AWaveUserUID' As WaveUserUID,
		'ADisplayTab' As DisplayTab		
    FROM  @TvpStaffIDS;