const express = require('express');
const inventarioController = require('../controllers/inventarioController');
const router = express.Router();

/**
 * @swagger
 * /inventario/cambiar-vehiculo:
 *   post:
 *     summary: Cambia el vehículo actualmente equipado por el usuario.
 *     description: Actualiza el vehículo que el usuario tiene equipado en su inventario.
 *     tags: [Inventario]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - idUsuario
 *               - idArticulo
 *             properties:
 *               idUsuario:
 *                 type: integer
 *                 description: ID del usuario que realiza el cambio.
 *               idArticulo:
 *                 type: integer
 *                 description: ID del artículo que se establecerá como nuevo vehículo.
 *     responses:
 *       200:
 *         description: Vehículo actualizado con éxito.
 *       400:
 *         description: La solicitud no puede ser procesada debido a lógica de negocio.
 *       404:
 *         description: Artículo no encontrado para el usuario o no es un vehículo.
 *       500:
 *         description: Error interno del servidor.
 */
router.post('/cambiar-vehiculo', inventarioController.cambiarVehiculo);



/**
 * @swagger
 * tags:
 *   - name: Inventario
 *     description: Inventory operations
 */

/**
 * @swagger
 * /inventario/carrousado/{id}:
 *   get:
 *     tags: [Inventario]
 *     summary: Get used car inventory by user ID
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: The user ID to fetch the inventory for
 *     responses:
 *       200:
 *         description: Inventory retrieved successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   idvehiculo:
 *                     type: integer
 *                     description: The vehicle ID in the user's inventory
 *       500:
 *         description: Server error
 */
router.get('/carrousado/:id', inventarioController.getCarroUsado);




module.exports = router;
