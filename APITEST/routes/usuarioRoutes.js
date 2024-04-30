const express = require('express');
const usuarioController = require('../controllers/usuarioController');
const router = express.Router();

/**
 * @swagger
 * /usuarios/adminstatus:
 *   get:
 *     summary: Get user ID and admin status by email
 *     parameters:
 *       - in: query
 *         name: email
 *         required: true
 *         schema:
 *           type: string
 *         description: The user's email
 *     responses:
 *       200:
 *         description: User ID and admin status retrieved successfully.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 IdUsuario:
 *                   type: integer
 *                   description: The ID of the usuario.
 *                 Administrador:
 *                   type: boolean
 *                   description: Admin status of the usuario.
 *       404:
 *         description: User not found.
 *       500:
 *         description: Server error.
 */
router.get('/adminstatus', usuarioController.getUserByIdAndAdminStatus);








/**
 * @swagger
 * components:
 *   schemas:
 *     Usuario:
 *       type: object
 *       required:
 *         - IdUsuario
 *       properties:
 *         IdUsuario:
 *           type: integer
 *           description: The unique identifier for the usuario.
 *         UsernameUsuario:
 *           type: string
 *           description: The username of the usuario.
 *         CorreoUsuario:
 *           type: string
 *           description: The email address of the usuario.
 *         PasswordUsuario:
 *           type: string
 *           description: The password of the usuario.
 *         NombresUsuario:
 *           type: string
 *           description: The first name(s) of the usuario.
 *         ApellidoPUsuario:
 *           type: string
 *           description: The paternal surname of the usuario.
 *         ApellidoMUsuario:
 *           type: string
 *           description: The maternal surname of the usuario.
 *         FechaNacimientoUsuario:
 *           type: string
 *           format: date
 *           description: The birth date of the usuario.
 *         DireccionUsuarioCalle:
 *           type: string
 *           description: The street address of the usuario.
 *         GeneroUsuario:
 *           type: string
 *           description: The gender of the usuario.
 *         TelefonoUsuario:
 *           type: string
 *           description: The phone number of the usuario.
 *         FechaCreacionUsuario:
 *           type: string
 *           format: date-time
 *           description: The creation date and time of the usuario record.
 *         Administrador:
 *           type: boolean
 *           description: Whether the usuario is an administrator.
 *       example:
 *         IdUsuario: 1
 *         UsernameUsuario: johndoe
 *         CorreoUsuario: johndoe@example.com
 *         PasswordUsuario: hashpassword
 *         NombresUsuario: John
 *         ApellidoPUsuario: Doe
 *         ApellidoMUsuario: Smith
 *         FechaNacimientoUsuario: "1990-01-01"
 *         DireccionUsuarioCalle: "123 Main St"
 *         GeneroUsuario: "M"
 *         TelefonoUsuario: "123-456-7890"
 *         FechaCreacionUsuario: "2023-01-01T00:00:00Z"
 *         Administrador: false
 *
 * /usuarios:
 *   get:
 *     summary: Retrieve a list of usuarios
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

/**
 * @swagger
 * /usuarios/genders:
 *   get:
 *     summary: Get count of all genders
 *     description: Retrieve a count of all genders from the users.
 *     responses:
 *       200:
 *         description: A count of each gender from the users.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               additionalProperties:
 *                 type: integer
 *               example: { "Masculino": 10, "Femenino": 15, "Otro": 2, "Prefiero No Decir": 5 }
 *       500:
 *         description: Server error.
 */

router.get('/genders', usuarioController.getUserGenders);

/**
 * @swagger
 * /usuarios/age-ranges:
 *   get:
 *     summary: Get count of users within age ranges
 *     description: Retrieve a count of users within defined age ranges.
 *     responses:
 *       200:
 *         description: A count of users within each age range.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               additionalProperties:
 *                 type: integer
 *               example: { "18-24": 5, "25-34": 10, "35-44": 8, "45-54": 12, "55-64": 7, "65+": 4 }
 *       500:
 *         description: Server error.
 */

router.get('/age-ranges', usuarioController.getUserAgeRanges);







/**
 * @swagger
 * /usuarios/register:
 *   post:
 *     summary: Register a new usuario
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/Usuario'
 *     responses:
 *       200:
 *         description: Usuario registered successfully.
 *       400:
 *         description: Error in registration data.
 */
router.post('/register', usuarioController.registerUsuario);


/**
 * @swagger
 * /usuarios/gems:
 *   get:
 *     summary: Get gem totals for all usuarios
 *     description: Retrieve the total gems for each usuario.
 *     responses:
 *       200:
 *         description: An array of users with their total gems.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   IdUsuario:
 *                     type: integer
 *                     description: Unique identifier of the usuario.
 *                   TotalGem:
 *                     type: integer
 *                     description: Total gems of the usuario.
 *       500:
 *         description: Server error.
 */
router.get('/gems', usuarioController.getUserGems);


/**
 * @swagger
 * /usuarios/login:
 *   post:
 *     summary: Authenticate a usuario
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               Correo:
 *                 type: string
 *                 description: The email of the usuario.
 *               Password:
 *                 type: string
 *                 description: The password of the usuario.
 *     responses:
 *       200:
 *         description: Authentication successful.
 *       401:
 *         description: Authentication failed.
 */
router.post('/login', usuarioController.authenticateUsuario);

/**
 * @swagger
 * /usuarios/check-email:
 *   get:
 *     summary: Check if an email exists
 *     description: Check if a given email is already registered in the database.
 *     parameters:
 *       - in: query
 *         name: email
 *         required: true
 *         description: The email to check.
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Returns whether the email exists.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 exists:
 *                   type: boolean
 *                   description: Indicates whether the email exists.
 *       500:
 *         description: Server error.
 */
router.get('/check-email', usuarioController.checkEmailExists);


/**
 * @swagger
 * /usuarios/check-username:
 *   get:
 *     summary: Check if a username exists
 *     description: Check if a given username is already registered in the database.
 *     parameters:
 *       - in: query
 *         name: username
 *         required: true
 *         description: The username to check.
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Returns whether the username exists.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 exists:
 *                   type: boolean
 *                   description: Indicates whether the username exists.
 *       500:
 *         description: Server error.
 */
router.get('/check-username', usuarioController.checkUsernameExists);




/**
 * @swagger
 * /usuarios/{id}/inventario:
 *   get:
 *     summary: Retrieve the inventory of a specific usuario
 *     description: Retrieve the inventory details for a specific usuario.
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: Numeric ID of the usuario to get the inventory for.
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: The inventory of the usuario.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   IdInventario:
 *                     type: integer
 *                     description: The unique identifier for the inventory entry.
 *                   IdUsuario:
 *                     type: integer
 *                   IdMarco:
 *                     type: integer
 *                   IdVehiculo:
 *                     type: integer
 *                   IdCabeza:
 *                     type: integer
 *                   IdCuerpo:
 *                     type: integer
 *       404:
 *         description: Usuario not found.
 */
router.get('/:id/inventario', usuarioController.getUsuarioInventario);




/**
 * @swagger
 * /usuarios/{id}/admin:
 *   get:
 *     summary: Check admin status of a usuario
 *     description: Retrieve the admin status for a specific usuario.
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: Numeric ID of the usuario to check admin status for.
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Admin status of the usuario.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 Administrador:
 *                   type: boolean
 *       404:
 *         description: Usuario not found.
 */
router.get('/:id/admin', usuarioController.checkAdminStatus);


/**
 * @swagger
 * /usuarios/{id}/gems:
 *   get:
 *     summary: Get gems of a specific usuario
 *     description: Retrieve the gems of a specific usuario.
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: Numeric ID of the usuario to get the gems for.
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: The gem count of the usuario.
 *         content:
 *           application/json:
 *             schema:
 *               type: integer
 *       404:
 *         description: Usuario not found.
 *       500:
 *         description: Server error.
 */

 
router.get('/:id/gems', usuarioController.getGemsById);




/**
 * @swagger
 * /usuarios/{id}:
 *   get:
 *     summary: Retrieve a specific usuario by ID
 *     description: Retrieve details of a specific usuario by their unique identifier.
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         description: Numeric ID of the usuario to retrieve.
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Detailed information about the usuario.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Usuario'
 *       404:
 *         description: Usuario not found.
 */
router.get('/:id', usuarioController.getUsuarioById);





module.exports = router;
