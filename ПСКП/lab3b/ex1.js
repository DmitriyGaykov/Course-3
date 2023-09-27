import {main} from "./main.js";

const firstJob = async () => {
    return new Promise((resolve, reject) => {
        try {
            setTimeout(() => {
                resolve('Hello world')
            }, 2000)
        } catch (e) {
            reject(`error: ${e}`)
        }
    })
}

main(firstJob)
