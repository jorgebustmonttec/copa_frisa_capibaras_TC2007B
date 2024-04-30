//usuarioRoutes.js

const express = require('express');
const router = express.Router();
const usuarioController = require('../controllers/usuarioController');

/**
 * @swagger
 * tags:
 *   name: Usuarios
 *   description: Todo sobre Usuarios
 * 
 * components:
 *   schemas:
 *     Usuario:
 *       type: object
 *       required:
 *         - id_usuario
 *       properties:
 *         id_usuario:
 *           type: integer
 *           description: Identificador único del usuario.
 *         username:
 *           type: string
 *           description: Nombre de usuario del usuario.
 *         display_name:
 *           type: string
 *           description: Nombre para mostrar del usuario.
 *         correo:
 *           type: string
 *           description: Dirección de correo electrónico del usuario.
 *         password:
 *           type: string
 *           description: Contraseña del usuario.
 *         tipo_usuario:
 *           type: integer
 *           description: Identificador de tipo para el usuario.
 *         imagen:
 *           type: string
 *           description: URL de la imagen del usuario.
 *         created_at:
 *           type: string
 *           format: date-time
 *           description: Marca de tiempo en la que se creó el usuario.
 *       example:
 *         id_usuario: 1
 *         username: johndoe
 *         display_name: John Doe
 *         correo: johndoe@example.com
 *         password: hashpassword
 *         tipo_usuario: 1
 *         imagen: 'http://example.com/image.jpg'
 *         created_at: "2023-01-01T00:00:00Z"
 *
 * /usuarios:
 *   get:
 *     tags:
 *       - Usuarios
 *     summary: Obtener una lista de usuarios
 *     description: Devuelve una lista de usuarios
 *     responses:
 *       200:
 *         description: Una lista de usuarios.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Usuario'
 */
router.get('/', usuarioController.getAllUsuarios);

module.exports = router;
