
const express = require('express');
const router = express.Router();
const equipoController = require('../controllers/equipoController');
const upload = require('../utils/upload'); // Import multer configuration

/**
 * @swagger
 * tags:
 *   name: Equipos
 *   description: All about Equipos
 * 
 * components:
 *   schemas:
 *     Equipo:
 *       type: object
 *       required:
 *         - nombre_equipo
 *         - escuela
 *       properties:
 *         id_equipo:
 *           type: integer
 *           description: Identificador único del equipo.
 *         nombre_equipo:
 *           type: string
 *           description: Nombre del equipo.
 *         escudo:
 *           type: string
 *           description: Ruta del escudo del equipo.
 *         escuela:
 *           type: string
 *           description: Nombre de la escuela.
 *       example:
 *         id_equipo: 1
 *         nombre_equipo: Equipo A
 *         escudo: storage/escudos/logo1.png
 *         escuela: Primaria Benito Juárez
 *
 * /equipos:
 *   post:
 *     tags:
 *       - Equipos
 *     summary: Crear un nuevo equipo
 *     requestBody:
 *       required: true
 *       content:
 *         multipart/form-data:
 *           schema:
 *             type: object
 *             properties:
 *               nombre_equipo:
 *                 type: string
 *               escudo:
 *                 type: string
 *                 format: binary
 *               escuela:
 *                 type: string
 *     responses:
 *       201:
 *         description: Equipo created successfully
 *       500:
 *         description: Server error
 */
router.post('/', upload.single('escudo'), equipoController.createEquipo);

/**
 * @swagger
 * /equipos:
 *   get:
 *     tags:
 *       - Equipos
 *     summary: Obtener una lista de equipos
 *     responses:
 *       200:
 *         description: Una lista de equipos.
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Equipo'
 */
router.get('/', equipoController.getAllEquipos);

/**
 * @swagger
 * /equipos/{id}:
 *   get:
 *     tags:
 *       - Equipos
 *     summary: Obtener información de un equipo por ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: Identificador único del equipo
 *     responses:
 *       200:
 *         description: Información del equipo.
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Equipo'
 *       404:
 *         description: Equipo no encontrado
 */
router.get('/:id', equipoController.getEquipoById);

module.exports = router;