var azureMobileApps = require("azure-mobile-apps");

/* crear tabla*/

var table = azureMobileApps.table();


table.columns = {
    "newsId" : "string",
    "valuation" : "Number"
};

//table.dynamicSchema = false;
table.access = "anonymous";
