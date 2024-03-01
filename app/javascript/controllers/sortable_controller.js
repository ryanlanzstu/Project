import { Controller } from "@hotwired/stimulus"
import Sortable from 'sortablejs';
import { put } from '@rails/request.js'

// Connects to data-controller="sortable"
export default class extends Controller {
  connect() {
    Sortable.create(this.element, {
      onEnd: this.onEnd.bind(this) //Logs position of the list
    }) 
  }

  onEnd(event) {
    var sortableUpdateUrl = event.item.dataset.sortableUpdateUrl
    console.log(event.item.dataset.sortableUpdateUrl)
    console.log(event.newIndex)
    //Request from requestjs
    put(event.item.dataset.sortableUpdateUrl, {
      body: JSON.stringify({
        row_order_position: event.newIndex,
        // Get URL, taking params
        contentType: "application/json",
        // Sorted correctly finally, list sequence was 1-3-2 but this fixes it
        headers: {
          "X-CSRF-Token": document.querySelector("[name=csrf-token]").content
        }
      })
    });
}
}
