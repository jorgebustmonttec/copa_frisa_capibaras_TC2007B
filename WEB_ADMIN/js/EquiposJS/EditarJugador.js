const apiUrl = 'https://localhost:3443';
const urlParams = new URLSearchParams(window.location.search);
const id = urlParams.get('id');
let jugadorData = {};

document.getElementById('id_jugador').value = id;

async function fetchJugador() {
    try {
        const response = await fetch(`${apiUrl}/jugadores/single/${id}`);
        if (!response.ok) throw new Error('Error al obtener el jugador');
        const jugador = await response.json();
        jugadorData = jugador; // Store the original data

        document.getElementById('nombre').placeholder = jugador.nombre;
        document.getElementById('apellido_p').placeholder = jugador.apellido_p;
        document.getElementById('apellido_m').placeholder = jugador.apellido_m;
        document.getElementById('display_name').placeholder = jugador.display_name;
        document.getElementById('username').placeholder = jugador.username;
        document.getElementById('correo').placeholder = jugador.correo;
        document.getElementById('fecha_nac').value = jugador.fecha_nac.split('T')[0];
        document.getElementById('CURP').placeholder = jugador.CURP;
        document.getElementById('domicilio').placeholder = jugador.domicilio;
        document.getElementById('telefono').placeholder = jugador.telefono;
        document.getElementById('num_imss').placeholder = jugador.num_imss;
        document.getElementById('id_equipo').placeholder = jugador.id_equipo;
        document.getElementById('posicion').placeholder = jugador.posicion;

        document.getElementById('nombre').addEventListener('input', handleInputChange);
        document.getElementById('apellido_p').addEventListener('input', handleInputChange);
        document.getElementById('apellido_m').addEventListener('input', handleInputChange);
        document.getElementById('display_name').addEventListener('input', handleInputChange);
        document.getElementById('username').addEventListener('input', handleInputChange);
        document.getElementById('correo').addEventListener('input', handleInputChange);
        document.getElementById('fecha_nac').addEventListener('input', handleInputChange);
        document.getElementById('CURP').addEventListener('input', handleInputChange);
        document.getElementById('domicilio').addEventListener('input', handleInputChange);
        document.getElementById('telefono').addEventListener('input', handleInputChange);
        document.getElementById('num_imss').addEventListener('input', handleInputChange);
        document.getElementById('id_equipo').addEventListener('input', handleInputChange);
        document.getElementById('posicion').addEventListener('input', handleInputChange);
        document.getElementById('password').addEventListener('input', handleInputChange);
    } catch (error) {
        console.error('Error:', error);
        alert('Error al obtener el jugador: ' + error.message);
    }
}



function handleInputChange() {
    const inputs = document.querySelectorAll('input');
    let isChanged = false;

    inputs.forEach(input => {
        if (input.value !== input.defaultValue) {
            input.classList.add('changed');
            isChanged = true;
        } else {
            input.classList.remove('changed');
        }
    });

    const updateButton = document.getElementById('update-button');
    if (isChanged) {
        updateButton.classList.remove('hidden');
        updateButton.disabled = false;
    } else {
        updateButton.classList.add('hidden');
        updateButton.disabled = true;
    }
}
async function updateJugador(event) {
    event.preventDefault();
    try {
        const dataToUpdate = {
            nombre: document.getElementById('nombre').value || jugadorData.nombre,
            apellido_p: document.getElementById('apellido_p').value || jugadorData.apellido_p,
            apellido_m: document.getElementById('apellido_m').value || jugadorData.apellido_m,
            display_name: document.getElementById('display_name').value || jugadorData.display_name,
            username: document.getElementById('username').value || jugadorData.username,
            correo: document.getElementById('correo').value || jugadorData.correo,
            fecha_nac: document.getElementById('fecha_nac').value || jugadorData.fecha_nac.split('T')[0],
            CURP: document.getElementById('CURP').value || jugadorData.CURP,
            domicilio: document.getElementById('domicilio').value || jugadorData.domicilio,
            telefono: document.getElementById('telefono').value || jugadorData.telefono,
            num_imss: document.getElementById('num_imss').value || jugadorData.num_imss,
            id_equipo: document.getElementById('id_equipo').value || jugadorData.id_equipo,
            posicion: document.getElementById('posicion').value || jugadorData.posicion
        };

        const password = document.getElementById('password').value;

        const response = await fetch(`${apiUrl}/jugadores/update/${id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(dataToUpdate)
        });

        if (!response.ok) {
            const errorResponse = await response.json();
            throw new Error(errorResponse.error || 'Error al actualizar el jugador');
        }

        if (password) {
            const passwordResponse = await fetch(`${apiUrl}/usuarios/changePassword`, {
                method: 'PUT',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ userId: jugadorData.id_usuario, newPassword: password })
            });

            if (!passwordResponse.ok) {
                const passwordErrorResponse = await passwordResponse.json();
                throw new Error(passwordErrorResponse.error || 'Error al cambiar la contraseña');
            }
        }

        alert('Jugador actualizado exitosamente');
        window.location.href = 'Jugadores.html';
    } catch (error) {
        console.error('Error:', error);
        alert('Error al actualizar el jugador: ' + error.message);
    }
}



function goBack() {
    window.history.back();
}

document.addEventListener('DOMContentLoaded', fetchJugador);