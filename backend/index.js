const express = require("express"); 
const {createServer} = require("http"); 
const { Server } = require("socket.io");

const app = express(); 
const httpServer = createServer(app); 
const io = new Server(httpServer); 

app.route("/").get((req,res)=>{
    res.json("her server is on");
    console.log("hitted");
});

// connectin is predefined
io.on("connection",(socket)=>{
    console.log("frontend connected to backend")
});

// httpServer.listen(3000);
const localIP = '192.168.0.113'; // Replace with your PC's local IP address
const port = 3000;
httpServer.listen(port, localIP, () => {
    console.log(`Server listening on http://${localIP}:${port}`);
  });