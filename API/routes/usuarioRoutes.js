//usuarioRoutes.js

const express = require('express');
const router = express.Router();
const usuarioController = require('../controllers/usuarioController');


/**
 * @swagger
 * tags:
 *   name: Usuarios
 *   description: All about Usuarios
 * 
 * components:
 *   schemas:
 *     Usuario:
 *       type: object
 *       required:
 *         - username
 *         - password
 *       properties:
 *         id_usuario:
 *           type: integer
 *           description: Identificador único del usuario.
 *         username:
 *           type: string
 *           description: Nombre de usuario.
 *         display_name:
 *           type: string
 *           description: Nombre para mostrar.
 *         correo:
 *           type: string
 *           description: Correo electrónico.
 *         password:
 *           type: string
 *           description: Contraseña del usuario.
 *         tipo_usuario:
 *           type: integer
 *           description: Tipo de usuario (1 para admin, 2 para usuario normal).
 *         imagen:
 *           type: string
 *           description: Ruta de la imagen del perfil.
 *         created_at:
 *           type: string
 *           format: date-time
 *           description: Fecha de creación del usuario.
 *       example:
 *         id_usuario: 1
 *         username: johndoe
 *         display_name: John Doe
 *         correo: johndoe@example.com
 *         password: $2b$10$2nqhUTjvvNNbjwP.2BliROYw2ZJq/y6/6Bx4Ko04LT42pHRWAITAO
 *         tipo_usuario: 2
 *         imagen: NA
 *         created_at: 2024-05-30T21:55:33.000Z
 */

 /** /usuarios:
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
 * /usuarios/createUsuario:
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
router.post('/createUsuario', usuarioController.createUser);

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
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   description: Success message
 *                 id_usuario::
 *                   type: integer
 *                   description: ID of the logged-in user
 *                 tipo_usuario:
 *                   type: integer
 *                   description: ID of the user type
 *       400:
 *         description: Bad request
 *       500:
 *         description: Server error
 */
router.post('/login', usuarioController.loginUser);



module.exports = router;
