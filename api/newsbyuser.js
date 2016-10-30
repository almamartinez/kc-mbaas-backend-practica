var api = {
    get: function (req, res, next) {

        if (typeof req.params.length < 0){
            return next();
        }

        var context = req.azureMobile;
        var user = context.user.id;

        var query = {
            sql : "SELECT title, content, authorId, name, surname, photoPath, publishStatus, " +
            "(SELECT count(valuation) FROM Valuations WHERE Valuations.newsId = News.id) as numberValuations, " +
            "(SELECT AVG(valuation) FROM Valuations WHERE Valuations.newsId = News.id) as avgValuations," +
            "locateLongitude,locateLatitude," +
            "locateAddress FROM News JOIN Authors on News.authorID = Authors.idUser" +
                " WHERE idUser = '" + user + "'"
        };

        console.log (query);
        req.azureMobile.data.execute(query)
            .then(function (result) {
                console.log(result);
                res.json(result);
        });
    }
};

api.get.access = 'authenticated';

module.exports = api;
