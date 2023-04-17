const fs = require("fs");

const inputFileName = "loyalty_program_target_raw.json";
const input = fs.readFileSync(inputFileName, "utf-8");
const jsonArray = JSON.parse(input);

const userIds = jsonArray.map((element) => {
  return element.user_id;
});

const outputFileName = "loyalty_program_target.json";
fs.writeFileSync(outputFileName, JSON.stringify(userIds));
