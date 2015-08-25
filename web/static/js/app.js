import {Socket} from "phoenix"

class App {
  static init() {

    var socket = new Socket("/socket")
    socket.connect()
    socket.onClose( e => console.log("Closed") )


//    var userchannel = socket.channel("user:Wilma", "greatthing")
//
//    userchannel.join()
//      .receive("error", () => console.log("Failed to connect to userchannel"))
//      .receive("ok", () => console.log("Connected to userchannel!"))
//
//    userchannel.on("punched:in", msg => console.log("IN: " + msg) )
//    userchannel.on("punched:out", msg => console.log("OUT: " + msg) )
//
//
//
//    $(".punchin").click(function(){
//      userchannel.push("punch:in", {hi: "der"})
//    })
//
//    $(".punchout").click(function(){
//      userchannel.push("punch:out", {hi: "wonder"})
//    })

    $(".userrow").each(function(){

      var nameofuser = $(this).data("nameofuser")
      var thisuserchannel = socket.channel("user:" + nameofuser, "greatthing")

      thisuserchannel.join()
        .receive("error", () => console.log("Failed to connect to " + nameofuser))
        .receive("ok", () => console.log("Connected to userchannel for " + nameofuser))

      thisuserchannel.on("punched:in", msg => console.log(nameofuser + "IN: " + msg) )
      thisuserchannel.on("punched:out", msg => console.log(nameofuser + "OUT: " + msg) )

      $(this).find($(".punchin")).click(function(){
        thisuserchannel.push("punch:in", {hi: "der"})
      })
  
      $(this).find($(".punchout")).click(function(){
        thisuserchannel.push("punch:out", {hi: "der"})
      })
  

    })

  }


}

$( () => App.init() )

export default App

