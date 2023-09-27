const {readFile} = require("../scripts");
const {join} = require("path");
const ex02_04 = async (req, res) => {
    const path = join(__dirname, '/xmlhttprequest.html')
    const file = await readFile(path)

    res.writeHead(200, {
        'Content-Type': 'text/html'
    })

    res.end(file)
}

module.exports = ex02_04