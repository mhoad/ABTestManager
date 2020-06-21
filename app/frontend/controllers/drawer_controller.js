import { Controller } from "stimulus";

export default class extends Controller {

  toggle() {
    const sidebar = document.querySelector('.drawer');
    if (sidebar.dataset.state == "open") {
      sidebar.dataset.state = "closed";
    } else {
      sidebar.dataset.state = "open";
    }
  }
}