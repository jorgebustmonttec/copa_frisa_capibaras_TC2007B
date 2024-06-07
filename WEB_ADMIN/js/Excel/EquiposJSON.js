// Definir la URL base de la API
let apiURL = "https://localhost:3443";

document.addEventListener('DOMContentLoaded', function() {
    // Usar la variable apiURL para construir la URL completa para obtener datos de equipos
    fetch(apiURL + '/equipos')
    .then(response => response.json())
    .then(data => printTable(data))
    .catch(error => console.error('Error fetching data:', error));
});

function printTable(data) {
    const table = document.getElementById('static-json-team-table');
    // Asegurarse de que la tabla esté limpia antes de añadir nuevos datos
    table.querySelector("thead>tr").innerHTML = `
        <th class="mdl-data-table__cell--non-numeric">ID Equipo</th>
        <th class="mdl-data-table__cell--non-numeric">Nombre Equipo</th>
        <th class="mdl-data-table__cell--non-numeric">Escuela</th>
        <th class="mdl-data-table__cell--non-numeric">Acciones</th>
    `;
    table.querySelector("tbody").innerHTML = ''; // Limpiar las filas anteriores

    data.forEach(equipo => {
        table.querySelector('tbody').innerHTML += `
            <tr>
                <td class="mdl-data-table__cell--non-numeric">${equipo.id_equipo}</td>
                <td class="mdl-data-table__cell--non-numeric">${equipo.nombre_equipo}</td>
                <td class="mdl-data-table__cell--non-numeric">${equipo.escuela}</td>
                <td class="mdl-data-table__cell--non-numeric">
                    <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect mdl-button--colored" onclick="editTeam(${equipo.id_equipo})">Editar Información</button>
                </td>
            </tr>`;
    });
}

function editTeam(id) {
    console.log('Editar equipo con ID:', id);
    // Aquí puedes agregar lógica para redirigir al usuario a la página de edición o abrir un modal de edición.
    // Por ejemplo, podrías redirigir a: window.location.href = 'Edit_Equipo.html?id=' + id;
}
