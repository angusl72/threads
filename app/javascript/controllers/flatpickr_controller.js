// import { Controller } from "@hotwired/stimulus"
// import flatpickr from "flatpickr";

// // Connects to data-controller="flatpickr"
// export default class extends Controller {
//   // Inform the controller that it has two targets in the form, which are our inputs
//   static targets = [ "startTime", "endTime" ]

//   connect() {
//     flatpickr(this.startTimeTarget, {
//       altInput: true,
//       enableTime: false
//     })
//     flatpickr(this.endTimeTarget, {
//       altInput: true,
//       enableTime: false
//     })
//   }
// }

import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
// Import the rangePlugin from the flatpickr library
import rangePlugin from "flatpickr/dist/plugins/rangePlugin";

// Connects to data-controller="flatpickr"
export default class extends Controller {
  static targets = [ "startTime", "endTime" ]
  connect() {
    flatpickr(this.startTimeTarget, {
              enableTime: false,
              // Provide an id for the plugin to work
              plugins: [new rangePlugin({ input: "#end_time"})]})
    flatpickr(this.endTimeTarget, {})
  }
}
