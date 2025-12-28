import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [RouterLink, CommonModule],
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss'],
})
export class HomeComponent {
  // Contact modal visibility
  showContactModal = false;

  /**
   * Open contact modal
   */
  openContactModal(): void {
    this.showContactModal = true;
  }

  /**
   * Close contact modal
   */
  closeContactModal(): void {
    this.showContactModal = false;
  }
}
