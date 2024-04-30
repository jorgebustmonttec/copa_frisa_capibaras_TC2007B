class Usuario {
    constructor(db) {
      this.db = db;
    }
  
    getAll(callback) {
      this.db.query('SELECT * FROM usuarios', function (err, results) {
        if (err) {
          return callback(err, null);
        }
        callback(null, results);
      });
    }
  }

  
  
  module.exports = Usuario;
  