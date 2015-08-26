import {Socket} from "phoenix"

class App {
  static init() {

    var socket = new Socket("/socket")
    socket.connect()
    socket.onClose( e => console.log("Closed") )



    /////////////////////////////////////
    //        update comments          //
    /////////////////////////////////////

    var aCellIsOpen = false

  




    ///////////////////////////////////
    ///////////////////////////////////


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

      thisuserchannel.on("updated:comment", msg => {
        row.find($(".tkcomment")).html(msg["comment"])
      })






      row.find($(".punchin")).click(function(){
        thisuserchannel.push("punch:in", {user_id: row.data("user_id")})
      })
  
      row.find($(".punchout")).click(function(){
        thisuserchannel.push("punch:out", {user_id: row.data("user_id")})
      })
  
      row.find($(".tc")).click(function(){
        thisuserchannel.push("tc:toggle", {user_id: row.data("user_id")})
      })
  
      row.find($(".tkcomment")).click(function() {
        if ( !aCellIsOpen ) { 
          aCellIsOpen = true;
          var myComment = $(this).html();
          $(this).html('');
          $(this).append('<input id="tmpInput" type="text" style="width:90%;" data-orig="' + myComment + '" value="' + myComment + '">');
          $('#tmpInput').focus();

          $(document).on('blur', '#tmpInput', function(){
            updateComment(thisuserchannel, row.data("user_id") )
            aCellIsOpen = false
          }) 
        
          $(document).on('keypress', '#tmpInput', function( event ) { 
            if ( event.which == 13 ) { 
              updateComment(thisuserchannel, row.data("user_id"))
              aCellIsOpen = false
            }   
          }) 
  
        }   
      });

    })

  }


}

$( () => App.init() )

export default App




  //---------------------------------------//
  //              Functions                //
  //---------------------------------------//

function updateComment(thisuserchannel, user_id) {
  var newComment = $('#tmpInput').val();
  if (newComment != $('#tmpInput').data("orig") ) { 
    $('#tmpInput').text("...");
    thisuserchannel.push("update:comment", {user_id: user_id, comment: newComment})
  } else {
    $('#tmpInput').parent().text($('#tmpInput').data("orig"));
  }
}




function updaterow(row) {

  // update tc
  var imageTagForTc = row.data("tc") ? "<img src='/images/greenwifismall.png' />" : "<img src='/images/graywifismall.png' />" 
  row.find(".tc").html(imageTagForTc) 
  
  //update rowcolor
  var myColor = row.data("is_in") ? "lightgreen" : "#FFF"
  row.find($(".inout")).css("background-color", myColor)

  //update canvas
  var c = document.getElementById("canvas" + row.data("user_id"))
  var ctx = c.getContext("2d");
  ctx.fillStyle = "gray"
  ctx.fillRect(33,0,1,20)
  ctx.fillRect(71,0,1,20)
}

  

