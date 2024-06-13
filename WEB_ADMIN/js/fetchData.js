document.addEventListener('DOMContentLoaded', function() {
    fetch('https://localhost:3443/puntos/players/ordered-by-goals')
        .then(response => response.json())
        .then(data => {
            const table1Body = document.querySelector('#table1 tbody');
            data.forEach(player => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${player.display_name || player.username || player.nombre}</td>
                    <td>${player.nombre_equipo}</td>
                    <td>${player.total_goals}</td>
                `;
                table1Body.appendChild(row);
            });
        })
        .catch(error => console.error('Error fetching top scorers:', error));

    fetch('https://localhost:3443/puntos/players/ordered-by-green-cards')
        .then(response => response.json())
        .then(data => {
            const table2Body = document.querySelector('#table2 tbody');
            data.forEach(player => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${player.display_name || player.username || player.nombre}</td>
                    <td>${player.nombre_equipo}</td>
                    <td>${player.total_green_cards}</td>
                `;
                table2Body.appendChild(row);
            });
        })
        .catch(error => console.error('Error fetching players with green cards:', error));

    fetch('https://localhost:3443/partidos/teams/ordered-by-points')
        .then(response => response.json())
        .then(data => {
            const table3Body = document.querySelector('#table3 tbody');
            data.forEach(team => {
                fetch(`https://localhost:3443/equipos/single/${team.id_equipo}`)
                    .then(response => response.json())
                    .then(teamInfo => {
                        const row = document.createElement('tr');
                        row.innerHTML = `
                            <td>
                                <img src="https://localhost:3443/equipos/single/${team.id_equipo}/escudo" alt="Shield" width="20" height="20">
                                ${teamInfo.nombre_equipo}
                            </td>
                            <td>${teamInfo.escuela}</td>
                            <td>${team.total_points}</td>
                        `;
                        table3Body.appendChild(row);
                    })
                    .catch(error => console.error('Error fetching team info:', error));
            });
        })
        .catch(error => console.error('Error fetching team points:', error));
});
