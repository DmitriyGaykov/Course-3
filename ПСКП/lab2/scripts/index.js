const fs = require('fs')

const readFile = async (path) => {
    try {
        return await fs.promises.readFile(path)
    } catch (e) {
        console.error(e)
        return ''
    }
}

module.exports = {
    readFile
}