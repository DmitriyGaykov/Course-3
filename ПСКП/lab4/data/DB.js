import EventEmitter from 'events'

let db_data = [
    {id: 1, name: 'Dima', bday: '2023-02-03'},
    {id: 2, name: 'Olga', bday: '2023-01-12'},
    {id: 3, name: 'Oleg', bday: '2023-05-04'},
    {id: 4, name: 'Evgeniy', bday: '2023-01-04'},
    {id: 5, name: 'Elena', bday: '2023-02-04'},
]

export class DB extends EventEmitter {
    async select() {
        return new Promise(resolve => {
            return resolve([...db_data])
        })
    }

    async insert({ name, bday }) {
        return new Promise((resolve, reject) => {
            let id;
            do {
                id = Math.floor(Math.random() * 4_000_000_000)
            } while(db_data.map(el => el.id).includes(id));

            let err = ''

            if(!name)
                err = 'Provide name!'
            if(!bday)
                err = 'Provide bday!'

            if(new Date().toISOString().split("T")[0] < bday) {
                err += '\nDate is more than current date'
            }

            if(err !== '')
                return reject(err)

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

            console.log(new Date().toISOString().split("T")[0], bday)

            if(new Date().toISOString().split("T")[0] < bday) {
                return reject('Bday is more than current date')
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