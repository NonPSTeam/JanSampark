// Create a new Grievance
app.post('/api/grievances', async (req, res) => {
    try {
      const newGrievance = new Grievance(req.body);
      await newGrievance.save();
      res.status(201).json(newGrievance);
    } catch (error) {
      res.status(400).json({ message: error.message });
    }
  });
  
  // Get all Grievances
  app.get('/api/grievances', async (req, res) => {
    try {
      const grievances = await Grievance.find();
      res.status(200).json(grievances);
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  });
  
  // Implement other CRUD operations as needed
  