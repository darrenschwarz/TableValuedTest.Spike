# TableValuedTest.Spike
A simple proposed implementation for our bulk search story.

===========================================
Setup
===========================================
Run TableValuedTestCreationScript.sql against your instance of sql server.

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

StaffId ProjectUID  RequestedDate

11111	  1	          2016-02-05 00:28:36.407

22222	  1	          2016-02-05 00:28:36.407

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

11111	1	05/02/2016 00:43:12

22222	1	05/02/2016 00:43:12

33333	1	05/02/2016 00:43:12

44444	1	05/02/2016 00:43:12

55555	1	05/02/2016 00:43:12
