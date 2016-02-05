# TableValuedTest.Spike
TableValuedTest Spike - A simple example of proposed implementation for our bulk search story.

<b>Setup<b/>

Run TableValuedTestCreationScript.sql
 
<b>Test Stored Procedure in SSMS<b/>
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

Which should give you back:

StaffId ProjectUID  RequestedDate

11111	  1	          2016-02-05 00:28:36.407

22222	  1	          2016-02-05 00:28:36.407
