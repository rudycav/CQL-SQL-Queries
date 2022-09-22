--Load Positions.csv
LOAD CSV WITH HEADERS FROM 'file:///Positions.csv' AS row
WITH toInteger(row.Established) AS Established, toInteger(row.Removed) 
AS Removed, toInteger(row.DateRenamed) AS DateRenamed, row.Appointment 
AS Appointment, row.CabinetLevel AS CabinetLevel, row.Department 
AS Department, row.FormerDateRenamed AS FormerDateRenamed, row.FormerName as FormerName
CREATE (p:Position {Department: Department})
  SET p.Established=Established, p.Removed=Removed, p.DateRenamed=DateRenamed, p.Appointment=Appointment, 
  p.CabinetLevel=CabinetLevel, p.Department=Department, p.FormerDateRenamed=FormerDateRenamed, p.FormerName=FormerName
RETURN count(p);


--Load Appts-Fixed.csv
LOAD CSV WITH HEADERS FROM 'file:///Appts-Fixed.csv' AS row
WITH toInteger(row.Gender) AS Gender, toInteger(row.ForeignBorn) AS ForeignBorn, toInteger(row.Minority) 
AS Minority, toInteger(row.DiedOffice) AS DiedOffice, toInteger(row.Key) AS Key, (row.Administration) 
AS Administration, (row.Party) AS Party, row.Department AS Department, row.Name AS Name, row.LastName 
AS LastName, date(row.ServiceStart) AS ServiceStart, date(row.ServiceEnd) AS ServiceEnd, row.ScandalDesc 
AS ScandalDesc, row.EduDesc AS EduDesc, (row.MilitaryService) AS MilitaryService, (row.MilitaryDatesServed) 
AS MilitaryDatesServed, (row.MilitaryBranch) AS MilitaryBranch, (row.SenateVotesFor) AS SenateVotesFor, (row.SenateVotesAgainst) 
AS SenateVotesAgainst, (row.Law) AS Law
MERGE (a:Appointee {Key: Key})
    SET a.Gender=Gender, a.ForeignBorn=ForeignBorn, a.Minority=Minority, a.DiedOffice=DiedOffice, a.Key=Key, a.Administration=Administration, 
    a.Party=Party, a.Department=Department, a.Name=Name, a.LastName=LastName, a.ServiceStart=ServiceStart, a.ServiceEnd=ServiceEnd, a.ScandalDesc=ScandalDesc, 
    a.EduDesc=EduDesc, a.MilitaryService=MilitaryService, a.MilitaryDatesServed=MilitaryDatesServed, a.MilitaryBranch=MilitaryBranch, a.SenateVotesFor=SenateVotesFor, 
    a.SenateVotesAgainst=SenateVotesAgainst, a.Law=Law
RETURN count(a)


--1. return all appointments made in Clinton's administration
MATCH(a:Appointee{Administration:'Clinton'})-[r:HAS_POSITION]->(p:Position)
RETURN DISTINCT p.Appointment


--2. return all the name, position, start date, end date, and college for all female cabinet appointments
MATCH (a:Appointee{Gender:0})-[r:HAS_POSITION]->(p:Position)
RETURN a.Name, a.Department, a.ServiceStart, a.ServiceEnd, a.EduDes


--3. return the name, start date and administration for all  postmaster generals from 1850 to 1950
MATCH (a:Appointee)-[r:HAS_POSITION]->(p:Position {Appointment:'Postmaster General'})
WHERE a.ServiceStart > date("1850-01-01") AND a.ServiceStart < date("1950-01-01")
RETURN a.Name, a.ServiceStart, a.Administration
ORDER BY a.ServiceStart


--4. return all appointments in positions established after 1990
MATCH (a:Appointee)-[r:HAS_POSITION]->(p:Position)
WHERE p.Established > 1990
RETURN DISTINCT p.Appointment, p.Established
ORDER BY p.Established


--5. Return all appointments in positions that have been renamed 
MATCH (a:Appointee)-[r:HAS_POSITION]->(p:Position)
WHERE EXISTS (p.DateRenamed)
RETURN DISTINCT p.Appointment


--6. Return all appointments and the department name where the position name contains LABOR 
MATCH (a:Appointee)-[r:HAS_POSITION]->(p:Position)
WHERE a.Department CONTAINS 'Labor'
RETURN DISTINCT p.Appointment, p.Department


--7. return the appointment name, position, administration and year the position was established, ordered by the year established 
MATCH (a:Appointee)-[r:HAS_POSITION]->(p:Position)
RETURN DISTINCT p.Appointment, a.Department, a.Administration, p.Established
ORDER BY p.Established


--8. return a count of appointments for people who served in the navy
MATCH (a:Appointee {MilitaryBranch:'Navy'})-[r:HAS_POSITION]->(p:Position)
RETURN count(DISTINCT p.Appointment)


--9. return the number of women in appointments grouped by department 
MATCH (a:Appointee{Gender:0})-[r:HAS_POSITION]->(p:Position)
RETURN count(a.Department), a.Gender


--10. Return the number of appointees who served in military grouped by service branch
MATCH (a:Appointee)-[r:HAS_POSITION]->(p:Position)
WHERE NOT a.MilitaryBranch = ""
RETURN count(DISTINCT a.Name), a.MilitaryBranch







