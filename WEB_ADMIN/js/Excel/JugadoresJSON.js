document.addEventListener('DOMContentLoaded', function() {
    const data = [
        {
            "id_jugador": 1,
            "nombre": "Carlos",
            "id_equipo": 1,
            "nombre_equipo": "Team A",
            "username": "carlos.martinez",
            "display_name": "Carlos Martinez"
        },
        {
            "id_jugador": 2,
            "nombre": "Laura",
            "id_equipo": 2,
            "nombre_equipo": "Team B",
            "username": "laura.garcia",
            "display_name": "Laura Garcia"
        },
        {
            "id_jugador": 3,
            "nombre": "Manuel",
            "id_equipo": 3,
            "nombre_equipo": "Team C",
            "username": "manuel.rodriguez",
            "display_name": "Manuel Rodriguez"
        },
        {
            "id_jugador": 4,
            "nombre": "Maria",
            "id_equipo": 4,
            "nombre_equipo": "Team D",
            "username": "maria.fernandez",
            "display_name": "Maria Fernandez"
        }
    ];

    function printTable() {
        const table = document.getElementById('excel-table');
        // Crear el encabezado de la tabla si no existe
        if (table.querySelector("thead>tr").innerHTML === '') {
            table.querySelector("thead>tr").innerHTML = `
                <th class="mdl-data-table__cell--non-numeric">ID</th>
                <th class="mdl-data-table__cell--non-numeric">Nombre</th>
                <th class="mdl-data-table__cell--non-numeric">ID Equipo</th>
                <th class="mdl-data-table__cell--non-numeric">Nombre Equipo</th>
                <th class="mdl-data-table__cell--non-numeric">Username</th>
                <th class="mdl-data-table__cell--non-numeric">Display Name</th>
                <th class="mdl-data-table__cell--non-numeric">Acciones</th>
            `;
        }
        
        // Agregar filas de datos a la tabla
        data.forEach(player => {
            table.querySelector('tbody').innerHTML += `
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">${player.id_jugador}</td>
                    <td class="mdl-data-table__cell--non-numeric">${player.nombre}</td>
                    <td class="mdl-data-table__cell--non-numeric">${player.id_equipo}</td>
                    <td class="mdl-data-table__cell--non-numeric">${player.nombre_equipo}</td>
                    <td class="mdl-data-table__cell--non-numeric">${player.username}</td>
                    <td class="mdl-data-table__cell--non-numeric">${player.display_name}</td>
                    <td class="mdl-data-table__cell--non-numeric">
                        <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--colored" onclick="editPlayer(${player.id_jugador})">Editar Información</button>
                    </td>
                </tr>`;
        });
    }

    printTable();
});

function editPlayer(id) {
    console.log('Editar jugador con ID:', id);
    // Aquí puedes agregar lógica para redirigir al usuario a la página de edición o abrir un modal de edición.
    // Por ejemplo, podrías redirigir a: window.location.href = 'Edit_Jugador.html?id=' + id;
}
