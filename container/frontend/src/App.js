import React, { useState, useEffect } from 'react';
import './App.css';

function App() {
  // Backend URL from environment variable
  const backendUrl = process.env.REACT_APP_BACKEND_URL || 'Not configured';

  // State to store fetched data
  const [data, setData] = useState(null);
  const [error, setError] = useState(null);

  // Fetch data from the backend on component mount
  useEffect(() => {
    if (backendUrl === 'Not configured') {
      setError('Backend URL is not configured');
      return;
    }

    const fetchData = async () => {
      try {
        const response = await fetch(`${backendUrl}`);
        if (!response.ok) {
          throw new Error(`HTTP error! status: ${response.status}`);
        }
        const json = await response.json();
        setData(json);
      } catch (err) {
        setError(err.message);
      }
    };

    fetchData();
  }, [backendUrl]);

  return (
    <div className="App">
      <h1>Hello, World!</h1>
      <p>Welcome to my React app!</p>
      <h2>Backend URL:</h2>
      <p>{backendUrl}</p>
      <h2>Data from Backend:</h2>
      {error && <p style={{ color: 'red' }}>Error: {error}</p>}
      {data ? (
        <pre>{JSON.stringify(data, null, 2)}</pre>
      ) : (
        !error && <p>Loading data...</p>
      )}
    </div>
  );
}

export default App;

