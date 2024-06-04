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
                    <td class="mdl-data-table__cell--non-numeric">
                        <button class="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect button--colored-teal">Editar Información</button>
                    </td>
                </tr>`;
        }
    }
}

