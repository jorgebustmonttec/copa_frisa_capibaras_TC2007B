document.getElementById('fileInput').addEventListener('change', handleFileSelect, false);
document.getElementById('uploadButton').addEventListener('click', uploadData, false);

let jsonSheet;

function handleFileSelect(event) {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = function(e) {
            const data = new Uint8Array(e.target.result);
            const workbook = XLSX.read(data, {type: 'array'});
            const firstSheetName = workbook.SheetNames[0];
            const worksheet = workbook.Sheets[firstSheetName];
            jsonSheet = XLSX.utils.sheet_to_json(worksheet, {header: 1});
            jsonSheet = removeEmptyRows(jsonSheet);
            displayTable(jsonSheet);
            printData(jsonSheet);
        };
        reader.readAsArrayBuffer(file);
    }
}

function displayTable(data) {
    const table = document.getElementById('excelTable');
    table.innerHTML = "";
    data.forEach((row) => {
        const tr = document.createElement('tr');
        row.forEach((cell) => {
            const td = document.createElement('td');
            td.textContent = cell;
            tr.appendChild(td);
        });
        table.appendChild(tr);
    });
}

function printData(data) {
    const output = document.getElementById('output');
    output.textContent = JSON.stringify(data, null, 2);
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
        .then(data => console.log('Success:', data))
        .catch(error => console.error('Error:', error));
    });
}

function removeEmptyRows(data) {
    return data.filter(row => row.some(cell => cell !== undefined && cell !== null && cell !== ""));
}

function convertExcelDate(excelDate) {
    if (!excelDate) return null;
    const date = new Date((excelDate - (25567 + 1)) * 86400 * 1000);
    return date.toISOString().split('T')[0];
}
