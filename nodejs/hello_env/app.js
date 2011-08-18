var http = require('http');
var url = require('url');

var host = (process.env.VCAP_APP_HOST || 'localhost');
var port = Number(process.env.VCAP_APP_PORT) || 3000;

e = ""
for (var key in process.env) {
  e += "<b>" + key + "</b>=" + process.env[key] + "<br/>\n"
}

http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/html'});
  res.write("I pushed this NodeJS application to CloudFoundry using Ubuntu's CloudFoundry vmc!</h2><br><br>\n\n<h2>Environment</h2>\n");
  res.write(e);
}).listen(port, host); 

console.log('Server running at http://' + host + ':' + port + '/');
