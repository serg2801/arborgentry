$(document).ready(function(){

    $(".radio_button_business_js .radio_button_group_js").click(function () {
        if ($('.radio_button_retailer_js').prop("checked")) {
            $(".sub_options_js").show();
        } else {
            $(".sub_options_js").hide();
            document.getElementById("dropship_e_commerce").checked = false;
            document.getElementById("stocking_dealer").checked = false;
            document.getElementById("non_stocking_dealer").checked = false;
        }
    });

    $(".radio_button_business_js .radio_button_group_js").click(function () {
        if ($('.radio_button_contract_js').prop("checked")) {
            $(".contract_details_js").show();
        } else {
            $(".contract_details_js").hide();
            $(".contract_details_js select").val("Select...");
        }
    });

});
