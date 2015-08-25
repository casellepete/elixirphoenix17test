import {Socket} from "phoenix"

class App {
  static init() {

    var socket = new Socket("/socket")
    socket.connect()
    socket.onClose( e => console.log("Closed") )


    $(".userrow").each(function(){

      updaterow($(this));

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






function updaterow(row) {

  // update tc
  var imageTagForTc = row.data("tc") ? "<img src='/images/greenwifismall.png' />" : "<img src='/images/graywifismall.png' />" 
  row.find(".tc").html(imageTagForTc) 
  
  //update rowcolor
  var myColor = row.data("is_in") ? "lightgreen" : "#FFF"
  row.find($(".inout")).css("background-color", myColor)
}


