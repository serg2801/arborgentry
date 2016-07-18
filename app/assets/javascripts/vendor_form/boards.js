$(document).on("page:change", function () {

    $("#add_brand_name").trigger("click");
    $(".nested-fields .brand_name").find(".remove_brand_js").hide();

    $("#add_another_location").trigger("click");
    $(".nested-fields .ship_information").find(".remove_ship_information_js").hide();

    $("#add_another_carrier").trigger("click");
    $(".nested-fields .another_carrier").find(".remove_another_carrier_js").hide();

    $("#add_another_product_type").trigger("click");
    $(".nested-fields .product_type").find(".remove_another_product_type_js").hide();

    $("#show_order_js").click(function (e) {
        e.preventDefault();
        $("#contact_order_js").toggle();
    });

    $("#show_inventory_js").click(function (e) {
        e.preventDefault();
        $("#contact_inventory_js").toggle();
    });

    $("#show_return_js").click(function (e) {
        e.preventDefault();
        $("#contact_return_js").toggle();
    });

    $("#show_information_js").click(function (e) {
        e.preventDefault();
        $("#contact_information_js").toggle();
    });

    $("#show_service_js").click(function (e) {
        e.preventDefault();
        $("#contact_service_js").toggle();
    });
    $("#show_other_js").click(function (e) {
        e.preventDefault();
        $("#contact_other_js").toggle();
    });

    $("#remove_contact_order_js").click(function () {
        $("#contact_order_js").toggle();
    });

    $("#remove_contact_inventory_js").click(function () {
        $("#contact_inventory_js").toggle();
    });

    $("#remove_contact_return_js").click(function () {
        $("#contact_return_js").toggle();
    });

    $("#remove_contact_information_js").click(function () {
        $("#contact_information_js").toggle();
    });

    $("#remove_contact_service_js").click(function () {
        $("#contact_service_js").toggle();
    });

    $("#remove_contact_other_js").click(function () {
        $("#contact_other_js").toggle();
    });

    $(".form-group .radio_button_js").click(function () {
        if (document.getElementById("radio_button_other_js").checked) {
            $("#form_other_js").show();
        } else {
            $("#form_other_js").hide();
            $("#form_other_js").val("");
        }
    });

    $(".form-group .radio_inventory_js").click(function () {
        if (document.getElementById("radio_inventory_js").checked) {
            $("#form_other_inventory_js").show();
        } else {
            $("#form_other_inventory_js").hide();
            $("#form_other_inventory_js").val("");
        }
    });

    $(".form-group .radio_button_method_js").click(function () {
        if (document.getElementById("radio_method_other_js").checked) {
            $("#form_method_other_js").show();
        } else {
            $("#form_method_other_js").hide();
            $("#form_method_other_js").val("");
        }
    });

    $(".form-group .radio_button_frequency_js").click(function () {
        if (document.getElementById("radio_frequency_other_js").checked) {
            $("#form_frequency_other_js").show();
        } else {
            $("#form_frequency_other_js").hide();
            $("#form_frequency_other_js").val("");
        }
    });
    $(".form-group .radio_button_costs_fees_js").click(function () {
        if (document.getElementById("radio_costs_fees_yes_js").checked) {
            $(".form_costs_fees_other_js").show();
        } else {
            $(".form_costs_fees_other_js").hide();
            //$(".form_costs_fees_other_js").val("");
            $(".form_costs_fees_other_js .costs_fees").val("");
        }
    });
    $(".form-group .radio_button_purchase_orders_js").click(function () {
        if (document.getElementById("radio_purchase_orders_yes_js").checked) {
            $(".purchase_orders_block_js").show();
        } else {
            $(".purchase_orders_block_js").hide();
            $(".purchase_orders_block_js .purchase_order").val("");
        }
    });


    $('#brand_name_form_list')
        .on('cocoon:before-insert', function () {
            $("#brand_name_form_list .field input:text").each(function () {
                var input = $(this);
                if (input.val() == "") {
                    input.parents('.nested-fields').hide();
                    input.parents('.nested-fields').find(".remove_brand_js").trigger("click");
                }
            });
        })
        .on('cocoon:after-insert', function () {
            $('#brand_name_form_list .nested-fields').css("background","#edefef");
        });

    $('#another_carrier_form_list')
        .on('cocoon:before-insert', function () {
            $("#another_carrier_form_list .field input:text").each(function () {
                var input = $(this);
                if (input.val() == "") {
                    input.parents('.nested-fields').hide();
                    input.parents('.nested-fields').find(".remove_another_carrier_js").trigger("click");
                }
            });
        })
        .on('cocoon:after-insert', function () {
            $('#another_carrier_form_list .nested-fields').css("background","#edefef");
        });

    $('#another_product_type_form_list')
        .on('cocoon:before-insert', function () {
            $("#another_product_type_form_list").find(":selected").each(function () {
                var input = $(this);
                if (input.val() == "") {
                    input.parents('.nested-fields').hide();
                    input.parents('.nested-fields').find(".remove_another_product_type_js").trigger("click");
                }
            });
        })
        .on('cocoon:after-insert', function () {
            $('#another_product_type_form_list .nested-fields').css("background","#edefef");
        });

    $('#another_location_form_list')
        .on('cocoon:before-insert', function () {
            $("#another_location_form_list .field input:text").each(function () {
                var input = $(this);
                if (input.val() == "") {
                    input.parents('.nested-fields').hide();
                    input.parents('.nested-fields').find(".remove_ship_information_js").trigger("click");
                }
            });
        });
});