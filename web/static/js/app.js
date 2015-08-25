import {Socket, LongPoller} from "phoenix"

class App {

  static init() {
    let socket = new Socket("/socket", {
      logger: ((kind, msg, data) => { console.log(`${kind: ${msg}`, data) }) 
    })

    socket.connect({user_id: "123"})

    socket onOpen( ev => console.log("OPEN", ev) )
    socket onError( ev => console.log("ERROR", ev) )
    socket onClose( e => console.log("CLOSE", e) )

    var chan = socket.channel("tk:wilma", {})
    chan.join().receive("ignore", () => console.log("auth error")
        .receive("ok", () => console.log("join ok"))
        .after(10000, () => console.log("Connection interruption"))
    chan.onError(e => console.log("something went wrong", e))
    chan.onClose(e => console.log("channel closed"), e))

    $input.off("keypress").on("keypress", e => {
      if (e.keyCode == 13) {
        alert("before2")
        chan.push("new:msg", {hello: "world"})
        alert("after2")
      }
    })

    chan.on("new:msg", msg => {
      alert("new message: " + msg)
    })

    chan.on("user:entered", msg => {
      alert("entered: " + msg)
    }


  }


}

$( () => App.init() )

export default App
