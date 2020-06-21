// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
import "./application.pcss"

function handleClick() {
  if (document.querySelector('.drawer').dataset.state == 'open'){
    document.querySelector('.drawer').dataset.state = 'closed'
  } else {
    document.querySelector('.drawer').dataset.state = 'open'
  };
}


function ready(fn) {
  if (document.readyState != 'loading'){
    fn();
  } else {
    document.addEventListener('turbolinks:load', fn);
  }
}

function setup() {
  document.querySelector(`[data-button="hamburger"]`).addEventListener('click', handleClick);
}

ready(setup);
import "controllers"
