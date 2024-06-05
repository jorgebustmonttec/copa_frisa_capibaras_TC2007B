const express = require('express');
const https = require('https');
const fs = require('fs');
const path = require('path');
const swaggerUi = require('swagger-ui-express');
const swaggerJSDoc = require('swagger-jsdoc');
const usuarioRoutes = require('./routes/usuarioRoutes');
const jugadorRoutes = require('./routes/jugadorRoutes');
const equipoRoutes = require('./routes/equipoRoutes');

const app = express();
//const port = 3000;
const httpsPort = 3443;

const options = {
  definition: {
      openapi: '3.0.0',
      info: {
          title: 'User API',
          version: '1.0.0',
          description: 'A simple Express User API',
      },
      servers: [
          //{
              //url: 'http://localhost:3000',
          //},
          {
              url: 'https://localhost:3443',
          }
      ],
  },
  apis: ['API/routes/**/*.js'],
};

const swaggerSpec = swaggerJSDoc(options);

app.use(express.json());

app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));

app.use('/usuarios', usuarioRoutes);
app.use('/jugadores', jugadorRoutes);
app.use('/equipos', equipoRoutes);

app.get('/', (req, res) => res.send('Hello World!'));

// Update paths for SSL files
const sslPath = path.join(__dirname, 'ssl');
const sslOptions = {
  key: fs.readFileSync(path.join(sslPath, 'key.pem')),
  cert: fs.readFileSync(path.join(sslPath, 'cert.pem'))
};

https.createServer(sslOptions, app).listen(httpsPort, () => {
  console.log(`Server listening on https://localhost:${httpsPort}!`);
});

// now using https
//app.listen(port, () => console.log(`Server listening on http://localhost:${port}!`));

module.exports = app;