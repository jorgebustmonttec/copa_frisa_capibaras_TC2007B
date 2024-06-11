const mysql = require('mysql2');

const db = mysql.createConnection({
  host: 'localhost',
  user: 'root',
  password: 'PASSWORD',
  database: 'copa_frisa'
});

db.connect(err => {
  if (err) {
    console.error('Error connecting to the database: ' + err.message);
    return;
  }
  console.log('Connected to the MySQL server.');
});

module.exports = db;
