// models/articulo.js

const db = require('../utils/db'); 

class Articulo {
    static getAll(callback) {
        const sql = 'SELECT * FROM articulos';
        db.query(sql, function(err, results) {
            callback(err, results);
        });
    }
}





module.exports = Articulo;
