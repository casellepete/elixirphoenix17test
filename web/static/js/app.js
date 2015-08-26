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
      var thisuserchannel = socket.channel("user:" + nameofuser, "greatthing")

      thisuserchannel.join()

        .receive("error", () => console.log("Failed to connect to " + nameofuser)) 
        .receive("ok", () => console.log("Connected to userchannel for " + nameofuser))

      thisuserchannel.on("is_in:true", msg => {
        row.data("is_in", true)
        updaterow(row)
      })

      thisuserchannel.on("is_in:false", msg => {
        row.data("is_in", false)
        updaterow(row)
      })

      thisuserchannel.on("tc:true", msg => {
        row.data("tc", true)
        updaterow(row)
      })

      thisuserchannel.on("tc:false", msg => {
        row.data("tc", false)
        updaterow(row)
      })

      row.find($(".punchin")).click(function(){
        thisuserchannel.push("punch:in", {hi: "der"})
      })
  
      row.find($(".punchout")).click(function(){
        thisuserchannel.push("punch:out", {hi: "der"})
      })
  
      row.find($(".tc")).click(function(){
        thisuserchannel.push("tc:toggle", {hi: "der"})
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


