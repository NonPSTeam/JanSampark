
const express = require("express");
const app = express();
const MongoClient = require("mongodb").MongoClient;
const url = "mongodb://localhost:27017";
const dbName = "mydatabase";

let db;

MongoClient.connect(url, function(err, client) {
  if (err) {
    console.log(err);
  } else {
    console.log("Connected to MongoDB");
    db = client.db(dbName);
  }
});

app.use(express.json());

app.post("/api/data", (req, res) => {
  const data = req.body;
  db.collection("mycollection").insertOne(data, (err, result) => {
    if (err) {
      res.status(500).send({ message: "Error inserting data" });
    } else {
      res.send({ message: "Data inserted successfully" });
    }
  });
});

app.listen(2000, () => {
  console.log("listening to port 2000");
});