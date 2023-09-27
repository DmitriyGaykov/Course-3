const powAsync = async (num, power, time) => {
    return new Promise((resolve, reject) => {
        try {
            if(!isFinite(num)) {
                throw 'Num is not a number'
            }
            if(time && !isFinite(time)) {
                throw 'Time is not a number'
            }

            const number = parseInt(num)
            if(!time) {
                return resolve(Math.pow(number, power))
            }
            time = parseInt(time)

            if(time < 0) {
                throw 'Time should be more than 0'
            }

            setTimeout(() => {
               resolve(Math.pow(number, power))
            }, time)
        } catch (e) {
            return reject(e)
        }
    })
}

const square = async num => {
    return powAsync(num, 2, 1400)
}

const cube = async num => {
    return powAsync(num, 3, 1000)
}

const quartet =  async num => {
    return powAsync(num, 4, 400)
}

(async () => {
    try {
        const num = '112'

        const res = await Promise.race([
            square(num),
            cube(num),
            quartet(num)
        ])

        console.log(res)
    } catch (e) {
        console.error('error: ', e)
    }
})()