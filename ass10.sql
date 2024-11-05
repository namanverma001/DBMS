-- Step 1: Create the Collection Books
db.createCollection("books");
-- Step 2: Insert Sample Data
-- Insert some documents with fields TITLE, DESCRIPTION, BY, URL, TAGS, and LIKES:
db.books.insertMany([
    {
        "TITLE": "MongoDB Basics",
        "DESCRIPTION": "Introduction to MongoDB",
        "BY": "Ajay",
        "URL": "https://mongodb.com",
        "TAGS": ["database", "NoSQL"],
        "LIKES": 150
    },
    {
        "TITLE": "Advanced MongoDB",
        "DESCRIPTION": "Learn advanced MongoDB techniques",
        "BY": "Ajay",
        "URL": "https://advancedmongodb.com",
        "TAGS": ["database", "NoSQL", "aggregation"],
        "LIKES": 250
    },
    {
        "TITLE": "NodeJS Overview",
        "DESCRIPTION": "JavaScript runtime environment",
        "BY": "Suresh",
        "URL": "https://nodejs.org",
        "TAGS": ["javascript", "runtime", "backend"],
        "LIKES": 100
    },
    {
        "TITLE": "NoSQL Concepts",
        "DESCRIPTION": "Learn NoSQL databases",
        "BY": "Ajay",
        "URL": "https://nosql.org",
        "TAGS": ["database", "NoSQL"],
        "LIKES": 80
    },
    {
        "TITLE": "ExpressJS",
        "DESCRIPTION": "Node.js web framework",
        "BY": "Vijay",
        "URL": "https://expressjs.com",
        "TAGS": ["javascript", "framework"],
        "LIKES": 50
    }
]);
-- Aggregation Queries
-- Find the number of books published by “Ajay”:
db.books.aggregate([
    { $match: { "BY": "Ajay" } },
    { $count: "TotalBooksByAjay" }
]);
-- Find books with minimum and maximum likes published by “Ajay”:
-- Minimum likes:
db.books.aggregate([
    { $match: { "BY": "Ajay" } },
    { $sort: { "LIKES": 1 } },  // Sort by ascending likes
    { $limit: 1 }               // Get the document with the minimum likes
]);
-- Maximum likes:
db.books.aggregate([
    { $match: { "BY": "Ajay" } },
    { $sort: { "LIKES": -1 } },  // Sort by descending likes
    { $limit: 1 }                // Get the document with the maximum likes
]);
-- Find the average number of likes of the books published by “Ajay”:
db.books.aggregate([
    { $match: { "BY": "Ajay" } },
    { $group: { _id: "$BY", avgLikes: { $avg: "$LIKES" } } }
]);
-- Find the first and last book published by “Ajay”:
-- First book:
db.books.aggregate([
    { $match: { "BY": "Ajay" } },
    { $sort: { "TITLE": 1 } },   // Sorting by title in ascending order
    { $limit: 1 }                // Get the first book
]);
-- Last book:
db.books.aggregate([
    { $match: { "BY": "Ajay" } },
    { $sort: { "TITLE": -1 } },  // Sorting by title in descending order
    { $limit: 1 }                // Get the last book
]);
-- Indexing Queries
-- Create an index on the BY (author name) field:

db.books.createIndex({ "BY": 1 });
-- Display the books published by “Ajay” and check if the index is used:
db.books.find({ "BY": "Ajay" }).explain("executionStats");