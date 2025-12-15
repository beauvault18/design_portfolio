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
      <nav class="main-navbar">
        <div class="navbar-logo" routerLink="/" style="cursor:pointer;">BW</div>
        <ul class="navbar-links">
          <li>UI/Design</li>
          <li>Projects</li>
          <li>Animation</li>
          <li>Puzzle</li>
          <li routerLink="/about" style="cursor:pointer;">About</li>
          <li>Contact</li>
          <li>Get CV</li>
        </ul>
      </nav>
      <router-outlet></router-outlet>
    </div>
  `,
  styles: [],
})
export class App {
  protected readonly title = signal('portfolio-app');
}
