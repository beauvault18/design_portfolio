import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-about-me',
  standalone: true,
  imports: [RouterLink],
    templateUrl: './about-me.component.html',
    styleUrls: ['./about-me.component.scss', '../home.component.scss'],
})
export class AboutMe {}
