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

/**
 * @swagger
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
 *       500:
 *         description: Error en el servidor
 */
router.get('/', usuarioController.getAllUsuarios);

/**
 * @swagger
 * /usuarios/perfil/{id}:
 *   get:
 *     tags:
 *       - Usuarios
 *     summary: Obtener la foto de perfil de un usuario
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: El ID del usuario
 *     responses:
 *       200:
 *         description: Foto de perfil del usuario
 *         content:
 *           image/jpeg:
 *             schema:
 *               type: string
 *               format: binary
 *       404:
 *         description: Usuario no encontrado
 *       500:
 *         description: Error en el servidor
 */
router.get('/perfil/:id', usuarioController.getProfilePicture);

/**
 * @swagger
 * /usuarios/createAdmin:
 *   post:
 *     tags:
 *       - Usuarios
 *     summary: Crear una cuenta de administrador
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
 *         description: Cuenta de administrador creada exitosamente
 *       400:
 *         description: Solicitud incorrecta
 *       500:
 *         description: Error en el servidor
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
 *         description: Cuenta de usuario creada exitosamente
 *       400:
 *         description: Solicitud incorrecta
 *       500:
 *         description: Error en el servidor
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
 *         description: Inicio de sesión exitoso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   description: Mensaje de éxito
 *                 id_usuario:
 *                   type: integer
 *                   description: ID del usuario que ha iniciado sesión
 *                 tipo_usuario:
 *                   type: integer
 *                   description: Tipo de usuario
 *       400:
 *         description: Solicitud incorrecta
 *       500:
 *         description: Error en el servidor
 */
router.post('/login', usuarioController.loginUser);

/**
 * @swagger
 * /usuarios/signup:
 *   post:
 *     tags:
 *       - Usuarios
 *     summary: Registrar un nuevo usuario
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
 *         description: Cuenta de usuario creada exitosamente
 *       400:
 *         description: Solicitud incorrecta
 *       500:
 *         description: Error en el servidor
 */
router.post('/signup', usuarioController.signup);

module.exports = router;
