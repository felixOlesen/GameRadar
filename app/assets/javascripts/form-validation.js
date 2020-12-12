//= require jquery.validate

$(document).on('turbolinks:load', function(){
    $('#contactForm').validate({
        rules: {
            name: 'required',
            email: 'required email',
            message: 'required'
        },
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
