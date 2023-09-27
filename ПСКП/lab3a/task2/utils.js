export const fact = n => {
    if(typeof n === 'number' && n % 1 === 0 && n > 0) {
        return n * fact(n - 1)
    }

    return 1
}