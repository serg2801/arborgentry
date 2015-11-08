// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require pace
//= require jquery
//= require jquery_ujs
//= require jquery.remotipart
//= require dropzone
//= require bootstrap
//= require modernizr.custom
//= require jRespond.min
//= require jquery.slimscroll
//= require jquery.slimscroll.horizontal.min
//= require fastclick
//= require jquery.velocity.min
//= require jquery.quicksearch
//= require bootbox
//= require date
//= require flot/jquery.flot.custom
//= require flot/jquery.flot.pie
//= require flot/jquery.flot.resize
//= require flot/jquery.flot.time
//= require flot/jquery.flot.growraf
//= require flot/jquery.flot.categories
//= require flot/jquery.flot.stack
//= require flot/jquery.flot.orderBars
//= require flot/jquery.flot.tooltip.min
//= require flot/jquery.flot.curvedLines
//= require sparklines/jquery.sparkline
//= require datatables/jquery.dataTables
//= require datatables/dataTables.tableTools
//= require datatables/dataTables.bootstrap
//= require datatables/dataTables.responsive
//= require progressbars/progressbar
//= require plugins/waypoint/waypoints
//= require plugins/weather/skyicons
//= require plugins/notify/jquery.gritter
//= require plugins/misc/vectormaps/jquery-jvectormap-1.2.2.min
//= require plugins/misc/vectormaps/maps/jquery-jvectormap-world-mill-en
//= require plugins/misc/countTo/jquery.countTo
//= require jquery.dynamic
//= require main
//= require tables-data
//= require dashboard
//= require jquery_nested_form
//= require jquery.validate.min


function remove_fields(link) {
	$(link).prev("input[type=hidden]").val(true);
	$(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g");
  content = content.replace(regexp, new_id)
  $(link).before(content);
  // $(link).up().insert({
  //       before: content.replace(regexp, new_id)
  // });
}