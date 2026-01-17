import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';
import { NavbarComponent } from '../../shared/navbar/navbar.component';

@Component({
  selector: 'app-ksp-mental-performance',
  standalone: true,
  imports: [RouterLink, CommonModule, NavbarComponent],
  templateUrl: './ksp-mental-performance.component.html',
  styleUrls: ['./ksp-mental-performance.component.scss'],
})
export class KspMentalPerformanceComponent {}
