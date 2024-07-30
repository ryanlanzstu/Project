// app/javascript/controllers/sortable_controller.js
import { Controller } from "stimulus";
import Sortable from 'sortablejs';

export default class extends Controller {
  connect() {
    this.initSortable();
  }

  initSortable() {
    new Sortable(this.element, {
      group: this.data.get("group"),
      animation: 150,
      onEnd: (event) => {
        let url = this.data.get("sortable-url");
        let csrfToken = document.querySelector("[name='csrf-token']").content;

        fetch(url, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': csrfToken
          },
          body: JSON.stringify({
            id: event.item.dataset.id,
            position: event.newIndex
          })
        })
        .then(response => response.json())
        .then(data => {
          console.log('Updated successfully:', data);
        })
        .catch(error => console.error('Error updating:', error));
      }
    });
  }
}
