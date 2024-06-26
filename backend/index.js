const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const cors = require('cors');

const app = express();
const port = 3000;

// Middleware
app.use(bodyParser.json());
app.use(cors());

// MongoDB connection
mongoose.connect('mongodb://localhost:27017/jansampark', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
  });
  
  const db = mongoose.connection;
  
  db.on('error', console.error.bind(console, 'MongoDB connection error:'));
  db.once('open', () => {
    console.log('Connected to MongoDB');
  });
  

// User Schema
const UserSchema = new mongoose.Schema({
  username: { type: String, required: true, unique: true },
  password: { type: String, required: true },
  email: { type: String, required: true },
  role: { type: String, enum: ['user', 'admin'], default: 'user' },
});

const User = mongoose.model('User', UserSchema);

// Grievance Schema
const GrievanceSchema = new mongoose.Schema({
  title: { type: String, required: true },
  description: { type: String, required: true },
  location: { type: String, required: true },
  category: { type: String, required: true },
  media: { type: String }, // Assuming media is stored as a URL or file path
  upvotes: { type: Number, default: 0 },
  createdBy: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  createdAt: { type: Date, default: Date.now },
});

const Grievance = mongoose.model('Grievance', GrievanceSchema);

// Comment Schema
const CommentSchema = new mongoose.Schema({
  content: { type: String, required: true },
  createdBy: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  grievance: { type: mongoose.Schema.Types.ObjectId, ref: 'Grievance' },
  createdAt: { type: Date, default: Date.now },
});

const Comment = mongoose.model('Comment', CommentSchema);

// Register Route (For testing purpose, not usually exposed)
app.post('/register', async (req, res) => {
  const { username, password, email, role } = req.body;

  const hashedPassword = await bcrypt.hash(password, 10);

  const user = new User({ username, password: hashedPassword, email, role });

  try {
    await user.save();
    res.status(201).send('User created');
  } catch (error) {
    res.status(400).send(error.message);
  }
});

// Login Route
app.post('/login', async (req, res) => {
  const { username, password } = req.body;

  const user = await User.findOne({ username });
  if (!user) {
    return res.status(400).send('User not found');
  }

  const isPasswordValid = await bcrypt.compare(password, user.password);
  if (!isPasswordValid) {
    return res.status(400).send('Invalid password');
  }

  const token = jwt.sign({ id: user._id, role: user.role }, 'your_jwt_secret', {
    expiresIn: '1h',
  });

  res.status(200).json({ token });
});

// Middleware to verify JWT and Role
const verifyToken = (role) => {
  return (req, res, next) => {
    const token = req.headers['authorization'];
    if (!token) {
      return res.status(403).send('A token is required for authentication');
    }

    try {
      const decoded = jwt.verify(token, 'your_jwt_secret');
      req.user = decoded;

      if (role && req.user.role !== role) {
        return res.status(403).send('Access denied');
      }
    } catch (err) {
      return res.status(401).send('Invalid Token');
    }
    return next();
  };
};

// Create Grievance Route
app.post('/grievance', verifyToken('user'), async (req, res) => {
  const { title, description, location, category, media } = req.body;
  const createdBy = req.user.id; // Assuming user id is stored in req.user.id after token verification

  const grievance = new Grievance({
    title,
    description,
    location,
    category,
    media,
    createdBy,
  });

  try {
    await grievance.save();
    res.status(201).send('Grievance submitted');
  } catch (error) {
    res.status(400).send(error.message);
  }
});

// Upvote Grievance Route
app.post('/grievance/upvote/:id', verifyToken('user'), async (req, res) => {
  const grievanceId = req.params.id;

  try {
    const grievance = await Grievance.findById(grievanceId);
    if (!grievance) {
      return res.status(404).send('Grievance not found');
    }

    grievance.upvotes++;
    await grievance.save();
    res.status(200).send('Grievance upvoted');
  } catch (error) {
    res.status(500).send('Internal Server Error');
  }
});

// Add Comment Route
app.post('/comment/:grievanceId', verifyToken('user'), async (req, res) => {
  const { content } = req.body;
  const { grievanceId } = req.params;
  const createdBy = req.user.id; // Assuming user id is stored in req.user.id after token verification

  const comment = new Comment({
    content,
    createdBy,
    grievance: grievanceId,
  });

  try {
    await comment.save();
    res.status(201).send('Comment added');
  } catch (error) {
    res.status(400).send(error.message);
  }
});

// Get All Grievances Route
app.get('/grievances', async (req, res) => {
  try {
    const grievances = await Grievance.find().populate('createdBy', 'username').exec();
    res.status(200).json(grievances);
  } catch (error) {
    res.status(500).send('Internal Server Error');
  }
});

// Error Handling Middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something broke!');
});

app.listen(port, () => {
  console.log(`Server running on http://localhost:${port}`);
});
