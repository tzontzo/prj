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
    $( "#selector" ).on('change', function(){
        window.location = '/reports?date=' + $(this).val();
    }).datepicker({dateFormat: "yy-mm-dd"})
    }
);
$(document).ready(function(){
    $( "#monthselect" ).on('change', function(){
        window.location = '/reports/tasks?month=' + $(this).val();
    }).datepicker({changeMonth: true,
        changeYear: true,
        showButtonPanel: true,
        dateFormat: "yy-mm"});

    }
);

//= require turbolinks