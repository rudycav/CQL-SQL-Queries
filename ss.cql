
LOAD CSV WITH HEADERS FROM 'file:///Positions.csv' AS row
WITH toInteger(row.Established) AS Established, toInteger(row.Removed) 
AS Removed, toInteger(row.DateRenamed) AS DateRenamed, row.Appointment 
AS Appointment, row.CabinetLevel AS CabinetLevel, row.Department 
AS Department, row.FormerDateRenamed AS FormerDateRenamed, row.FormerName as FormerName
CREATE (p:Position {Department: Department})
  SET p.Established=Established, p.Removed=Removed, p.DateRenamed=DateRenamed, p.Appointment=Appointment, 
  p.CabinetLevel=CabinetLevel, p.Department=Department, p.FormerDateRenamed=FormerDateRenamed, p.FormerName=FormerName
RETURN count(p);
