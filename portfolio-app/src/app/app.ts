import { Component, signal } from '@angular/core';
import { HomeComponent } from './home.component';

@Component({
  selector: 'app-root',
  imports: [HomeComponent],
  standalone: true,
  template: `
    <app-home></app-home>
  `,
  styles: [],
})
export class App {
  protected readonly title = signal('portfolio-app');
}
