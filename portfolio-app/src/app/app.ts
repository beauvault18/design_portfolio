import { Component, signal } from '@angular/core';
import { RouterOutlet, RouterLink } from '@angular/router';
import { HomeComponent } from './home.component';
import { AboutMe } from './about-me/about-me';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, RouterLink, HomeComponent, AboutMe],
  template: `
    <div class="app-root">
      <router-outlet></router-outlet>
    </div>
  `,
  styles: [],
})
export class App {
  protected readonly title = signal('portfolio-app');
}
