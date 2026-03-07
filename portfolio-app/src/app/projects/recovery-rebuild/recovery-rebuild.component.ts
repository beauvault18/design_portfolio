import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';
import { NavbarComponent } from '../../shared/navbar/navbar.component';

@Component({
  selector: 'app-recovery-rebuild',
  standalone: true,
  imports: [RouterLink, CommonModule, NavbarComponent],
  templateUrl: './recovery-rebuild.component.html',
  styleUrls: ['./recovery-rebuild.component.scss'],
})
export class RecoveryRebuildComponent {}
