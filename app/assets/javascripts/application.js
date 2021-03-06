// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery-ui
//= require jquery_ujs
//= require_tree .
//= require bootstrap.min


function shown(){
    $("#messageDialog").removeClass('hidden');
}
function hided(){
    $("#messageDialog").addClass('hidden');
}
function is_empty(){
    var textarea = document.getElementById('area');
    if(textarea.value === "" ) {
        alert( "Note cannot be empty!" );
        return false;
    }
    return true;
}


$(document).ready(function(){
    $( "#date_selector" ).on('change', function(){
        window.location = '/reports/daily?date=' + $(this).val();
    }).datepicker({dateFormat: "yy-mm-dd"});

    $('#submit_month_picker').click(function(){
        window.location = '/reports/monthly?date=' + $('#reports_date_1i').val() + '-' + $('#reports_date_2i').val();
    });
})


//= require turbolinks