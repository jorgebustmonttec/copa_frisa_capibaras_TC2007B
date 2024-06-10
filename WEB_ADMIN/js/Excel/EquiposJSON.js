
    const apiUrl = 'https://localhost:3443';

    async function fetchEquipos() {
        try {
            const response = await fetch(`${apiUrl}/equipos`);
            if (!response.ok) throw new Error('Error al obtener los equipos');
            const equipos = await response.json();

            const tableBody = document.querySelector('#equipos-table tbody');
            tableBody.innerHTML = '';

            for (const equipo of equipos) {
                const escudoResponse = await fetch(`${apiUrl}/equipos/single/${equipo.id_equipo}/escudo`);
                if (!escudoResponse.ok) continue; // Si no se puede cargar el escudo, continúa con el siguiente equipo
                const escudoBlob = await escudoResponse.blob();
                const escudoUrl = URL.createObjectURL(escudoBlob);

                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${equipo.id_equipo}</td>
                    <td>${equipo.nombre_equipo}</td>
                    <td>${equipo.escuela}</td>
                    <td><img src="${escudoUrl}" alt="Escudo" style="width:50px;"></td>
                    <td><button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--colored" onclick="editEquipo(${equipo.id_equipo})">Editar</button></td>
                `;
                tableBody.appendChild(row);
            }
        } catch (error) {
            console.error('Error:', error);
        }
    }

    function editEquipo(id) {
        window.location.href = `Edit_Equipo.html?id=${id}`;
    }

