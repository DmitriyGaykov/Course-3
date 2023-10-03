let gwrapper;

const peopleWrapper = document.querySelector('.people-wrapper')
const addForm = document.querySelector('.add-form')
const putForm = document.querySelector('.put-form')
const idInput = document.querySelector('.id')

const getList = async (wrapper, fill = true) => {
    const response = await fetch('/api/db')
    const data = await response.json()

    if(fill)
        data.forEach(el => addNote(wrapper, el))

    return data
}
const addPerson = async () => {
    const name = document.querySelector('.name').value
    const bday = document.querySelector('.bday').value

    if(!name || !bday)
        return alert('Provide data')

    const user = {
        name,
        bday
    }

    try {
        const resp = await fetch('/api/db', {
            body: JSON.stringify(user),
            method: 'POST',
            headers: {
                'Content-Type': 'text/json'
            }
        })

        const nuser = await resp.json()

        addNote(gwrapper, nuser)
    } catch (e) {
        return alert(e)
    }
}
const editInfo = async () => {
    const id = document.querySelector('.id')?.value
    const name = document.querySelector('.ename')?.value
    const bday = document.querySelector('.ebday')?.value

    const user = {}

    if(!id) {
        return alert('Provide id!')
    }

    user.id = parseInt(id)

    if (name)
        user.name = name

    if(bday)
        user.bday = bday

    try {
        const resp = await fetch('/api/db', {
            method: 'PUT',
            body: JSON.stringify(user),
            headers: {
                'Content-Type': 'text/json'
            }
        })

        const nuser = await resp.json()

        const note = document.querySelector(`#id${nuser.id}`)

        note.querySelector('.td-id').innerHTML = nuser.id
        note.querySelector('.td-name').innerHTML = nuser.name
        note.querySelector('.td-bday').innerHTML = nuser.bday
    } catch (e) {
        alert(e.message)
    }
}
const deletePerson = async id => {
    const answer = confirm(`Delete element with id ${id}?`)

    if(!answer)
        return

    try {
        await fetch(`/api/db?id=${id}`, {
            method: 'DELETE'
        })

        const note = document.querySelector(`#id${id}`)

        note.remove()
    } catch (e) {
        alert(e)
    }
}

const loadData = async id => {
    const name = document.querySelector('.ename')
    const bday = document.querySelector('.ebday')

    const data = await getList(peopleWrapper, false)

    const user = data.findLast(el => el.id == id)

    const date = new Date(user.bday)

    name.value = user.name
    bday.value = user.bday
}

const addNote = (wrapper, {id, name, bday}) => {
    gwrapper = wrapper
    const html = (
        `
            <div class="container align-items-center d-flex justify-content-between p-3 person-block" id="id${id}" onclick="deletePerson(${id})">
                <div class="td-id text-success fw-bold text-center w-25">${id}</div>
                <div class="td-name align-items-center p-4 d-flex justify-content-center h-100 bg-light bg-opacity-10 text-white text-center w-50">${name}</div>
                <div class="td-bday text-white text-center w-25">${bday}</div>
            </div>
        `)

    wrapper.innerHTML += html
}


getList(peopleWrapper).then()


addForm.onsubmit = async e => {
    e.preventDefault()
    await addPerson()
}

putForm.onsubmit = async e => {
    e.preventDefault()
    await editInfo()
}

idInput.onchange = async e => {
    const id = parseInt(e.target?.value)
    await loadData(id)
}