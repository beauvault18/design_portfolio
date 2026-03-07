import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';
import { NavbarComponent } from '../../shared/navbar/navbar.component';

@Component({
  selector: 'app-lock-it-in',
  standalone: true,
  imports: [RouterLink, CommonModule, NavbarComponent],
  templateUrl: './lock-it-in.component.html',
  styleUrls: ['./lock-it-in.component.scss'],
})
export class LockItInComponent {}
