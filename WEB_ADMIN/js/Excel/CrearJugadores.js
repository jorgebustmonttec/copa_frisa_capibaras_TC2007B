document.getElementById('excel-input').addEventListener('change', handleFileSelect, false);
document.getElementById('submit-button').addEventListener('click', uploadData, false);

let jsonSheet;

class Excel {
    constructor(content) {
        this.content = content;
    }

    header() {
        return this.content[0];
    }

    rows() {
        return new RowCollection(this.content.slice(1, this.content.length));
    }
}

class RowCollection {
    constructor(rows) {
        this.rows = rows;
    }

    first() {
        return new Row(this.rows[0]);
    }

    get(index) {
        return new Row(this.rows[index]);
    }

    count() {
        return this.rows.length;
    }
}

class Row {
    constructor(row) {
        this.row = row;
    }

    Username() {
        return this.row[0];
    }
    NameDisplay() {
        return this.row[1];
    }
    Correo() {
        return this.row[2];
    }
    Password() {
        return this.row[3];
    }
    FechaDeNacimiento() {
        return this.row[4];
    }
    CURP() {
        return this.row[5];
    }
    Domicilio() {
        return this.row[6];
    }
    Telefono() {
        return this.row[7];
    }
    Name() {
        return this.row[8];
    }
    Ape_P() {
        return this.row[9];
    }
    APE_M() {
        return this.row[10];
    }
    NUM_IMSS() {
        return this.row[11];
    }
    ID_Equipo() {
        return this.row[12];
    }
}

class ExcelPrinter {
    static print(tableId, excel) {
        const table = document.getElementById(tableId);
        if (!table) {
            console.error(`Table with id "${tableId}" not found`);
            return;
        }

        const thead = table.querySelector("thead>tr");
        const tbody = table.querySelector('tbody');
        if (!thead || !tbody) {
            console.error('Table structure is incorrect');
            return;
        }

        thead.innerHTML = ''; // Clear existing header
        tbody.innerHTML = ''; // Clear existing rows

        excel.header().forEach(title => {
            thead.innerHTML += `<th class="mdl-data-table__cell--non-numeric">${title}</th>`;
        });

        for (let index = 0; index < excel.rows().count(); index++) {
            const row = excel.rows().get(index);
            tbody.innerHTML += `
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


function handleFileSelect(event) {
    const file = event.target.files[0];
    if (file) {
        readXlsxFile(file).then((content) => {
            const excel = new Excel(content);
            ExcelPrinter.print('excel-data-table', excel);
            jsonSheet = content;
        });
    }
}

function uploadData() {
    if (!jsonSheet) {
        alert('No data to upload');
        return;
    }

    const headers = jsonSheet[0];
    jsonSheet.slice(1).forEach((row, rowIndex) => {
        const rowData = {};
        row.forEach((cell, index) => {
            rowData[headers[index]] = cell;
        });

        // Check if all required fields are present
        if (!rowData['Username'] || !rowData['Nombre Display'] || !rowData['Correo'] || !rowData['Password'] ||
            !rowData['Fecha de nacimiento'] || !rowData['CURP'] || !rowData['Domicilio'] || !rowData['Telefono'] ||
            !rowData['Nombre'] || !rowData['Apellido Paterno'] || !rowData['Apellido Materno'] || !rowData['Num_IMSS'] ||
            !rowData['ID Equipo']) {
            console.warn(`Skipping row ${rowIndex} due to missing required fields`);
            return;
        }

        console.log('Uploading row:', rowIndex, rowData);

        const dataToSend = {
            username: rowData['Username'],
            display_name: rowData['Nombre Display'],
            correo: rowData['Correo'],
            password: rowData['Password'],
            fecha_nac: convertExcelDate(rowData['Fecha de nacimiento']),
            CURP: rowData['CURP'],
            domicilio: rowData['Domicilio'],
            telefono: rowData['Telefono'],
            nombre: rowData['Nombre'],
            apellido_p: rowData['Apellido Paterno'],
            apellido_m: rowData['Apellido Materno'],
            num_imss: rowData['Num_IMSS'],
            id_equipo: rowData['ID Equipo']
        };

        console.log('Data to send:', dataToSend);

        fetch('https://localhost:3443/jugadores/crear', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(dataToSend)
        })
        .then(response => {
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            return response.json();
        })
        .then(data => {
            console.log('Success:', data);
            fetchAndPrintTable(); // Reload the table on success
        })
        .catch(error => console.error('Error:', error));
    });
}


function convertExcelDate(excelDate) {
    if (!excelDate) return null;
    let date = new Date(excelDate);
    if (isNaN(date.getTime())) {
        const parts = excelDate.split('/');
        if (parts.length === 3) {
            // Adjust to match Date constructor format MM/DD/YYYY
            date = new Date(`20${parts[2]}`, parts[1] - 1, parts[0]);
        }
    }
    if (isNaN(date.getTime())) {
        console.error('Invalid date:', excelDate);
        return null;
    }
    return date.toISOString().split('T')[0];
}
