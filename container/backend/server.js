const express = require('express');
const cors = require('cors'); // Import CORS middleware
const app = express();
const port = 5000;

// Enable CORS for all routes and origins
app.use(cors());

// Middleware to log each incoming request
app.use((req, res, next) => {
  const currentTime = new Date().toISOString();
  console.log(`[${currentTime}] ${req.method} ${req.url}`);
  next(); // Pass control to the next middleware
});

// Define the `/ram` endpoint
app.get('/ram', (req, res) => {
  res.json({
    type: 'DDR4',
    capacity: '16GB',
    manufacturer: 'Corsair',
  });
});

// Start the backend server
app.listen(port, () => {
  console.log(`Backend is running at http://localhost:${port}`);
});
