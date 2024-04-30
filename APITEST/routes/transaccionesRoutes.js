// routes/transaccionesRoutes.js

const express = require('express');
const transaccionesController = require('../controllers/transaccionesController');
const router = express.Router();

/**
 * @swagger
 * tags:
 *   - name: Transacciones
 *     description: Operations about transactions
 * /transacciones/regalarGemas:
 *   post:
 *     tags: [Transacciones]
 *     summary: Add a transaction of type 'Regalo'
 *     description: Insert a gift transaction into the transaccionesdineroreal table.
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - userId
 *               - amount
 *             properties:
 *               userId:
 *                 type: integer
 *                 description: The user ID to which the transaction belongs.
 *               amount:
 *                 type: integer
 *                 description: The amount of gems granted.
 *     responses:
 *       201:
 *         description: Transaction added successfully.
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                 transactionId:
 *                   type: integer
 *                   description: The ID of the created transaction.
 *       500:
 *         description: Server error.
 */
router.post('/regalarGemas', transaccionesController.addTransaccionDineroReal);


/**
 * @swagger
 * 
 * 
 * /transacciones/compra:
 *   post:
 *     tags: [Transacciones]
 *     summary: Add a compra transaction
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - idUsuario
 *               - idArticulo
 *               - detalle
 *             properties:
 *               idUsuario:
 *                 type: integer
 *                 description: The user ID for whom the transaction is made.
 *               idArticulo:
 *                 type: integer
 *                 description: The article ID being purchased.
 *               detalle:
 *                 type: string
 *                 description: Details about the transaction.
 *     responses:
 *       201:
 *         description: Transaction added successfully.
 *       404:
 *         description: Article not found.
 *       500:
 *         description: Server error.
 */
router.post('/compra', transaccionesController.addCompraTransaction);


module.exports = router;
