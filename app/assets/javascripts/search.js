$(document).ready(function() {

  window.wiselinks = new Wiselinks();

  $(document).off('page:done').on('page:done', function(event, $target, status, url, data) {
    var query = $("#js-query").val().split('(')[0].trim();
    getPlaylist(query);
  });

  var opts = {
    lines: 13, // The number of lines to draw
    length: 15, // The length of each line
    width: 7, // The line thickness
    radius: 20, // The radius of the inner circle
    corners: 1, // Corner roundness (0..1)
    rotate: 0, // The rotation offset
    direction: 1, // 1: clockwise, -1: counterclockwise
    color: '#000', // #rgb or #rrggbb or array of colors
    speed: 1, // Rounds per second
    trail: 60, // Afterglow percentage
    shadow: false, // Whether to render a shadow
    hwaccel: false, // Whether to use hardware acceleration
    className: 'spinner', // The CSS class to assign to the spinner
    zIndex: 2e9, // The z-index (defaults to 2000000000)
    top: '50%', // Top position relative to parent
    left: '50%' // Left position relative to parent
  };

  var getPlaylist = function(query) {
    $('#js-loading').html("Loading Playlist...");
    $("#js-playlist tbody").html("");
    $("#js-warning").html("");
    $.post("/searches", {query: query}, function(data) {
      pollForPlaylist(data.id)
    });
  }

  var pollForPlaylist = function(searchId) {
    $.getJSON("/searches/" + searchId, function(data) {
      if (data.playlist != null) {
        if (data.playlist.songs.length !== 0) {
          showPlaylist(data.playlist);
        } else if (data.playlist.warning != null) {
          $("#js-warning").html(data.playlist.warning);
        } else {
          setTimeout(function() {pollForPlaylist(data.id)}, 3000);
        }
      } else {
        setTimeout(function() {pollForPlaylist(data.id)}, 3000);
      }
    });
  }

  var showPlaylist = function(playlist) {
    $("#js-loading").text("");
    $("a#js-create-playlist").attr("href", "/auth/spotify?id=" + playlist.id)
    $.each(playlist.songs, function(i, song) {
      $("#js-playlist tbody").append("<tr>" +
                               "<td>" + song.score.toFixed(2) + "</td>" +
                               "<td>" + song.name + "</td>" +
                               "<td>" + song.last_performed + "</td>" +
                               "<td>" + song.performance_count + "</td>" +
                               "<td>" + song.popularity + "</td></tr>");
    });
  }

  var query = $("#js-query").val().split('(')[0].trim();
  if (query != null || query != "") {
    getPlaylist(query);
  }

  $("#js-query").autocomplete({
    source: "/search_suggestions",
    select: function(event, ui) {
      $("#js-query").val(ui.item.value.split('('));
      $("#js-search").click();
    }
  });

});
