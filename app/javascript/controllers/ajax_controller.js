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

  reset() {
    event.preventDefault();

    const url = event.currentTarget.href;
    const token = document.head.querySelector("meta[name=csrf-token]")?.content;

    console.log(url);


    const options = {
      method: "DELETE",
      headers: {
        // "Accept": "application/json",
        "X-CSRF-Token": token
      }
    }

    fetch(url, options)
      .then(response => response.text())
      .then(data => {
        const parser = new DOMParser();
        const doc = parser.parseFromString(data, "text/html");

        const calendar = doc.querySelector(".calendar");
        document.querySelector(".calendar").innerHTML = calendar.innerHTML;

        const habits = doc.querySelector(".habits");
        document.querySelector(".habits").innerHTML = habits.innerHTML;
      })
  }
}
