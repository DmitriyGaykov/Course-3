const {join} = require("path");
const {readFile} = require("../scripts");
const ex02_05 = async (req, res) => {
    const path = join(__dirname, '/fetch.html')
    const file = await readFile(path)

    res.writeHead(200, {
        'Content-Type': 'text/html'
    })

    res.end(file)
}

module.exports = ex02_05