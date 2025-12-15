import { ApplicationConfig, provideBrowserGlobalErrorListeners } from '@angular/core';
import { provideRouter } from '@angular/router';

import { HomeComponent } from './home.component';
import { AboutComponent } from './about.component';

const routes = [
  { path: '', component: HomeComponent },
  { path: 'about', component: AboutComponent },
];

export const appConfig: ApplicationConfig = {
  providers: [
    provideBrowserGlobalErrorListeners(),
    provideRouter(routes),
  ],
};
