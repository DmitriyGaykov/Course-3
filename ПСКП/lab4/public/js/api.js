const getList = async wrapper => {
    const response = await fetch('/api/db')
    const data = await response.json()

    const html = data.map(({id, name, bday}) => {
        return(
        `
            <div class="container d-flex justify-content-between p-3">
                <div class="text-success fw-bold text-center w-25">${id}</div>
                <div class="text-white text-center w-50">${name}</div>
                <div class="text-white text-center w-25">${bday}</div>
            </div>
        `)
    })

    wrapper.innerHTML += html.join('')
}

const peopleWrapper = document.querySelector('.people-wrapper')

getList(peopleWrapper).then()