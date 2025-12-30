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
  mainImage = 'assets/about/IMG_5786.JPG';
  carouselImages = [
    'assets/about/IMG_5776.jpg',
    'assets/about/IMG_5779.jpg',
    'assets/about/IMG_5782.JPG',
    'assets/about/IMG_5783.JPG',
    'assets/about/IMG_5784.JPG',
    'assets/about/IMG_5785.JPG',
    'assets/about/IMG_5786.JPG',
    'assets/about/IMG_6016.jpg',
    'assets/about/IMG_6017.jpg',
    'assets/about/IMG_6018.jpg',
    'assets/about/IMG_6019.jpg',
    'assets/about/IMG_6020.jpg'
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
