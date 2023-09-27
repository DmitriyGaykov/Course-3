export const main = async (job) => {
    job()
        .then(res => console.log('then: ', res))
        .catch(err => console.error('catch: ', err))

    try {
        console.log('async: ', await job())
    } catch (e) {
        console.error('async catch: ', e)
    }
}