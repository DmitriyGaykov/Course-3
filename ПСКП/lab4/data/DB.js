import EventEmitter from 'events'

let db_data = [
    {id: 1, name: 'Dima', bday: new Date()},
    {id: 2, name: 'Olga', bday: new Date()},
    {id: 3, name: 'Oleg', bday: new Date()},
    {id: 4, name: 'Evgeniy', bday: new Date()},
    {id: 5, name: 'Elena', bday: new Date()},
]

export class DB extends EventEmitter {
    async select() {
        return new Promise(resolve => {
            return resolve([...db_data])
        })
    }

    async insert({ name, bday }) {
        return new Promise((resolve, reject) => {
            const id = Math.random() * 4_000_000_000
            let err = ''

            if(!name)
                err = 'Provide name!'
            if(!bday)
                err = 'Provide bday!'

            if(err !== '')
                reject(err)

            const newUser = {
                id,
                name,
                bday
            }

            db_data.push(newUser)
            resolve(newUser)
        })
    }

    async update({ id, name, bday }) {
        return new Promise((resolve, reject) => {
            let err = ''

            if(!id) {
                return reject('Provide id!')
            }

            const user = db_data.findLast(el => el.id === id)

            if(!user) {
                return reject('No user with ID ' + id)
            }

            user.name = name || user.name
            user.bday = bday || user.bday

            resolve({...user})
        })
    }

    async delete(id) {
        return new Promise((resolve, reject) => {
            let isExist = false

            db_data = db_data.filter(el => {
                if(el.id === id) {
                    isExist = true
                    return false
                }

                return true
            });

            (isExist ? resolve : reject)()
        })
    }
}