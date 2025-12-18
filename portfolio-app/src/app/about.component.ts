import { Component } from '@angular/core';
import { JsonPipe, CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-about',
  standalone: true,
  imports: [CommonModule, JsonPipe, RouterLink],
  templateUrl: './about.component.html',
  styleUrls: ['./about.component.scss']
})
export class AboutComponent {
  mainImage = 'assets/IMG_5786.JPG';
  carouselImages = [
    'assets/IMG_5776.jpg',
    'assets/IMG_5779.jpg',
    'assets/IMG_5782.JPG',
    'assets/IMG_5783.JPG',
    'assets/IMG_5784.JPG',
    'assets/IMG_5785.JPG',
    'assets/IMG_5786.JPG'
  ];
  visibleCount = 5; // Number of thumbnails visible at once
  startIndex = 0;

  get visibleImages() {
    return this.carouselImages.slice(this.startIndex, this.startIndex + this.visibleCount);
  }

  nextImages() {
    if (this.startIndex + this.visibleCount < this.carouselImages.length) {
      this.startIndex++;
    }
  }

  prevImages() {
    if (this.startIndex > 0) {
      this.startIndex--;
    }
  }
}
