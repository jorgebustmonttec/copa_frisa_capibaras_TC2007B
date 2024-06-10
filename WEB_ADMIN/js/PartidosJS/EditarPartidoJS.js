const apiUrl = 'https://localhost:3443';
const urlParams = new URLSearchParams(window.location.search);
const id = urlParams.get('id');

async function fetchEquipos() {
    try {
        const response = await fetch(`${apiUrl}/equipos`);
        if (!response.ok) throw new Error('Error al obtener los equipos');
        const equipos = await response.json();

        const equipoASelect = document.getElementById('equipoA');
        const equipoBSelect = document.getElementById('equipoB');
        const ganadorSelect = document.getElementById('ganador');
        equipos.forEach(equipo => {
            const optionA = document.createElement('option');
            optionA.value = equipo.id_equipo;
            optionA.text = equipo.nombre_equipo;
            equipoASelect.appendChild(optionA);

            const optionB = document.createElement('option');
            optionB.value = equipo.id_equipo;
            optionB.text = equipo.nombre_equipo;
            equipoBSelect.appendChild(optionB);

            const optionG = document.createElement('option');
            optionG.value = equipo.id_equipo;
            optionG.text = equipo.nombre_equipo;
            ganadorSelect.appendChild(optionG);
        });

        await fetchPartido(id);
    } catch (error) {
        console.error('Error:', error);
    }
}

async function fetchPartido(id) {
    try {
        const response = await fetch(`${apiUrl}/partidos/single/${id}`);
        if (!response.ok) throw new Error('Error al obtener el partido');
        const partido = await response.json();

        document.getElementById('equipoA').value = partido.equipo_a;
        document.getElementById('equipoB').value = partido.equipo_b;
        document.getElementById('fecha').value = new Date(partido.fecha).toISOString().slice(0, 16);
        document.getElementById('ganador').value = partido.ganador || '';

        fetchJugadoresA();
        fetchJugadoresB();
    } catch (error) {
        console.error('Error:', error);
    }
}

async function fetchJugadoresA() {
    const equipoAId = document.getElementById('equipoA').value;
    try {
        const response = await fetch(`${apiUrl}/jugadores/equipo/${equipoAId}`);
        if (!response.ok) throw new Error('Error al obtener los jugadores del equipo A');
        const jugadores = await response.json();

        ['jugadorA', 'jugadorAVerde', 'jugadorAYellow', 'jugadorARed'].forEach(selector => {
            const select = document.getElementById(selector);
            select.innerHTML = ''; // Clear previous options
            jugadores.forEach(jugador => {
                const option = document.createElement('option');
                option.value = jugador.id_jugador;
                option.text = jugador.nombre;
                select.appendChild(option);
            });
        });
    } catch (error) {
        console.error('Error:', error);
    }
}

async function fetchJugadoresB() {
    const equipoBId = document.getElementById('equipoB').value;
    try {
        const response = await fetch(`${apiUrl}/jugadores/equipo/${equipoBId}`);
        if (!response.ok) throw new Error('Error al obtener los jugadores del equipo B');
        const jugadores = await response.json();

        ['jugadorB', 'jugadorBVerde', 'jugadorBYellow', 'jugadorBRed'].forEach(selector => {
            const select = document.getElementById(selector);
            select.innerHTML = ''; // Clear previous options
            jugadores.forEach(jugador => {
                const option = document.createElement('option');
                option.value = jugador.id_jugador;
                option.text = jugador.nombre;
                select.appendChild(option);
            });
        });
    } catch (error) {
        console.error('Error:', error);
    }
}

async function agregarGol(equipo) {
    const jugadorSelect = document.getElementById(`jugador${equipo}`);
    const jugadorId = jugadorSelect.value;
    try {
        const response = await fetch(`${apiUrl}/puntos/goles/crear`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                id_jugador: jugadorId,
                id_partido: id
            })
        });
        if (!response.ok) throw new Error('Error al agregar el gol');
        alert('Gol agregado exitosamente');
    } catch (error) {
        console.error('Error:', error);
    }
}

async function agregarYellowCard(equipo) {
    const jugadorSelect = document.getElementById(`jugador${equipo}Yellow`);
    const jugadorId = jugadorSelect.value;
    try {
        const response = await fetch(`${apiUrl}/puntos/yellow/create`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                id_jugador: jugadorId,
                id_partido: id
            })
        });
        if (!response.ok) throw new Error('Error al agregar la tarjeta amarilla');
        alert('Tarjeta amarilla agregada exitosamente');
    } catch (error) {
        console.error('Error:', error);
    }
}

async function agregarRedCard(equipo) {
    const jugadorSelect = document.getElementById(`jugador${equipo}Red`);
    const jugadorId = jugadorSelect.value;
    try {
        const response = await fetch(`${apiUrl}/puntos/red/create`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                id_jugador: jugadorId,
                id_partido: id
            })
        });
        if (!response.ok) throw new Error('Error al agregar la tarjeta roja');
        alert('Tarjeta roja agregada exitosamente');
    } catch (error) {
        console.error('Error:', error);
    }
}

async function updatePartido(event) {
    event.preventDefault();
    try {
        const formData = new FormData(document.getElementById('editPartidoForm'));

        const dataToSend = {
            equipo_a: formData.get('equipoA'),
            equipo_b: formData.get('equipoB'),
            fecha: formData.get('fecha'),
            ganador: formData.get('ganador') || null
        };

        const response = await fetch(`${apiUrl}/partidos/actualizar/${id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(dataToSend)
        });

        if (!response.ok) throw new Error('Error al actualizar el partido');
        alert('Partido actualizado exitosamente');
        window.location.href = 'partidos.html';
    } catch (error) {
        console.error('Error:', error);
    }
}

async function fetchPoints() {
    try {
        const response = await fetch(`${apiUrl}/puntos/partido/${id}`);
        if (!response.ok) throw new Error('Error al obtener los puntos');
        const points = await response.json();

        const tableBody = document.querySelector('#pointsTable tbody');
        tableBody.innerHTML = '';

        for (const point of points) {
            const jugador = await fetchJugador(point.id_jugador);
            const tipoPunto = await fetchTipoPunto(point.tipo_punto);

            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${jugador.nombre} ${jugador.apellido_p} ${jugador.apellido_m}</td>
                <td>${point.id_equipo}</td>
                <td>${tipoPunto.nombre_punto}</td>
                <td>${new Date(point.tiempo_punto).toLocaleString()}</td>
                <td><button onclick="deletePoint(${point.id_punto})">Eliminar</button></td>
            `;
            tableBody.appendChild(row);
        }
    } catch (error) {
        console.error('Error:', error);
    }
}

async function fetchJugador(id) {
    try {
        const response = await fetch(`${apiUrl}/jugadores/single/${id}`);
        if (!response.ok) throw new Error('Error al obtener el jugador');
        return await response.json();
    } catch (error) {
        console.error('Error:', error);
        return { nombre: 'N/A', apellido_p: '', apellido_m: '' };
    }
}

async function fetchTipoPunto(id) {
    try {
        const response = await fetch(`${apiUrl}/tipo_puntos/${id}`);
        if (!response.ok) throw new Error('Error al obtener el tipo de punto');
        const tipoPunto = await response.json();
        return tipoPunto;
    } catch (error) {
        console.error('Error:', error);
        return { nombre_punto: 'N/A' };
    }
}

async function deletePoint(id) {
    if (confirm('¿Estás seguro de que quieres eliminar este punto?')) {
        try {
            const response = await fetch(`${apiUrl}/puntos/eliminar/${id}`, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json'
                }
            });

            if (!response.ok) throw new Error('Error al eliminar el punto');
            alert('Punto eliminado exitosamente');

            // Reload the points table
            fetchPoints();
        } catch (error) {
            console.error('Error:', error);
        }
    }
}

function goBack() {
    window.location.href = 'partidos.html';
}

document.addEventListener('DOMContentLoaded', fetchEquipos);
document.addEventListener('DOMContentLoaded', fetchPoints);
