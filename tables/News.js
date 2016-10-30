var azureMobileApps = require("azure-mobile-apps");

/* crear tabla*/

var table = azureMobileApps.table();


table.columns = {
    "title" : "string",
    "content" : "string",
    "photoPath" : "string",
    "authorID" : "string",
    "publishStatus" : "number", //0-draft, 1-ready (not visible), 2-published (visible)
    "locateLongitude" : "number",
    "locateLatitude" : "number",
    "locateAddress" : "string"
};


//table.dynamicSchema = false;

table.insert(function(context){
    //Id Usuario que ha generado el insert, para añadirlo a la tabla:
    context.item.authorId = context.user.id;

    return context.execute();
});


table.read.access = 'anonymous';
table.update.access = 'authenticated';
table.insert.access = 'authenticated';
table.delete.access = 'authenticated';


// Añade la tabla al módulo
module.exports =  table;