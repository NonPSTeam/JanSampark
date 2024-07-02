const grievanceSchema = new mongoose.Schema({
    title: { type: String, required: true },
    description: { type: String, required: true },
    location: { type: String, required: true },
    category: { type: String, required: true },
  });
  
  const Grievance = mongoose.model('Grievance', grievanceSchema);
  