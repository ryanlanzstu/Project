// app/javascript/controllers/sortable_controller.js
import { Controller } from "stimulus";
import Sortable from 'sortablejs';
import interact from 'interactjs';

export default class extends Controller {
  connect() {
    this.initSortable();
    this.initResizable();
  }

  initSortable() {
    Sortable.create(this.element, {
      onEnd: (event) => {
        let url = this.data.get('url');
        let csrfToken = document.querySelector("[name='csrf-token']").content;

        this.fetchWithTimeout(url, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'X-CSRF-Token': csrfToken
          },
          body: JSON.stringify({
            id: event.item.dataset.id,
            position: event.newIndex
          })
        }, 5000) // 5 seconds timeout
        .then(response => response.json())
        .then(data => {
          console.log('Updated successfully:', data);
        })
        .catch(error => console.error('Error updating:', error));
      }
    });
  }

  initResizable() {
    interact(this.element.querySelectorAll('.resizable')).resizable({
      edges: { left: true, right: true, bottom: true, top: true },
      listeners: {
        move: function (event) {
          let { x, y } = event.target.dataset;
          x = (parseFloat(x) || 0) + event.deltaRect.left;
          y = (parseFloat(y) || 0) + event.deltaRect.top;

          Object.assign(event.target.style, {
            width: event.rect.width + 'px',
            height: event.rect.height + 'px',
            transform: `translate(${x}px, ${y}px)`
          });

          event.target.dataset.x = x;
          event.target.dataset.y = y;
        }
      }
    });
  }

  // Helper function to handle fetch with timeout
  fetchWithTimeout(url, options, timeout = 5000) {
    return Promise.race([
      fetch(url, options),
      new Promise((_, reject) =>
        setTimeout(() => reject(new Error('Timeout')), timeout)
      )
    ]);
  }
}
