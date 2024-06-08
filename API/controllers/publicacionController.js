//publicacionController.js
const db = require('../utils/db');
const path = require('path');

exports.getAllPosts = (req, res) => {
    const query = `
        SELECT 
            p.id_post,
            u.display_name AS autor,
            DATE_FORMAT(p.fecha, '%Y-%m-%d %H:%i') AS fecha,
            p.titulo,
            p.contenido,
            p.imagen,
            p.id_copa
        FROM publicaciones p
        JOIN usuarios u ON p.autor = u.id_usuario
    `;
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error al obtener publicaciones:', err);
            res.status(500).json({ error: 'Error al obtener publicaciones' });
        } else {
            res.json(results);
        }
    });
};

exports.createPost = (req, res) => {
    const { autor, titulo, contenido } = req.body;
    const id_copa = 1; // Default value for id_copa

    if (!autor || !titulo) {
        return res.status(400).json({ error: 'Faltan campos obligatorios' });
    }

    db.query('INSERT INTO publicaciones (autor, titulo, contenido, id_copa) VALUES (?, ?, ?, ?)', [autor, titulo, contenido, id_copa], (err, result) => {
        if (err) {
            console.error('Error al crear la publicación:', err);
            res.status(500).json({ error: 'Error al crear la publicación' });
        } else {
            res.status(201).json({ id_post: result.insertId });
        }
    });
};

exports.addPostImage = (req, res) => {
    const { id } = req.params;
    const imagen = req.file ? req.file.path : null;

    if (!imagen) {
        return res.status(400).json({ error: 'No se proporcionó ninguna imagen' });
    }

    const relativePath = path.relative(process.cwd(), imagen).replace(/^API[\\/]/, ''); // Remove 'API/' prefix

    db.query('UPDATE publicaciones SET imagen = ? WHERE id_post = ?', [relativePath, id], (err, result) => {
        if (err) {
            console.error('Error al actualizar la imagen de la publicación:', err);
            return res.status(500).json({ error: 'Error al actualizar la imagen de la publicación' });
        } else if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Publicación no encontrada' });
        } else {
            res.status(200).json({ message: 'Imagen de la publicación actualizada exitosamente' });
        }
    });
};

exports.getPostImageById = (req, res) => {
    const { id } = req.params;
    db.query('SELECT imagen FROM publicaciones WHERE id_post = ?', [id], (err, result) => {
        if (err) {
            console.error('Error al obtener la imagen de la publicación:', err);
            return res.status(500).json({ error: 'Error al obtener la imagen de la publicación' });
        } else if (result.length === 0) {
            return res.status(404).json({ error: 'Publicación no encontrada' });
        } else {
            const imagenPath = result[0].imagen;
            const absolutePath = path.resolve(__dirname, '..', imagenPath); // Adjust the path here
            res.sendFile(absolutePath, (err) => {
                if (err) {
                    console.error('Error al enviar el archivo:', err);
                    if (!res.headersSent) {
                        return res.status(500).json({ error: 'Error al enviar el archivo' });
                    }
                }
            });
        }
    });
};

exports.updatePost = (req, res) => {
    const { id } = req.params;
    const { titulo, contenido } = req.body;

    if (!titulo) {
        return res.status(400).json({ error: 'Faltan campos obligatorios' });
    }

    db.query('UPDATE publicaciones SET titulo = ?, contenido = ? WHERE id_post = ?', [titulo, contenido, id], (err, result) => {
        if (err) {
            console.error('Error al actualizar la publicación:', err);
            return res.status(500).json({ error: 'Error al actualizar la publicación' });
        } else if (result.affectedRows === 0) {
            return res.status(404).json({ error: 'Publicación no encontrada' });
        } else {
            res.status(200).json({ message: 'Publicación actualizada exitosamente' });
        }
    });
};


exports.getPostById = (req, res) => {
    const { id } = req.params;
    const query = `
        SELECT 
            p.id_post,
            u.display_name AS autor,
            DATE_FORMAT(p.fecha, '%Y-%m-%d %H:%i:%s') AS fecha,
            p.titulo,
            p.contenido,
            p.imagen,
            p.id_copa
        FROM publicaciones p
        JOIN usuarios u ON p.autor = u.id_usuario
        WHERE p.id_post = ?
    `;
    db.query(query, [id], (err, result) => {
        if (err) {
            console.error('Error al obtener la publicación:', err);
            res.status(500).json({ error: 'Error al obtener la publicación' });
        } else if (result.length === 0) {
            res.status(404).json({ error: 'Publicación no encontrada' });
        } else {
            res.json(result[0]);
        }
    });
};
