-- Create a collection named books:
db.createCollection("books");
-- Insert 5 records with fields TITLE, DESCRIPTION, BY, URL, TAGS, and LIKES:

db.books.insertMany([
    {
        "TITLE": "mongodb",
        "DESCRIPTION": "A NoSQL database",
        "BY": "Ajay",
        "URL": "https://mongodb.com",
        "TAGS": ["database", "NoSQL", "JSON"],
        "LIKES": 50
    },
    {
        "TITLE": "NodeJS",
        "DESCRIPTION": "JavaScript runtime",
        "BY": "Suresh",
        "URL": "https://nodejs.org",
        "TAGS": ["javascript", "runtime", "server"],
        "LIKES": 75
    },
    {
        "TITLE": "ReactJS",
        "DESCRIPTION": "A JavaScript library for building UI",
        "BY": "Ravi",
        "URL": "https://reactjs.org",
        "TAGS": ["javascript", "UI", "frontend"],
        "LIKES": 150
    },
    {
        "TITLE": "ExpressJS",
        "DESCRIPTION": "Node.js web framework",
        "BY": "Vijay",
        "URL": "https://expressjs.com",
        "TAGS": ["javascript", "framework", "backend"],
        "LIKES": 45
    },
    {
        "TITLE": "NoSQL overview",
        "DESCRIPTION": "Introduction to NoSQL databases",
        "BY": "Ajay",
        "URL": "https://nosql.org",
        "TAGS": ["NoSQL", "database"],
        "LIKES": 110
    }
]);

-- Insert 1 more document with an additional field of user_name and comments:


db.books.insertOne({
    "TITLE": "Python Programming",
    "DESCRIPTION": "Learn Python from basics",
    "BY": "Ankit",
    "URL": "https://python.org",
    "TAGS": ["python", "programming", "backend"],
    "LIKES": 80,
    "user_name": "Naman",
    "comments": "Great for beginners!"
});

-- Display all documents where TITLE is 'mongodb':

db.books.find({ "TITLE": "mongodb" });
-- Display all documents written by 'Ajay' or whose TITLE is 'mongodb':

db.books.find({
    $or: [
        { "BY": "Ajay" },
        { "TITLE": "mongodb" }
    ]
});
-- Display all documents where TITLE is 'mongodb' and written by 'Ajay':

db.books.find({
    "TITLE": "mongodb",
    "BY": "Ajay"
});
-- Display all documents where LIKES is greater than 10:

db.books.find({ "LIKES": { $gt: 10 } });
-- Display all documents where LIKES is greater than 100 and either TITLE is 'mongodb' or written by 'Ajay':

db.books.find({
    $and: [
        { "LIKES": { $gt: 100 } },
        {
            $or: [
                { "TITLE": "mongodb" },
                { "BY": "Ajay" }
            ]
        }
    ]
});
-- Update the TITLE of the 'mongodb' document to 'mongodb overview':

db.books.updateOne(
    { "TITLE": "mongodb" },
    { $set: { "TITLE": "mongodb overview" } }
);
-- Delete the document where TITLE is 'nosql overview':

db.books.deleteOne({ "TITLE": "NoSQL overview" });

-- Display exactly two documents written by 'Ajay':
db.books.find({ "BY": "Ajay" }).limit(2);

-- Display the second document published by 'Ajay':
db.books.find({ "BY": "Ajay" }).skip(1).limit(1);

-- Display all books in sorted fashion (by TITLE):
db.books.find().sort({ "TITLE": 1 });

-- Insert a document using save method:
db.books.save({
    "_id": ObjectId("60f8d1b8b234a1c2d9f72c29"), // Example ObjectID
    "TITLE": "AngularJS",
    "DESCRIPTION": "A JavaScript framework for front-end development",
    "BY": "Raj",
    "URL": "https://angularjs.org",
    "TAGS": ["javascript", "framework", "frontend"],
    "LIKES": 65
});