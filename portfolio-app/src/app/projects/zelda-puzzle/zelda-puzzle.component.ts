import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-zelda-puzzle',
  standalone: true,
  imports: [RouterLink, CommonModule],
  templateUrl: './zelda-puzzle.component.html',
  styleUrls: ['./zelda-puzzle.component.scss'],
})
export class ZeldaPuzzleComponent {}
