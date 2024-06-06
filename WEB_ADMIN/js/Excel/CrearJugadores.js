class Excel{
    constructor(content){
        this.content = content

    }

    header(){
        return this.content[0]
    }

    rows(){
        return new RowCollection(this.content.slice(1,this.content.length))
    }
}

class RowCollection{

    constructor(rows){
        this.rows = rows
    }

    first(){

        return new Row(this.rows[0])
    }

    get(index){
        return new Row(this.rows[index])

    }

    count(){

        return this.rows.length

    }
}

class Row{

    constructor(row){

        this.row = row

    }

    Username(){

        return this.row[0]

    }
    NameDisplay(){

        return this.row[1]

    }

    Correo(){

        return this.row[2]

    }

    Password(){

        return this.row[3]

    }

    FechaDeNacimiento(){

        return this.row[4]

    }

    CURP(){

        return this.row[5]

    }

    Domicilio(){

        return this.row[6]

    }

    Telefono(){

        return this.row[7]

    }

    Name(){

        return this.row[8]

    }

    Ape_P(){

        return this.row[9]

    }
    APE_M(){

        return this.row[10]

    }

    NUM_IMSS(){

        return this.row[11]

    }

    ID_Equipo(){

        return this.row[12]

    }
}

class ExcelPrinter {
    static print(tableId, excel) {
        const table = document.getElementById(tableId);
        console.log(table);

        excel.header().forEach(title => {
            table.querySelector("thead>tr").innerHTML += `<th class="mdl-data-table__cell--non-numeric">${title}</th>`;
        });

        for (let index = 0; index < excel.rows().count(); index++) {
            const row = excel.rows().get(index);
            table.querySelector('tbody').innerHTML += `
                <tr>
                    <td class="mdl-data-table__cell--non-numeric">${row.Username()}</td>
                    <td class="mdl-data-table__cell--non-numeric">${row.NameDisplay()}</td>
                    <td class="mdl-data-table__cell--non-numeric">${row.Correo()}</td>
                    <td class="mdl-data-table__cell--non-numeric">${row.Password()}</td>
                    <td class="mdl-data-table__cell--non-numeric">${row.FechaDeNacimiento()}</td>
                    <td class="mdl-data-table__cell--non-numeric">${row.CURP()}</td>
                    <td class="mdl-data-table__cell--non-numeric">${row.Domicilio()}</td>
                    <td class="mdl-data-table__cell--non-numeric">${row.Telefono()}</td>
                    <td class="mdl-data-table__cell--non-numeric">${row.Name()}</td>
                    <td class="mdl-data-table__cell--non-numeric">${row.Ape_P()}</td>
                    <td class="mdl-data-table__cell--non-numeric">${row.APE_M()}</td>
                    <td class="mdl-data-table__cell--non-numeric">${row.NUM_IMSS()}</td>
                    <td class="mdl-data-table__cell--non-numeric">${row.ID_Equipo()}</td>
                </tr>`;
        }
    }
}


const excelInput = document.getElementById('excel-input');

excelInput.addEventListener('change', async function() {
    const file = excelInput.files[0];
    if (file) {
        const content = await readXlsxFile(file);
        const excel = new Excel(content);
        ExcelPrinter.print('excel-data-table', excel);
    }
});

document.getElementById('cancel-button').addEventListener('click', function() {
    // Limpiar la tabla
    document.querySelector('#excel-data-table tbody').innerHTML = '';
    // Resetear el input de archivo para permitir que el mismo archivo sea cargado nuevamente
    document.getElementById('excel-input').value = '';
});

document.getElementById('submit-button').addEventListener('click', async function() {
    const rows = document.querySelectorAll('#excel-data-table tbody tr');
    const data = Array.from(rows).map(row => {
        const cells = row.querySelectorAll('td');
        return {
            username: cells[0].innerText,
            display_name: cells[1].innerText,
            correo: cells[2].innerText,
            password: cells[3].innerText,
            fecha_nac: cells[4].innerText,
            CURP: cells[5].innerText,
            domicilio: cells[6].innerText,
            telefono: cells[7].innerText,
            nombre: cells[8].innerText,
            apellido_p: cells[9].innerText,
            apellido_m: cells[10].innerText,
            num_imss: parseInt(cells[11].innerText, 10),
            id_equipo: parseInt(cells[12].innerText, 10)
        };
    });

    try {
        const response = await fetch('http://localhost:3443/jugadores', {
            method: 'POST',
            headers: {'Content-Type': 'application/json'},
            body: JSON.stringify(data)
        });
        const result = await response.json();
        alert('Datos subidos correctamente!');
        loadTableFromAPI();  // Función para recargar la tabla desde la API
    } catch (error) {
        console.error('Error:', error);
        alert('Error al subir los datos');
    }
});


// Función para cargar datos desde la API y actualizar la tabla
function loadTableFromAPI() {
    fetch('https://localhost:3443/jugadores/small')
    .then(response => response.json())
    .then(data => {
        const table = document.getElementById('excel-data-table');
        const tbody = table.querySelector("tbody");
        tbody.innerHTML = ''; // Limpia la tabla existente

        data.forEach(player => {
            tbody.innerHTML += `
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
    })
    .catch(error => console.error('Error fetching players:', error));
}
