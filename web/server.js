'use strict';

const Hapi = require('hapi');

const server = new Hapi.Server();
server.connection({ host: '0.0.0.0', port: 3000 });

server.route({
    method: 'GET',
    path:'/',
    handler: (request, reply) => reply('<h1>hello world</h1>')
});

server.start((err) => {
    if (err) {
        throw err;
    }
    console.log('Server running at:', server.info.uri);
});