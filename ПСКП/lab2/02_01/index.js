const {join} = require("path");
const {readFile} = require("../scripts");

const ex02_01 = async (req, res) => {
    const _path = join(__dirname , '/index.html');
    const file = await readFile(_path)

    res.writeHead(200, {
        'Content-Type': 'text/html; charset=utf-8'
    })

    res.end(file)
}

module.exports = ex02_01;
