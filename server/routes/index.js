var express = require('express');
var router = express.Router();
fs = require('fs');
const arrayToTxtFile = require('array-to-txt-file')
const { exec } = require("child_process");

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.post('/dns', function (req, res) {
  console.log(req.body);
  res.send(req.body);

  fs.readFile("/etc/bind/zones/master/<db.YOUR_DOMANIN>", 'utf8', function (err,data) {
  if (err) {
    return console.log(err);
  }
  let dataList = data.toString().split("\n")
  dataList.pop()
  console.log(dataList)

  let dataListToWrite = dataList.map(item => item.includes(req.body.hostname) ? req.body.hostname+"\tIN\tA\t"+req.body.ip: item )

  //console.log(dataListToWrite)

  if(dataListToWrite.indexOf('') !== -1)
  {
    arrayToTxtFile(dataListToWrite, './db/db.temp', err => {
    if(err) {
      console.error(err)
      return
      }
    })

    fs.copyFile('./db/db.temp', '/etc/bind/zones/master/<db.YOUR_DOMANIN>', (err) => {
    if (err) throw err;
    console.log('Zone config file was copy');
    });


    exec("/etc/init.d/bind9 restart", (error, stdout, stderr) => {
        if (error) {
            console.log(`error: ${error.message}`);
            return;
        }
        if (stderr) {
            console.log(`stderr: ${stderr}`);
            return;
        }
        console.log(`stdout: ${stdout}`);
    });

    async function init() {
      console.log(1);
      await sleep(1000);
      console.log(2);
    }

    function sleep(ms) {
      return new Promise((resolve) => {
        setTimeout(resolve, 1000);
      });
    }

  }
  else
  {
          console.log("No hay cambios");
  }

  });

});

/* GET home page. */
router.get('/host/:hostName', function(req, res, next) {
  const hostName = req.params.hostName

    exec(`cat /etc/bind/zones/master/db.couso.com.ar | grep '${hostName}'`, (error, stdout, stderr) => {
        if (error) {
            console.log(`error: ${error.message}`);
            return;
        }
        if (stderr) {
            console.log(`stderr: ${stderr}`);
            return;
        }
        console.log(`stdout: ${stdout}`);
        //   res.send(`IPAddress`)
          res.send(stdout.match(/\d+\.\d+\.\d+\.\d+/g)[0]);
        });

});

module.exports = router;
