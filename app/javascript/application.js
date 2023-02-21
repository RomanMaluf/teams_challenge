// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "bootstrap"
import { on } from "custom/utilities" 

document.addEventListener('DOMContentLoaded', () => {
  const toggleButton =  () => {
    if (document.getElementById('body').classList.contains('toggle-sidebar')) {
      document.getElementById('body').classList.remove('toggle-sidebar')
    }else{
      document.getElementById('body').classList.add('toggle-sidebar')
    }
  }
  on('click', '.toggle-sidebar-btn', toggleButton)
},{ once: true });
