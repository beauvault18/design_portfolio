import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';
import { NavbarComponent } from '../../shared/navbar/navbar.component';

@Component({
  selector: 'app-rebuilt-to-inspire',
  standalone: true,
  imports: [RouterLink, CommonModule, NavbarComponent],
  templateUrl: './rebuilt-to-inspire.component.html',
  styleUrls: ['./rebuilt-to-inspire.component.scss'],
})
export class RebuiltToInspireComponent {}
