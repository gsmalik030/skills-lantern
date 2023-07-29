// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "trix"
import "@rails/actiontext"
import "popper"
import "chartkick"
import "Chart.bundle"
import "bootstrap"
import "@fortawesome/fontawesome-free/js/all"
  FontAwesome.config.mutateApproach = 'sync'

window.addEventListener("trix-file-accept", function(event) {
  event.preventDefault()
  alert("File attachment not supported!")
})

