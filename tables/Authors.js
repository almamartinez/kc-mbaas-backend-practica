
var azureMobileApps = require("azure-mobile-apps");

/* crear tabla*/

var table = azureMobileApps.table();

/*creamos columnas*/
table.columns = {
    "name" : "string",
    "surname" : "string",
    "idUser" : "string"
};

// Para hacer que la tabla sea estático y no podamos modificarlo
//table.dynamicSchema = false;

/*
 * Trigger para insert
 * */
table.insert(function(context){
    //Id Usuario que ha generado el insert, para añadirlo a la tabla:
    context.item.idUser = context.user.id;

    return context.execute();
});
/*
 * Permisos de acceso a la tabla
 */

table.read.access = 'anonymous';
table.update.access = 'authenticated';
table.insert.access = 'authenticated';
table.delete.access = 'authenticated';


// Añade la tabla al módulo
module.exports =  table;