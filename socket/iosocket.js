

const openLiveServer=(io)=>{

    io.on("connection",(socket)=>{

        console.log("liver server is listening");

        socket.on("invoke",(userMsg)=>{
            console.log(userMsg);
            socket.emit("getdata",userMsg)
        }  
        )

       
    
    })


}


module.exports = {openLiveServer};

