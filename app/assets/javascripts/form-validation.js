//= require jquery.validate
$(document).on('turbolinks:load', function(){
    $('#contactForm').validate({
        //Sets required fields for contact form
        rules: {
            name: 'required',
            email: 'required email',
            message: 'required'
        },
        //Error messages to be displayed for each field
        messages: {
            name: 'Please insert your name',
            email: 'Please insert a valid email address',
            message: 'Please insert a message'
        },
        errorElement: "i",
        submitHandler: function(form) {
            form.submit();
        }
    })
});
