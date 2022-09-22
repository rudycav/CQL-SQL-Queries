'Find all records for the city of Tolland'
>db.zips.find( { city: "TOLLAND" } )


'Find the records for both Tolland and Berlin'
> db.zips.find({city: {$in: ["TOLLAND", "BERLIN"]}})


'Find the record for  Tolland, CT'
> db.zips.find( { city: "TOLLAND", state: "CT" } )


'Return just the zip code  and population for Tolland, CT'
> db.zips.find( { city: "TOLLAND", state: "CT" }, { _id: 1, pop:1 } )


'Return just the zip code for Tolland, CT'
> db.zips.find( { city: "TOLLAND", state: "CT" }, { _id: 1 } )


'Return records where one of the  elements of the location array is 37.80835'
> db.zips.find({"loc": 37.80835})


'Return records where one of the elements of the location array is between 42.6 and 42.8'
> db.zips.find({loc:{$elemMatch: {$gte:42.6, $lte:42.8}}})


'Return records where the second element of the location array is greater than 60'
> db.zips.find({"loc": {$gte: 60}}, {zips : {$slice: 1}})


'Write a query that returns documents for all cities in Kentucky, sorted by city name'
> db.zips.find({"state": "KY"}).sort({"city": 1})


