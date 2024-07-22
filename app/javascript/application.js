// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "@hotwired/turbo-rails"
import "controllers"

import "trix"
import "@rails/actiontext"

import "@popperjs/core"
import "bootstrap"

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
