const http = require('http');
const bodyParser = require('body-parser');
let express = require('express')

const app = express();
var mysql = require('mysql');
const { json } = require('express');

// Use body-parser to parse incoming requests
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));
app.use("/images", express.static("images"))



var con = mysql.createConnection({
    host: "localhost",
    user: "root",
    password: "",
    database: "baskel"
});

con.connect();



const hostname = '192.168.1.12';
const port = 3070;


//Client Insertion
app.post('/insert_client', (req, res) => {
    console.log(req.body);
    const email = req.body.email;
    const cin = req.body.cin;
    const password = req.body.password;
    const phone = req.body.phone;
    const nom = req.body.nom;
    const prenom = req.body.prenom;
    const adresse = req.body.adresse;
    con.query(`INSERT INTO client(email,cin,nom,prenom,tel,adresse,image) VALUES('${email}','${cin}','${nom}', '${prenom}','${phone}', '${adresse}', 'belha.jpg')`, function (err2, result) {
        if (err2) throw err2;
        con.query(`INSERT INTO authentification VALUES('${email}' , '${password}')`, function (err3, result) {
            if (err3) throw err3;
            res.send("success");
        });
    });
});

//search if client exist(by email)
app.post('/search_client', (req, res) => {
    const email = req.body.email;
    con.query(`SELECT * FROM authentification where login = '${email}'`, function (err1, result, fields) {
        if (err1) throw err1;
        if (result.length == 0) {
            res.send(true);
        } else {
            res.send(false);
        }
    });
});

//get client (by email)
app.post('/getClient', (req, res) => {
    const email = req.body.email;
    con.query(`SELECT * FROM client where email = '${email}'`, function (err1, result, fields) {
        if (err1) throw err1;
        if (result.length == 0) {
            res.send(false);
        } else {
            res.json(JSON.parse(JSON.stringify(result))[0]);
        }
    });
});

//search if client exist(by email)
app.post('/login', (req, res) => {
    const email = req.body.email;
    const password = req.body.password;

    con.query(`SELECT * FROM authentification where login = '${email}' and password ='${password}'`, function (err1, result, fields) {
        if (err1) throw err1;
        if (result.length == 0) {
            res.send(false);
        } else {
            res.send(true);
        }
    });
});

//get all bikes
app.post('/getBikes', (req, res) => {
    const email = req.body.email;
    con.query(`SELECT v.*, CASE WHEN lb.email = '${email}' THEN 'true' ELSE 'false' END AS 'liked' FROM vehicule v LEFT JOIN liked_bikes lb ON v.id = lb.id `, function (err1, result, fields) {
        if (err1) throw err1;
        if (result.length == 0) {
            res.send(false);
        } else {
            res.json(JSON.parse(JSON.stringify(result)));
        }
    });
});

//get all agencies
app.post('/getAgencies', (req, res) => {
    const email = req.body.email;
    con.query(`SELECT c.*, CASE WHEN lb.email = '${email}' THEN 'true' ELSE 'false' END AS 'liked' FROM agence c LEFT JOIN liked_agencies lb ON c.id_agence = lb.id `, function (err1, result, fields) {
        if (err1) throw err1;
        if (result.length == 0) {
            res.send(false);
        } else {
            res.json(JSON.parse(JSON.stringify(result)));
        }
    });
});

//get liked agencies
app.post('/getLikedAgencies', (req, res) => {
    const email = req.body.email;
    con.query(`SELECT agence.* FROM liked_agencies JOIN agence ON liked_agencies.id = agence.id_agence WHERE liked_agencies.email ='${email}'`, function (err1, result, fields) {
        if (err1) throw err1;
        if (result.length == 0) {
            res.send(false);
        } else {
            res.json(JSON.parse(JSON.stringify(result)));
        }
    });
});

//get liked bikes
app.post('/getLikedBikes', (req, res) => {
    const email = req.body.email;
    con.query(`SELECT vehicule.* FROM liked_bikes JOIN vehicule ON liked_bikes.id = vehicule.id WHERE liked_bikes.email ='${email}'`, function (err1, result, fields) {
        if (err1) throw err1;
        if (result.length == 0) {
            res.send(false);
        } else {
            res.json(JSON.parse(JSON.stringify(result)));
        }
    });
});

//user liked an agency
app.post('/likeAgence', (req, res) => {
    console.log(req.body);
    const email = req.body.email;
    const id = req.body.id;
    con.query(`INSERT INTO liked_agencies VALUES ('${email}','${id}')`, function (err1, result, fields) {
        if (err1) throw err1;
    });
});

//user dislike an agency
app.post('/dislikeAgence', (req, res) => {
    const email = req.body.email;
    const id = req.body.id;
    con.query(`DELETE FROM liked_agencies where email = '${email}' and id = '${id}'`, function (err1, result, fields) {
        if (err1) throw err1;
    });
});

//get Pistes
app.post('/getPistes', (req, res) => {
    const email = req.body.email;
    con.query(`SELECT * from piste_cyclable`, function (err1, result, fields) {
        if (err1) throw err1;
        if (result.length == 0) {
            res.send(false);
        } else {
            res.json(JSON.parse(JSON.stringify(result)));
        }
    });
});

//get Events
app.post('/getEvents', (req, res) => {
    con.query(`SELECT * from evenement`, function (err1, result, fields) {
        if (err1) throw err1;
        if (result.length == 0) {
            res.send(false);
        } else {
            res.json(JSON.parse(JSON.stringify(result)));
        }
    });
});



app.listen(port, hostname, () => {
    console.log(`Server running at http://${hostname}:${port}/`);
});