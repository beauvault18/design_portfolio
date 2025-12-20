import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-fall-detection',
  standalone: true,
  imports: [RouterLink, CommonModule],
  templateUrl: './fall-detection.component.html',
  styleUrls: ['./fall-detection.component.scss'],
})
export class FallDetectionComponent {
  lightboxImage: string | null = null;

  openLightbox(imageSrc: string): void {
    this.lightboxImage = imageSrc;
    document.body.style.overflow = 'hidden';
  }

  closeLightbox(): void {
    this.lightboxImage = null;
    document.body.style.overflow = '';
  }
}
