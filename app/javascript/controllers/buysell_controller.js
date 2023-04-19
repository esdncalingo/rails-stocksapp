import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    
  }

  change(e) {
    const qty = document.getElementById('qty')
    const amount = document.getElementById('amount')
    const price = document.getElementById('price')
    
    val = parseFloat(amount.value / price.innerHTML).toFixed(0)
  }

  qtychange(e) {
    const qty = document.getElementById('qty')
    const amount = document.getElementById('amount')
    const price = document.getElementById('price')
    
    amount.value = parseFloat(price.innerHTML * qty.value).toFixed(2)
  }
}
