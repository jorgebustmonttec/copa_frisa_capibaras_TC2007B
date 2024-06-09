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

                const jugadorASelect = document.getElementById('jugadorA');
                jugadorASelect.innerHTML = '';
                jugadores.forEach(jugador => {
                    const option = document.createElement('option');
                    option.value = jugador.id_jugador;
                    option.text = jugador.nombre;
                    jugadorASelect.appendChild(option);
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

                const jugadorBSelect = document.getElementById('jugadorB');
                jugadorBSelect.innerHTML = '';
                jugadores.forEach(jugador => {
                    const option = document.createElement('option');
                    option.value = jugador.id_jugador;
                    option.text = jugador.nombre;
                    jugadorBSelect.appendChild(option);
                });
            } catch (error) {
                console.error('Error:', error);
            }
        }

        async function agregarGol(equipo) {
            const jugadorSelect = document.getElementById(`jugador${equipo}`);
            const jugadorId = jugadorSelect.value;
            const idPartido = id;
            try {
                const response = await fetch(`${apiUrl}/puntos/goles/crear`, {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/json'
                    },
                    body: JSON.stringify({
                        id_jugador: jugadorId,
                        id_partido: idPartido
                    })
                });
                if (!response.ok) throw new Error('Error al agregar el gol');
                alert('Gol agregado exitosamente');
            } catch (error) {
                console.error('Error:', error);
            }
        }

        async function updatePartido(event) {
            event.preventDefault();
            try {
                const form = document.getElementById('editPartidoForm');
                const formData = new FormData(form);

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

        function goBack() {
            window.location.href = 'partidos.html';
        }

        function editPoints() {
            window.location.href = `editPoints.html?id=${id}`;
        }

        document.addEventListener('DOMContentLoaded', fetchEquipos);