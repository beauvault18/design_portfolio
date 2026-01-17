import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';
import { NavbarComponent } from '../../shared/navbar/navbar.component';

@Component({
  selector: 'app-zelda-puzzle',
  standalone: true,
  imports: [RouterLink, CommonModule, NavbarComponent],
  templateUrl: './zelda-puzzle.component.html',
  styleUrls: ['./zelda-puzzle.component.scss'],
})
export class ZeldaPuzzleComponent {}
