const express = require('express');
const connectDB = require('./config/db');
const dotenv = require('dotenv');
const cors = require('cors');

dotenv.config();
const app = express();


connectDB();


app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));


app.use('/api/auth', require('./routes/authRoutes'));


app.get('/', (req, res) => res.send('API Running'));

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));