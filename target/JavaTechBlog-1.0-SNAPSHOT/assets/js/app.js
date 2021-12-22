
$(document).ready(function () {
 
    $("#editBtn").on("click", function (e) {
        
        $("#profile_info").hide();
        $("#edit_profile_info").show();
        $("#cancelBtn").show();
        $(this).text("Update");

        if (document.querySelector("#editBtn").innerText.includes("Update")) {
            updateProfileData()
        }

    });

    $("#cancelBtn").click(function () {
        $("#profile_info").show();
        $("#edit_profile_info").hide();
        $("#cancelBtn").hide();
        $("#editBtn").text("Edit")
    })
});



function updateProfileData() {
    let newName = $("#newName").val();
    let newEmail = $("#newEmail").val();
    let newGender = $("#newGender").val();
    let newAboutYourself = $("#newAboutYourself").val();



    if (newName == '', newEmail == '', newGender == '', newAboutYourself == '') {
 
    } else {
    
        
        
        $("#formData").on('click', function (params) {
          
            let formData = new FormData(this);
      
            //ajax
            $.ajax({
                url: "ProfileUpdateServlet",
                cache: false,
                async: true,
                type: "POST",
                data: formData,
                success: function (data, xhr, status) {
                    console.log(data);
                    if (data.response.status=='true') {
                        $("#error").show();
                        $("#error").text(data.response.message);
                    }
                    else if (data.response.status=='false') {
                        $("#error").show();
                        $("#error").text(data.response.message);
                    }
        
                },
                error: function (xhr, status, err) {
                    console.log(err)
                },
                contentType: false,
                processData: false,
            });
            
            
        })


    }


}

 


function openFile(inputFile) {
    let reader = new FileReader();
    reader.onload = function (e) {

        let user_avatar = document.querySelector("#user_avatar");
        user_avatar.src = reader.result

    }
    reader.readAsDataURL(inputFile.files[0])
};