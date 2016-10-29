/**
 * Created by almamartinez on 29/10/16.
 */
var express = require("express"),
    azuremobapps = require("azure-mobile-apps");

var app = express(),
    mobile = azuremobapps({ swagger: process.env.NODE_ENV !== 'production'});



mobile.tables.import("./tables");
mobile.api.import("./api");

app.use(mobile);

app.listen(process.env.PORT || 3000);