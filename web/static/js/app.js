import {Socket} from "phoenix"

class App {
  static init() {

    var socket = new Socket("/socket")
    socket.connect()
    socket.onClose( e => console.log("Closed") )


    $(".userrow").each(function(){

      var row = $(this);

      updaterow(row);

      var nameofuser = row.data("nameofuser")
      alert(nameofuser);
      var thisuserchannel = socket.channel("user:" + nameofuser, "greatthing")

      thisuserchannel.join()

        .receive("error", () => console.log("Failed to connect to " + nameofuser)) 
        .receive("ok", () => console.log("Connected to userchannel for " + nameofuser))

      thisuserchannel.on("punched:in", msg => {
        console.log(nameofuser + "IN: " + msg)
        row.data("is_in", true)
        updaterow(row)
        console.log(row.data("is_in"))
      })

      thisuserchannel.on("punched:out", msg => {
        console.log(nameofuser + "OUT: " + msg) 
        row.data("is_in", false)
        updaterow(row)
        console.log(row.data("is_in"))
      })

      row.find($(".punchin")).click(function(){
        thisuserchannel.push("punch:in", {hi: "der"})
      })
  
      row.find($(".punchout")).click(function(){
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


