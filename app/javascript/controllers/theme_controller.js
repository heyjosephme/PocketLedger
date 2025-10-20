import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="theme"
// NOTE: Dark mode is not currently functional (see Issue #54)
// This controller is kept for future implementation
export default class extends Controller {
  toggle() {
    const html = document.documentElement

    if (html.classList.contains('dark')) {
      html.classList.remove('dark')
      localStorage.theme = 'light'
    } else {
      html.classList.add('dark')
      localStorage.theme = 'dark'
    }
  }
}
