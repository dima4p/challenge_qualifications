# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'click', 'body.qualifications.index a.show_subjects', ->
  height = $(document).height()
  $name = $(this)
  $qualification = $name.closest('.qualification')
  $subjects = $qualification.find('.subjects')
  $('.qualification').find('a.show_subjects').attr 'title', $name.attr('data-show')
  if $subjects.css('display') == 'none'
    $('.subjects').css 'display', 'none'
    $subjects.css 'display', 'inline-block'
    $name.attr 'title', $name.attr('data-hide')
    if $(document).height() > height
      $subjects.find('.subject_list').css 'bottom', '0'
  else
    $subjects.css 'display', 'none'
