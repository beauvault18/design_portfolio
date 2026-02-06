import { ApplicationConfig, provideBrowserGlobalErrorListeners } from '@angular/core';
import { provideRouter } from '@angular/router';

import { HomeComponent } from './home.component';
import { AboutComponent } from './about.component';

const routes = [
  { path: '', component: HomeComponent },
  { path: 'about', component: AboutComponent },
  {
    path: 'ui-design',
    loadComponent: () => import('./ui-design/ui-design.component').then(m => m.UiDesignComponent)
  },
  {
    path: 'animation',
    loadComponent: () => import('./animation/animation.component').then(m => m.AnimationComponent)
  },
  {
    path: 'product-design',
    loadComponent: () => import('./product-design/product-design.component').then(m => m.ProductDesignComponent)
  },
  {
    path: 'recent-projects',
    loadComponent: () => import('./recent-projects/recent-projects.component').then(m => m.RecentProjectsComponent)
  },
  {
    path: 'projects/ksp-mental-performance',
    loadComponent: () => import('./projects/ksp-mental-performance/ksp-mental-performance.component').then(m => m.KspMentalPerformanceComponent)
  },
  {
    path: 'projects/continuo',
    loadComponent: () => import('./projects/continuo/continuo.component').then(m => m.ContinuoComponent)
  },
  {
    path: 'projects/zelda-puzzle',
    loadComponent: () => import('./projects/zelda-puzzle/zelda-puzzle.component').then(m => m.ZeldaPuzzleComponent)
  },
  {
    path: 'projects/fall-detection',
    loadComponent: () => import('./projects/fall-detection/fall-detection.component').then(m => m.FallDetectionComponent)
  },
];

export const appConfig: ApplicationConfig = {
  providers: [
    provideBrowserGlobalErrorListeners(),
    provideRouter(routes),
  ],
};
