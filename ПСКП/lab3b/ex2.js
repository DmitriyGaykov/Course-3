import {main} from "./main.js";

const secondJob = async () => {
    return new Promise((resolve, reject) => {
        setTimeout(() => {
            reject(`error: Exception after 3 seconds`)
        }, 3000)
    })
}

main(secondJob)
