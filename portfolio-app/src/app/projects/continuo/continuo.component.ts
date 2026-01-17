import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';
import { NavbarComponent } from '../../shared/navbar/navbar.component';

@Component({
  selector: 'app-continuo',
  standalone: true,
  imports: [RouterLink, CommonModule, NavbarComponent],
  templateUrl: './continuo.component.html',
  styleUrls: ['./continuo.component.scss'],
})
export class ContinuoComponent {}
