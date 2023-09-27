const powAsync = async (num, power) => {
    return new Promise((resolve, reject) => {
        try {
            if(!isFinite(num)) {
                throw 'Num is not a number'
            }

            const number = parseInt(num)
            return resolve(Math.pow(number, power))
        } catch (e) {
            return reject(e)
        }
    })
}

const square = async num => {
    return powAsync(num, 2)
}

const cube = async num => {
    return powAsync(num, 3)
}

const quartet =  async num => {
    return powAsync(num, 4)
}

(async () => {
    try {
        const num = '112'

        const res = await Promise.all([
            square(num),
            cube(num),
            quartet(num)
        ])

        console.log(res)
    } catch (e) {
        console.error('error: ', e)
    }
})()