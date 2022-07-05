const express = require('express')
const cors = require('cors')
const app = express()

app.use(cors())
app.use(express.json())
app.use("/api/v1/", require("./api"))

app.listen(3000, ()=>{
    console.log("web api is running..")
})