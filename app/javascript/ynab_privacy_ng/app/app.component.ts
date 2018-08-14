import { Component } from '@angular/core';
import templateString from './hello_world.component.html'

@Component({
  selector: 'ynab-privacy-ng',
  template: templateString
})
export class AppComponent {
  name = 'baz!';
}
