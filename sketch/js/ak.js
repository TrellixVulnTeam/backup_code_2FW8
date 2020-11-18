const fs = require("fs");
fs.stat('./a.txt', function(err, data) {
  console.log(data);
});