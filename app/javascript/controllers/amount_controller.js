import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    
  }

  change(e) {
    const qty = document.getElementById('qty')
    const amount = document.getElementById('amount')
    const price = document.getElementById('price')
    
    qty.value = parseFloat(amount.value / price.innerHTML).toFixed(0)
  }
}
