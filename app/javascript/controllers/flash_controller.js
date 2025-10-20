import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flash"
export default class extends Controller {
  static values = {
    duration: { type: Number, default: 5000 }
  }

  connect() {
    // Auto-dismiss after duration
    this.timeout = setTimeout(() => {
      this.close()
    }, this.durationValue)
  }

  disconnect() {
    // Clear timeout if element is removed before auto-dismiss
    if (this.timeout) {
      clearTimeout(this.timeout)
    }
  }

  close() {
    // Fade out animation
    this.element.style.transition = "opacity 300ms ease-out, transform 300ms ease-out"
    this.element.style.opacity = "0"
    this.element.style.transform = "translateX(100%)"

    // Remove from DOM after animation
    setTimeout(() => {
      this.element.remove()
    }, 300)
  }
}
