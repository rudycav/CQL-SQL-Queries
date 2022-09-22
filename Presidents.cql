#Load Positions.csv
LOAD CSV WITH HEADERS FROM 'file:///Positions.csv' AS row
WITH toInteger(row.Established) AS Established, toInteger(row.Removed) 
AS Removed, toInteger(row.DateRenamed) AS DateRenamed, row.Appointment 
AS Appointment, row.CabinetLevel AS CabinetLevel, row.Department 
AS Department, row.FormerDateRenamed AS FormerDateRenamed, row.FormerName as FormerName
CREATE (p:Position {Department: Department})
  SET p.Established=Established, p.Removed=Removed, p.DateRenamed=DateRenamed, p.Appointment=Appointment, 
  p.CabinetLevel=CabinetLevel, p.Department=Department, p.FormerDateRenamed=FormerDateRenamed, p.FormerName=FormerName
RETURN count(p);


#Load Appts-Fixed.csv
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


'1. return all appointments made in Clinton's administration'

MATCH(a:Appointee{Administration:'Clinton'})-[r:HAS_POSITION]->(p:Position)
RETURN DISTINCT p.Appointment
