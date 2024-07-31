// app/javascript/controllers/sortable_controller.js
import { Controller } from "stimulus";
import Sortable from "sortablejs";

export default class extends Controller {
  connect() {
    this.initSortable();
  }

  initSortable() {
    new Sortable(this.element, {
      group: {
        name: this.element.dataset.group || 'default',
        pull: true,
        put: function (to) {
          return to.el.closest('.tasks') !== null;
        }
      },
      animation: 150,
      onEnd: (event) => {
        let url = this.element.dataset.sortableUrl;
        let csrfToken = document.querySelector("[name='csrf-token']").content;

        if (event.to.dataset.listId || event.to.dataset.date) {
          fetch(url, {
            method: 'PATCH',
            headers: {
              'Content-Type': 'application/json',
              'X-CSRF-Token': csrfToken
            },
            body: JSON.stringify({
              id: event.item.dataset.id,
              position: event.newIndex,
              list_id: event.to.dataset.listId,
              date: event.to.dataset.date
            })
          })
          .then(response => response.json())
          .then(data => {
            console.log('Updated successfully:', data);
          })
          .catch(error => console.error('Error updating:', error));
        }
      }
    });
  }
}
