import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="ajax"
export default class extends Controller {

  static targets = ["habits", "calendar"]

  connect() {
    console.log("ajax");
    console.log(this.calendarTarget);
    console.log(this.habitsTarget);
  }

  done(event) {
    event.preventDefault();

    event.currentTarget.classList.add("habit-done");
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
        console.log(data);
        this.calendarTarget.outerHTML = data.calendar;
      })
  }
}
