import { ApplicationConfig, provideBrowserGlobalErrorListeners } from '@angular/core';
import { provideRouter } from '@angular/router';

import { HomeComponent } from './home.component';
import { AboutComponent } from './about.component';
import { KspMentalPerformanceComponent } from './projects/ksp-mental-performance/ksp-mental-performance.component';
import { ContinuoComponent } from './projects/continuo/continuo.component';
import { ZeldaPuzzleComponent } from './projects/zelda-puzzle/zelda-puzzle.component';
import { UiDesignComponent } from './ui-design/ui-design.component';

const routes = [
  { path: '', component: HomeComponent },
  { path: 'about', component: AboutComponent },
  { path: 'ui-design', component: UiDesignComponent },
  { path: 'projects/ksp-mental-performance', component: KspMentalPerformanceComponent },
  { path: 'projects/continuo', component: ContinuoComponent },
  { path: 'projects/zelda-puzzle', component: ZeldaPuzzleComponent },
];

export const appConfig: ApplicationConfig = {
  providers: [
    provideBrowserGlobalErrorListeners(),
    provideRouter(routes),
  ],
};
