const excelToJson = require('convert-excel-to-json');
var fs = require('fs')
var result = excelToJson({
  source: fs.readFileSync(process.argv[2]),
});
fs.writeFile('returned.json', JSON.stringify(result['Feuil1']), function (err) {
  if (err) return console.log(err)
})
process.exit()