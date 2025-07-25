$(() => {
    window.addEventListener("message", function(event){
    
        if( event.data.abrir != undefined){
        let estatuses = event.data.abrir
        
    
            
            if(estatuses){
                $("body").show()
            }else{
                $("body").hide()
            }
    
    
    
    
            document.onkeyup = function(data){
                if (data.which == 27){
                    $.post("http://CM_CarControl/Close");
                }
            };
        }
    
        if(event.data.action != undefined){
            let crose = event.data.action
            if(crose){
                $("body").hide()
            }
        }
    
    })	
    $("body").hide()
        $(".botaos").click(function(){
            $.post("https://CM_CarControl/botaos")
        })
        $(".botaod").click(function(){
            $.post("https://CM_CarControl/botaod")
        })
        $(".botaosm").click(function(){
            $.post("https://CM_CarControl/botaosm")
        })
        $(".botaodm").click(function(){
            $.post("https://CM_CarControl/botaodm")
        })
    })