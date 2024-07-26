import { Controller } from "@hotwired/stimulus"
import Sortable from 'sortablejs';
import { put } from '@rails/request.js'

export default class extends Controller {
  static values = {
    group: String
  }

  connect() {
    this.sortable = Sortable.create(this.element, {
      group: this.groupValue,
      animation: 150,
      draggable: '.task, .event', // Only tasks and events are draggable
      onEnd: this.onEnd.bind(this)
    })
  }

  onEnd(event) {
    const sortableUpdateUrl = event.item.dataset.sortableUpdateUrl;
    const newListId = event.to.closest('.list-container') ? event.to.closest('.list-container').dataset.sortableUpdateUrl : null;
    const newDate = event.to.dataset.date || null;

    let payload = { row_order_position: event.newIndex };
    if (newListId) {
      payload.list_id = newListId;
    }
    if (newDate) {
      payload.date = newDate;
    }

    put(sortableUpdateUrl, {
      body: JSON.stringify(payload)
    })
  }
}
