const express = require("express")

const app = express()



app.get('/', (req, res) => {
    res.send("hello")
})

app.get('/users', (req, res) => {
    res.json([
        {
            name: 'linda',
            age: 20,
            email: 'linda@abc.com',
        },
        {
            name: 'kazaku',
            age: 24,
            email: 'kka@lalila.com',
        },
        {
            name: 'ami',
            age: 16,
            email: 'ami@hs.com',
        }
    ])
})

app.listen(3000)