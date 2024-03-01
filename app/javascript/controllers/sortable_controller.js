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
    console.log(event.item.dataset.sortableId)
    console.log(event.newIndex)
    //Request from requestjs
    put(`/lists/${event.item.dataset.sortableId}/sort`);//Get URL, add params
    body: JSON.stringify({row_order_position: event.newIndex})
  }
}

