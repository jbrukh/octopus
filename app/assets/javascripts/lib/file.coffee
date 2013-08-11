file =
  download: (url) ->
    # download a file using a hidden iframe so we don't have to pop a new tab open
    # http://stackoverflow.com/questions/3749231/download-file-using-javascript-jquery
    hiddenIFrameID = 'hiddenDownloader'
    iframe = document.getElementById(hiddenIFrameID)

    if iframe == null
      iframe = document.createElement('iframe');
      iframe.id = hiddenIFrameID;
      iframe.style.display = 'none';
      document.body.appendChild(iframe);

    iframe.src = url

root = exports ? this
root.file = file