import { Controller } from "@hotwired/stimulus"
import confetti from "canvas-confetti"

export default class extends Controller {
  static values = {
    count: Number
  }

  fire() {
    confetti({
      origin: { y: 0.75 },
      particleCount: this.countValue,
      // spread: 80,
      // angle: 90,
      // startVelocity: 30,
      colors: ['262d79']
    });
  }
}
