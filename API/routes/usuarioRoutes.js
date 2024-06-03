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


/**
 * @swagger
 * /usuarios/perfil/{id}:
 *   get:
 *     tags:
 *       - Usuarios
 *     summary: Get the profile picture of a usuario
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: The ID of the usuario
 *     responses:
 *       200:
 *         description: Profile picture of the usuario
 *         content:
 *           image/jpeg:
 *             schema:
 *               type: string
 *               format: binary
 *       404:
 *         description: usuario not found
 */
router.get('/perfil/:id', usuarioController.getProfilePicture);

/**
 * @swagger
 * /usuarios/createAdmin:
 *   post:
 *     tags:
 *       - Usuarios
 *     summary: Create an admin account
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - username
 *               - password
 *             properties:
 *               username:
 *                 type: string
 *               display_name:
 *                 type: string
 *               correo:
 *                 type: string
 *               password:
 *                 type: string
 *     responses:
 *       201:
 *         description: Admin account created successfully
 *       400:
 *         description: Bad request
 *       500:
 *         description: Internal server error
 */
router.post('/createAdmin', usuarioController.createAdmin);

/**
 * @swagger
 * /usuarios/createUser:
 *   post:
 *     tags:
 *       - Usuarios
 *     summary: Crear un nuevo usuario
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               username:
 *                 type: string
 *               display_name:
 *                 type: string
 *               correo:
 *                 type: string
 *               password:
 *                 type: string
 *     responses:
 *       201:
 *         description: Usuario created successfully
 *       400:
 *         description: Bad request
 *       500:
 *         description: Server error
 */
router.post('/createUser', usuarioController.createUser);

/**
 * @swagger
 * /usuarios/login:
 *   post:
 *     tags:
 *       - Usuarios
 *     summary: Iniciar sesión
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               username:
 *                 type: string
 *               password:
 *                 type: string
 *     responses:
 *       200:
 *         description: Login successful
 *       400:
 *         description: Bad request
 *       500:
 *         description: Server error
 */
router.post('/login', usuarioController.loginUser);




module.exports = router;
