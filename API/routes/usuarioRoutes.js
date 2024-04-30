//usuarioRoutes.js

const express = require('express');
const router = express.Router();
const usuarioController = require('../controllers/usuarioController');

/**
 * @swagger
 * tags:
 *   name: Usuarios
 *   description: Everything about Usuarios
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
 *           description: The unique identifier for the usuario.
 *         username:
 *           type: string
 *           description: The username of the usuario.
 *         display_name:
 *           type: string
 *           description: The display name of the usuario.
 *         correo:
 *           type: string
 *           description: The email address of the usuario.
 *         password:
 *           type: string
 *           description: The password of the usuario.
 *         tipo_usuario:
 *           type: integer
 *           description: The type identifier for the usuario.
 *         imagen:
 *           type: string
 *           description: The image URL of the usuario.
 *         created_at:
 *           type: string
 *           format: date-time
 *           description: The timestamp the usuario was created at.
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
 *     summary: Retrieve a list of usuarios
 *     description: Returns a list of usuarios, you can divide this further by 'GET' methods or whatever else if you feel fancy.
 *     responses:
 *       200:
 *         description: A list of usuarios.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Usuario'
 */
router.get('/', usuarioController.getAllUsuarios);

module.exports = router;
