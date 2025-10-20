import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="theme"
export default class extends Controller {
  toggle() {
    const html = document.documentElement

    if (html.classList.contains('dark')) {
      // Switch to light mode
      html.classList.remove('dark')
      localStorage.theme = 'light'
    } else {
      // Switch to dark mode
      html.classList.add('dark')
      localStorage.theme = 'dark'
    }
  }
}
