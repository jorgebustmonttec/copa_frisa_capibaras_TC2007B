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

    ID(){

        return this.row[0]

    }
    Name(){

        return this.row[1]

    }

    IDTeam(){

        return this.row[2]

    }

    TeamName(){

        return this.row[3]

    }

    Username(){

        return this.row[4]

    }

    DisplayName(){

        return this.row[5]

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
                    <td class="mdl-data-table__cell--non-numeric">${row.ID()}</td>
                    <td class="mdl-data-table__cell--non-numeric">${row.Name()}</td>
                    <td class="mdl-data-table__cell--non-numeric">${row.IDTeam()}</td>
                    <td class="mdl-data-table__cell--non-numeric">${row.TeamName()}</td>
                    <td class="mdl-data-table__cell--non-numeric">${row.Username()}</td>
                    <td class="mdl-data-table__cell--non-numeric">${row.DisplayName()}</td>
                    <td class="mdl-data-table__cell--non-numeric">
                        <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect button--colored-teal">Editar Información</button>
                    </td>
                </tr>`;
        }
    }
}



const excelInput = document.getElementById('excel-input');

excelInput.addEventListener('change', async function() {
    const content = await readXlsxFile(excelInput.files[0]);
    const excel = new Excel(content);
    console.log(ExcelPrinter.print('excel-table', excel));
});