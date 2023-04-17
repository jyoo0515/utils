const fs = require("fs");

const fileName = "PICKUP_POINT_MOVE_TO_ROAD";
const input = fs.readFileSync(`${fileName}.tsv`, "utf-8");
const rows = input.split("\n");

const result = [];
rows.forEach((row) => {
  const val = row.split("\t");
  result.push({
    title: val[0],
    geofence: val[1],
    // name: val[2],
    // nameForEnglish: val[3],
    // address: val[4],
  });
});

console.log(result);
fs.writeFileSync(`${fileName}.json`, JSON.stringify(result));
