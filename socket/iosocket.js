const { Server, Socket } = require('socket.io');

const io = new Server({cors:'http://localhost:3000'});

const openLiveServer=()=>{

    io.on("connection",(socket)=>{

        console.log("liver server is listening");

        socket.on("invoke",(userMsg)=>{
            console.log(userMsg);
            socket.emit("getdata","hell yeah")
        }  
        )

       
    
    })

    
    
    io.listen(3001);
}


module.exports = {openLiveServer};

