// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

//= require jquery3
//= require popper
//= require bootstrap-sprockets

import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"

document.addEventListener("turbo:load", function() {
  initializeTooltips();
});

document.addEventListener("turbo:frame-load", function() {
  initializeTooltips();
});

document.addEventListener("turbo:frame-render", function() {
  disposeTooltips();
});

let tooltipList = [];

function initializeTooltips() {
  const tooltipTriggerList = document.querySelectorAll('[data-bs-toggle="tooltip"]');
  tooltipList = [...tooltipTriggerList].map(tooltipTriggerEl => new bootstrap.Tooltip(tooltipTriggerEl));
}

function disposeTooltips() {
  tooltipList.forEach(tooltip => tooltip.dispose());
  tooltipList = [];
}
