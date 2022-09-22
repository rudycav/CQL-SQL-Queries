//Return a list of all of the genre names
db.movies.distinct("genres")


//Write a query that searches for movies that contain the word “Kentucky” in any of these fields, using full text search.
db.movies.createIndex({title: "text", cast: "text", fullplot: "text"})
db.movies.find({$text: {$search: "Kentucky"}}, {_id: 0, title: 1, cast: 1, fullplot: 1})


//Return the title, year, and directors fields for movies directed by anyone whose first name is “John”
db.movies.createIndex({title: "text", year: "text", directors: "text"})
db.movies.find({$text: {$search: "John"}}, {_id: 0, title:1, directors: 1, year: 1})


//Return the count of the movies made in the year 2008
db.movies.count({"year": 2008})


//Return the average number of mflix comments, grouped by year. The results should be sorted in descending order by year.
var pipr = [{$group: {
  _id: "$year",
  Average: {
    $avg: "$num_mflix_comments"
  }
}}, {$sort: {
  "_id":-1
}}]
db.movies.aggregate(pipe)


//Write a pipeline on the movies collection that will return movies made after 2010 and their comments. Do the join using the _id field that identifies
'movie documents and the movie_id field in each comment document'
var pipeline = [{$sort: {
  year: -1
}}, {$match: {
  released: {$gte: new Date("2010-01-01T00:00: 00Z")}
}}, {$lookup: {
  from: 'comments',
  localField: '_id',
  foreignField: 'movie_id',
  as: 'comments'
}}, {$limit: 3}]
db.movies.aggregate(pipeline).forEach(printjson)


//Now add a project so that the results just contain the movie title and the array of comments
var pipeline = [{$sort: {
  year: -1
}}, {$match: {
  released: {$gte: new Date("2010-01-01T00:00: 00Z")}
}}, {$lookup: {
  from: 'comments',
  localField: '_id',
  foreignField: 'movie_id',
  as: 'comments'
}}, {$project: {
  "_id": 0, "title": 1, "comments": 1
}}]
db.movies.aggregate(pipeline)


//Change the pipeline so that only movies with at least one comment are returned.
var pipe = [{$match: {
  released: {$gte: new Date("2010-01-01T00:00: 00Z")}

}}, {$lookup: {
  from: 'comments',
  localField: '_id',
  foreignField: 'movie_id',
  as: 'comments'
}}, {$project: {
  "_id": 0, "title": 1, "comments": 1
}}, {$match: {
  "comments": {$not: {$lte: 1}}
}}]
db.movies.aggregate(pipe)


