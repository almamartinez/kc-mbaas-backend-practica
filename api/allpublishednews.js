var api = {
    get: function (req, res, next) {

        if (typeof req.params.length < 0){
            return next();
        }

        var context = req.azureMobile;

        var query = {
            sql : "SELECT News.id,title, content, authorId, name, surname, photoPath, publishStatus, " +
            "(SELECT isnull(count(valuation),0) FROM Valuations WHERE Valuations.newsId = News.id) as numberValuations, " +
            "(SELECT isnull(AVG(valuation),0) FROM Valuations WHERE Valuations.newsId = News.id) as avgValuations," +
            "locateLongitude,locateLatitude," +
            "locateAddress FROM News JOIN Authors on News.authorID = Authors.idUser" +
                "WHERE publishStatus = 2"
        };
        console.log(query);
        context.data.execute(query)
            .then(function (result) {
                res.json(result);
            });
    }
};

api.access = 'anonymous';

module.exports = api;