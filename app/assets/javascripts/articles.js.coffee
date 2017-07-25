$ ->
  $('#articles').imagesLoaded ->
    $('#articles').masonry
    itemSelector: '.box'
    isFitWidth: true
    
