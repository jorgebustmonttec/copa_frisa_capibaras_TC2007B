const apiUrl = 'https://localhost:3443';

async function fetchAllPartidos() {
    await fetchPartidos(`${apiUrl}/partidos`);
}

async function fetchPastPartidos() {
    await fetchPartidos(`${apiUrl}/partidos/pasados`);
}

async function fetchFuturePartidos() {
    await fetchPartidos(`${apiUrl}/partidos/futuros`);
}

async function fetchPartidos(url) {
    try {
        const response = await fetch(url);
        if (!response.ok) throw new Error('Error al obtener los partidos');
        const partidos = await response.json();

        const tableBody = document.querySelector('#partidosTable tbody');
        tableBody.innerHTML = '';

        for (const partido of partidos) {
            const equipoA = await fetchEquipo(partido.equipo_a);
            const equipoB = await fetchEquipo(partido.equipo_b);

            const golesA = await fetchTotalGoals(partido.equipo_a, partido.id_partido);
            const golesB = await fetchTotalGoals(partido.equipo_b, partido.id_partido);

            let ganador = 'Empate';
            if (partido.ganador === null) {
                ganador = 'Por Determinar';
            } else if (partido.ganador === equipoA.id_equipo) {
                ganador = equipoA.nombre_equipo;
            } else if (partido.ganador === equipoB.id_equipo) {
                ganador = equipoB.nombre_equipo;
            }

            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${equipoA.nombre_equipo}</td>
                <td><img src="${equipoA.escudo}" alt="Escudo A" style="width:50px;"></td>
                <td>${golesA}</td>
                <td>${equipoB.nombre_equipo}</td>
                <td><img src="${equipoB.escudo}" alt="Escudo B" style="width:50px;"></td>
                <td>${golesB}</td>
                <td>${new Date(partido.fecha).toLocaleString()}</td>
                <td>${ganador}</td>
                <td>
                    <button onclick="editPartido(${partido.id_partido})" class="mdl-button mdl-js-button mdl-button--raised mdl-button--accent">Edit</button>
                    <button onclick="deletePartido(${partido.id_partido})" class="mdl-button mdl-js-button mdl-button--raised mdl-button--accent">Delete</button>
                    <button onclick="determineMatchWinner(${partido.id_partido})" class="mdl-button mdl-js-button mdl-button--raised mdl-button--colored">Determinar Ganador</button>
                </td>
            `;
            tableBody.appendChild(row);
        }
    } catch (error) {
        console.error('Error:', error);
    }
}

async function fetchEquipo(id) {
    try {
        const response = await fetch(`${apiUrl}/equipos/single/${id}`);
        if (!response.ok) throw new Error('Error al obtener el equipo');
        const equipo = await response.json();

        const escudoResponse = await fetch(`${apiUrl}/equipos/single/${id}/escudo`);
        const escudoBlob = await escudoResponse.blob();
        const escudoUrl = URL.createObjectURL(escudoBlob);

        return {
            ...equipo,
            escudo: escudoUrl
        };
    } catch (error) {
        console.error('Error:', error);
        return { nombre_equipo: 'N/A', escudo: '' };
    }
}

async function fetchTotalGoals(teamId, matchId) {
    try {
        const response = await fetch(`${apiUrl}/puntos/goles/equipo/${teamId}/partido/${matchId}/total`);
        if (!response.ok) throw new Error('Error al obtener los goles');
        const data = await response.json();
        return data.total_goals;
    } catch (error) {
        console.error('Error:', error);
        return 0;
    }
}

async function fetchEquipos() {
    try {
        const response = await fetch(`${apiUrl}/equipos`);
        if (!response.ok) throw new Error('Error al obtener los equipos');
        const equipos = await response.json();

        const equipoASelect = document.getElementById('equipoA');
        const equipoBSelect = document.getElementById('equipoB');
        equipos.forEach(equipo => {
            const optionA = document.createElement('option');
            optionA.value = equipo.id_equipo;
            optionA.text = equipo.nombre_equipo;
            equipoASelect.appendChild(optionA);

            const optionB = document.createElement('option');
            optionB.value = equipo.id_equipo;
            optionB.text = equipo.nombre_equipo;
            equipoBSelect.appendChild(optionB);
        });
    } catch (error) {
        console.error('Error:', error);
    }
}

async function createPartido(event) {
    event.preventDefault();
    try {
        const form = document.getElementById('createPartidoForm');
        const formData = new FormData(form);

        const dataToSend = {
            equipo_a: formData.get('equipoA'),
            equipo_b: formData.get('equipoB'),
            fecha: formData.get('fecha')
        };

        const response = await fetch(`${apiUrl}/partidos/crear`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(dataToSend)
        });

        if (!response.ok) throw new Error('Error al crear el partido');
        alert('Partido creado exitosamente');

        // Clear the form
        form.reset();

        // Reload the partidos table
        fetchAllPartidos();
    } catch (error) {
        console.error('Error:', error);
    }
}

async function editPartido(id) {
    window.location.href = `EditarPartido.html?id=${id}`;
}

async function deletePartido(id) {
    if (confirm('¿Estás seguro de que quieres eliminar este partido?')) {
        try {
            const response = await fetch(`${apiUrl}/partidos/eliminar/${id}`, {
                method: 'DELETE',
                headers: {
                    'Content-Type': 'application/json'
                }
            });

            if (!response.ok) throw new Error('Error al eliminar el partido');
            alert('Partido eliminado exitosamente');

            // Reload the partidos table
            fetchAllPartidos();
        } catch (error) {
            console.error('Error:', error);
        }
    }
}

async function determineMatchWinner(id) {
    try {
        const response = await fetch(`${apiUrl}/partidos/determine-winner/single/${id}`, {
            method: 'PUT'
        });

        if (!response.ok) throw new Error('Error al determinar el ganador del partido');
        alert('Ganador determinado exitosamente');

        // Reload the partidos table
        fetchAllPartidos();
    } catch (error) {
        console.error('Error:', error);
    }
}

async function determineWinnersForAllMatches() {
    try {
        const response = await fetch(`${apiUrl}/partidos/determine-winner/all`, {
            method: 'PUT'
        });

        if (!response.ok) throw new Error('Error al determinar los ganadores de todos los partidos');
        alert('Ganadores de todos los partidos determinados exitosamente');

        // Reload the partidos table
        fetchAllPartidos();
    } catch (error) {
        console.error('Error:', error);
    }
}

document.addEventListener('DOMContentLoaded', fetchEquipos);
