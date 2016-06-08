$(document).on('click', ".email_checkbox", function () {
    $(".email_checkbox").change(function () {
        var count_checkbox = $('.email_checkbox:checked').size();
        if (count_checkbox > 0) {
            $('#move_to_trash').prop('disabled', false);
            $('#move_to_trash').addClass('bg_button');
        } else {
            $('#move_to_trash').prop('disabled', true);
            $('#move_to_trash').removeClass('bg_button');
        }
    });
});

$(document).on('click', "#checkAll", function () {
    var count_messages = $('.email_checkbox').size();
    if (count_messages > 0) {
        $('#checkAll').prop('disabled', false);
    } else {
        $('#checkAll').prop('disabled', true);
        $('#checkAll').prop('checked', false);
    }
    $('.email_checkbox').prop('checked', this.checked);
    $("#checkAll").change(function () {
        if ($('#checkAll').is(":checked")) {
            $('#move_to_trash').prop('disabled', false);
            $('#move_to_trash').addClass('bg_button');
        } else {
            $('#move_to_trash').prop('disabled', true);
            $('#move_to_trash').removeClass('bg_button');
        }
    });
});
$(document).on('click', ".email_checkbox", function () {
    $(".email_checkbox").change(function () {
        if ($('.email_checkbox').is(":checked")) {
            $(this).parents('.list-group-item').addClass( "highlight" );
        } else {
            $(this).parents('.list-group-item').removeClass( "highlight" );
        }
    });
});