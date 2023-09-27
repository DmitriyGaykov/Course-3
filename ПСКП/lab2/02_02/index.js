const {readFile} = require("../scripts");
const {join} = require("path");
const ex02_02 = async (req, res) => {
    const path = join(__dirname, '/pic.png')
    const file = await readFile(path)

    res.writeHead(200, {
        'Content-Type' : 'image/png;'
    })

    res.end(file)
}

module.exports = ex02_02;