# TableValuedTest.Spike
A simple proposed implementation for our bulk search story. If we can agree on this aspect of the implementation, we can clearly dilineate the work. Lefkos and I can then concentrate on the front end through to stored procedure call.

===========================================
Setup
===========================================
Run TableValuedTestCreationScript.sql in the scripts folder against your instance of sql server.
NB. Check FILENAME path, ammend according to environment

===========================================
Test Stored Procedure in SSMS
===========================================
/* run in SSMS using TableValuedTest */    

USE TableValuedTest;

GO

/* Declare a variable that references the type. */

DECLARE @SearchStaffIdsTVP AS StaffIdTableType;

/* Add data to the table variable. */

INSERT INTO @SearchStaffIdsTVP (StaffId)
    SELECT '11111'

INSERT INTO @SearchStaffIdsTVP (StaffId)
    SELECT '22222'   

/* Pass the table variable data to a stored procedure. */

EXEC [dbo].[usp_SearchStaffIds] 1, @SearchStaffIdsTVP; 

===========================================
Stored Procedure result
===========================================
Which should give you back:

AProjectUID	Name	Country		Email	Status	StaffId	PhotoUri	WaveUID		WaveName	WaveUserUID		DisplayTab

1			AName	ACountry	AnEmail	AStatus	11111	APhotoUri	AWaveUID	AWaveName	AWaveUserUID	ADisplayTab

1			AName	ACountry	AnEmail	AStatus	22222	APhotoUri	AWaveUID	AWaveName	AWaveUserUID	ADisplayTab

===========================================
Calling Stored Procedure from .Net C# code
===========================================
1) Open TableValuedTest.Spike.sln

2) Right-Click TableValuedTest.Spike.csproj, and click "Manage Nuget Packages...", restore packages if neccessary.

3) Update app.config connectionStrings "TableValuedTest", to point at your instance of sql server.

4) Run [Test] DataTableTest in DataTableSpike.cs

===========================================
.Net C# code TableValuedTest result
===========================================
Which should give you back:

1	AName	ACountry	AnEmail	AStatus	11111	APhotoUri	AWaveUID	AWaveName	AWaveUserUID	ADisplayTab

1	AName	ACountry	AnEmail	AStatus	22222	APhotoUri	AWaveUID	AWaveName	AWaveUserUID	ADisplayTab

1	AName	ACountry	AnEmail	AStatus	33333	APhotoUri	AWaveUID	AWaveName	AWaveUserUID	ADisplayTab

1	AName	ACountry	AnEmail	AStatus	44444	APhotoUri	AWaveUID	AWaveName	AWaveUserUID	ADisplayTab

1	AName	ACountry	AnEmail	AStatus	55555	APhotoUri	AWaveUID	AWaveName	AWaveUserUID	ADisplayTab
