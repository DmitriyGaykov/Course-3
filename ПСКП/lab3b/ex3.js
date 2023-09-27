import {main} from "./main.js";

const thirdJob = async (data) => {
    return new Promise((resolve, reject) => {
        try {
            if(!isFinite(data)) {
                throw `error`
            }

            const num = parseInt(data)

            return resolve(num % 2 === 0 ? 'even' : 'odd');
        } catch (e) {
            reject(e)
        }
    })
}

main( () => thirdJob(1));