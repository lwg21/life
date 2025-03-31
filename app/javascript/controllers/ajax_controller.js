import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ajax"
export default class extends Controller {

  static targets = ["habits", "calendar"]

  done(event) {
    event.preventDefault();

    const card = event.currentTarget.closest(".habit-card");

    // Optimistic UI
    event.currentTarget.classList.add("done");

    const url = event.currentTarget.href;
    const token = document.head.querySelector("meta[name=csrf-token]")?.content;

    const options = {
      method: "POST",
      headers: {
        "Accept": "application/json",
        "X-CSRF-Token": token
      }
    }

    fetch(url, options)
      .then(response => response.json())
      .then(data => {
        this.calendarTarget.outerHTML = data.calendar;
        card.outerHTML = data.habit;
      })
  }
}
