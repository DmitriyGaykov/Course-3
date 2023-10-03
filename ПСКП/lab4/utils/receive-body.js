export const receiveBody = req => {
    req.on('data', buffer => {
        const data = buffer?.toString()
        try {
            req.body = JSON.parse(data)
        } catch {
            req.body = data
        }
    })
}