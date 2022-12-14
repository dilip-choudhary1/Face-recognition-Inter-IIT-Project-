document.addEventListener("DOMContentLoaded", function() {

  var video = document.getElementById('video'), 
  captureCanvas = document.getElementById('captureCanvas'), 
  uploadCanvas = document.getElementById('uploadCanvas'), 
  captureContext = captureCanvas.getContext('2d'),
  uploadContext = uploadCanvas.getContext('2d'),
  uploadedPhoto = document.getElementById('uploadedPhoto'),
  capturedPhoto = document.getElementById('capturedPhoto'),
  imageUploadInput = document.querySelector('[name="image-upload"]')
  if(navigator.mediaDevices.getUserMedia){
    navigator.mediaDevices.getUserMedia({ video: true })
    .then(function(stream) {
      video.srcObject = stream;
    }).catch(function(error) {
      console.log(error)
    })
  }

 
function setImageToCanvas(image, id, canvas, context, width=image.width, height=image.height) {
  var ratio = width / height;
  var newWidth = canvas.width;
  var newHeight = newWidth / ratio;
  if (newHeight > canvas.height) {
    newHeight = canvas.height;
    newWidth = newHeight * ratio;
  }
  context.clearRect(0, 0, canvas.width, canvas.height);
  context.drawImage(image, 0, 0, newWidth, newHeight);
  id.setAttribute('src', canvas.toDataURL('image/png'));
}


document.getElementById('upload').addEventListener('click', function(){
  imageUploadInput.click();
})


imageUploadInput.addEventListener('change', function(){
  var ext = imageUploadInput.files[0]['name'].substring(imageUploadInput.files[0]['name'].lastIndexOf('.') + 1).toLowerCase();
  if (imageUploadInput.files && imageUploadInput.files[0] && (ext == "png" || ext == "jpeg" || ext == "jpg")) {
    var reader = new FileReader();
    reader.onload = function (e) {
      var img = new Image();
      img.src = e.target.result;
      img.onload = function() {
      setImageToCanvas(img, uploadedPhoto, uploadCanvas, uploadContext);
      }
    }
    reader.readAsDataURL(imageUploadInput.files[0]);
  }
})


document.getElementById('capture').addEventListener('click', function(){
  setImageToCanvas(video, capturedPhoto, captureCanvas, captureContext, video.videoWidth, video.videoHeight);
})



setImageToCanvas(uploadedPhoto, uploadedPhoto, uploadCanvas, uploadContext);
setImageToCanvas(capturedPhoto, capturedPhoto, captureCanvas, captureContext);
});


