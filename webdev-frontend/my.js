var $ = uploadcare.jQuery;
var w = uploadcare.SingleWidget('#uploader');
w.onChange(function(file) {
  if (file) {
    file.done(function(info) {
      $.ajax({
        url: info.cdnUrl + 'detect_faces/',
        dataType: "json",
        success: function(result) {
          if (result.faces.length == 0) {
            alert("No faces found!");
          }
          for (var face of result.faces) {
            var faceUrl = `${info.cdnUrl}-/crop/${face[2]}x${face[3]}/${face[0]},${face[1]}/-/preview/100x100/`;
            $('body').append(
              $('<img>', {"src": faceUrl})
            );
          }
        }
      });
    });
  };
});
