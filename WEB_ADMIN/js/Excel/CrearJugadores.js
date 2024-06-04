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
    const content = await readXlsxFile(excelInput.files[0]);
    const excel = new Excel(content);
    console.log(ExcelPrinter.print('excel-data-table', excel));
});


document.getElementById('cancel-button').addEventListener('click', function() {
    // Limpiar la tabla
    document.querySelector('#excel-data-table tbody').innerHTML = '';
});

document.getElementById('submit-button').addEventListener('click', function() {
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

    // Llamada a la API para subir los datos
    fetch('http://localhost:3000/jugadores', { // Cambia a tu URL correcta
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(data)
    })
    .then(response => response.json())
    .then(data => {
        console.log('Success:', data);
        alert('Datos subidos correctamente!');
        // Limpia la tabla una vez que los datos se han subido con éxito
        document.querySelector('#excel-data-table tbody').innerHTML = '';
    })
    .catch((error) => {
        console.error('Error:', error);
        alert('Error al subir los datos');
    });
});
