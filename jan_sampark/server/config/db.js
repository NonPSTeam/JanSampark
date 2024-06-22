require('dotenv').config();
const mongoose = require('mongoose');

const connectDB = async () => {
//   console.log('MONGO_URI:', process.env.MONGO_URI); 
  try {
    const conn = await mongoose.connect(process.env.MONGO_URI);
    console.log(`MongoDB Connected: ${conn.connection.host}`);
  } catch (err) {
    console.error(`Error: ${err.message}`);
    process.exit(1);
  }
};

module.exports = connectDB;
