// Definir la URL base de la API
let apiURL = "https://localhost:3443";

document.addEventListener('DOMContentLoaded', function() {
    // Usar la variable apiURL para construir la URL completa
    fetch(apiURL + '/jugadores/small')
    .then(response => response.json())
    .then(data => printTable(data))
    .catch(error => console.error('Error fetching data:', error));
});

function printTable(data) {
    const table = document.getElementById('static-json-table');
    // Asegurarse de que la tabla esté limpia antes de añadir nuevos datos
    table.querySelector("thead>tr").innerHTML = `
        <th class="mdl-data-table__cell--non-numeric">ID</th>
        <th class="mdl-data-table__cell--non-numeric">Nombre</th>
        <th class="mdl-data-table__cell--non-numeric">ID Equipo</th>
        <th class="mdl-data-table__cell--non-numeric">Nombre Equipo</th>
        <th class="mdl-data-table__cell--non-numeric">Username</th>
        <th class="mdl-data-table__cell--non-numeric">Display Name</th>
        <th class="mdl-data-table__cell--non-numeric">Acciones</th>
    `;
    table.querySelector("tbody").innerHTML = ''; // Limpiar las filas anteriores

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

function editPlayer(id) {
    console.log('Editar jugador con ID:', id);
    // Aquí puedes agregar lógica para redirigir al usuario a la página de edición o abrir un modal de edición.
    // Por ejemplo, podrías redirigir a: window.location.href = 'Edit_Jugador.html?id=' + id;
}
