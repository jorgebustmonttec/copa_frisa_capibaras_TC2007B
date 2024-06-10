document.addEventListener('DOMContentLoaded', function() {
    const fileInput = document.getElementById('fileInput');
    const uploadButton = document.getElementById('uploadButton');

    fileInput.addEventListener('change', handleFileSelect, false);
    uploadButton.addEventListener('click', uploadData, false);

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
            };
            reader.readAsArrayBuffer(file);
        }
    }

    function displayTable(data) {
        const table = document.getElementById('excelTable');
        const tbody = table.querySelector('tbody');
        tbody.innerHTML = ""; // Clear any existing rows
        data.forEach((row) => {
            const tr = document.createElement('tr');
            row.forEach((cell) => {
                const td = document.createElement('td');
                td.textContent = cell;
                tr.appendChild(td);
            });
            tbody.appendChild(tr);
        });
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

            if (!rowData['Nombre'] || !rowData['Correo']) {  // Adjust the required fields based on your needs
                console.warn(`Skipping row ${rowIndex} due to missing required fields`);
                return;
            }

            fetch('https://localhost:3443/jugadores/crear', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(rowData)
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
});
