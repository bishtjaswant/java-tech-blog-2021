
    function likeButton(post_id,user_id) {

       const options={
            post_id,
           user_id,
           operation:"LIKE"
       };

        $.ajax({
            type: "POST",
            url: "LikeServlet",
            data:options,
            success: function (resp) {
                 console.log(resp);
                 if (resp.trim()==='true'){
                  let counter= $(".like_counter").html();
                  counter++;
                     $(".like_counter").html(counter);
                 }

            },
            error:function(error){
                console.error(error)
            }
        });

    }
