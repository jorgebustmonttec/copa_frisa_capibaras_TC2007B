// publicacionRoutes.js

const express = require('express');
const router = express.Router();
const publicacionController = require('../controllers/publicacionController');
const upload = require('../utils/upload')('publicaciones'); // Specify folder as 'publicaciones'


/**
 * @swagger
 * tags:
 *   name: Publicaciones
 *   description: Todo sobre Publicaciones
 *
 * components:
 *   schemas:
 *     Publicacion:
 *       type: object
 *       required:
 *         - autor
 *         - titulo
 *         - id_copa
 *       properties:
 *         id_post:
 *           type: integer
 *           description: Identificador único de la publicación.
 *         autor:
 *           type: string
 *           description: Nombre del autor.
 *         fecha:
 *           type: string
 *           format: date-time
 *           description: Fecha de creación de la publicación.
 *         titulo:
 *           type: string
 *           description: Título de la publicación.
 *         contenido:
 *           type: string
 *           description: Contenido de la publicación.
 *         imagen:
 *           type: string
 *           description: Ruta de la imagen de la publicación.
 *         id_copa:
 *           type: integer
 *           description: Identificador de la copa.
 *       example:
 *         id_post: 1
 *         autor: "Autor Display Name"
 *         fecha: "2024-06-08 05:47"
 *         titulo: "Título de la publicación"
 *         contenido: "Contenido de la publicación"
 *         imagen: "storage/img/publicaciones/image1.png"
 *         id_copa: 1
 */

/**
 * @swagger
 * /publicaciones:
 *   get:
 *     tags:
 *       - Publicaciones
 *     summary: Obtener todas las publicaciones
 *     responses:
 *       200:
 *         description: Lista de todas las publicaciones
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Publicacion'
 *       500:
 *         description: Error al obtener las publicaciones
 */
router.get('/', publicacionController.getAllPosts);



/**
 * @swagger
 * /publicaciones/crear:
 *   post:
 *     tags:
 *       - Publicaciones
 *     summary: Crear una nueva publicación
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               autor:
 *                 type: integer
 *               titulo:
 *                 type: string
 *               contenido:
 *                 type: string
 *             example:
 *               autor: 1
 *               titulo: "Título de la publicación"
 *               contenido: "Contenido de la publicación"
 *     responses:
 *       201:
 *         description: Publicación creada exitosamente
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 id_post:
 *                   type: integer
 *       400:
 *         description: Faltan campos obligatorios
 *       500:
 *         description: Error al crear la publicación
 */
router.post('/crear', publicacionController.createPost);

/**
 * @swagger
 * /publicaciones/{id}:
 *   get:
 *     tags:
 *       - Publicaciones
 *     summary: Obtener una publicación por ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único de la publicación
 *     responses:
 *       200:
 *         description: Detalles de la publicación
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Publicacion'
 *       404:
 *         description: Publicación no encontrada
 *       500:
 *         description: Error al obtener la publicación
 */
router.get('/:id', publicacionController.getPostById);

/**
 * @swagger
 * /publicaciones/{id}/imagen:
 *   get:
 *     tags:
 *       - Publicaciones
 *     summary: Obtener la imagen de una publicación por ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único de la publicación
 *     responses:
 *       200:
 *         description: Imagen de la publicación
 *         content:
 *           image/png:
 *             schema:
 *               type: string
 *               format: binary
 *       404:
 *         description: Publicación no encontrada
 *       500:
 *         description: Error al obtener la imagen de la publicación
 */
router.get('/:id/imagen', publicacionController.getPostImageById);

/**
 * @swagger
 * /publicaciones/{id}/imagen:
 *   post:
 *     tags:
 *       - Publicaciones
 *     summary: Agregar una imagen a una publicación
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único de la publicación
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               imagen:
 *                 type: string
 *                 format: binary
 *     responses:
 *       200:
 *         description: Imagen de la publicación actualizada exitosamente
 *       400:
 *         description: No se proporcionó ninguna imagen
 *       404:
 *         description: Publicación no encontrada
 *       500:
 *         description: Error al actualizar la imagen de la publicación
 */
router.post('/:id/imagen', upload.single('imagen'), publicacionController.addPostImage);

/**
 * @swagger
 * /publicaciones/actualizar/{id}:
 *   put:
 *     tags:
 *       - Publicaciones
 *     summary: Actualizar una publicación
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único de la publicación
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               titulo:
 *                 type: string
 *               contenido:
 *                 type: string
 *             example:
 *               titulo: "Nuevo título de la publicación"
 *               contenido: "Nuevo contenido de la publicación"
 *     responses:
 *       200:
 *         description: Publicación actualizada exitosamente
 *       400:
 *         description: Faltan campos obligatorios
 *       404:
 *         description: Publicación no encontrada
 *       500:
 *         description: Error al actualizar la publicación
 */
router.put('/actualizar/:id', publicacionController.updatePost);

/**
 * @swagger
 * /publicaciones/eliminar/{id}:
 *   delete:
 *     tags:
 *       - Publicaciones
 *     summary: Eliminar una publicación
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único de la publicación
 *     responses:
 *       200:
 *         description: Publicación eliminada exitosamente
 *       404:
 *         description: Publicación no encontrada
 *       500:
 *         description: Error al eliminar la publicación
 */
router.delete('/eliminar/:id', publicacionController.deletePost);


module.exports = router;