import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="timer"
export default class extends Controller {
  static targets = ["time"]
  static values = {
    sound: "String"
  }

  connect() {
    this.oneSecond = 1000;
    this.duration = 60000;
    this.remaining = this.duration;
    this.running = false;
    this.#refreshTime();
    this.audio = new Audio(this.soundValue);
  }

  start() {
    if (this.running) return;

    this.running = true;
    this.audio.play();
    this.interval = window.setInterval(() => {
      if (this.running) {
        this.remaining -= this.oneSecond;
        this.#refreshTime();
        if (this.remaining === 0) {
          this.stop();
          this.audio.currentTime = 0;
          this.audio.play();
        }
      }
    }, this.oneSecond);
  }

  stop() {
    this.running = false;
    window.clearInterval(this.interval);
    this.audio.pause();
    this.audio.currentTime = 0;
  }

  reset() {
    this.stop();
    this.remaining = this.duration;
    this.#refreshTime();
  }

  #refreshTime() {
    const minutes = Math.floor(this.remaining / 60000).toString().padStart(2, "0");
    const seconds = ((this.remaining % 60000) / 1000).toFixed(0).toString().padStart(2, "0");
    this.timeTarget.innerText = `${minutes}:${seconds}`;
  }
}
