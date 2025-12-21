import {
  Component,
  OnInit,
  OnDestroy,
  ChangeDetectorRef
} from '@angular/core';
import { RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';

interface Project {
  title: string;
  year: string;
  role: string;
  tags: string[];
  image?: string;
  route?: string;
}

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [RouterLink, CommonModule],
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss'],
})
export class HomeComponent implements OnInit, OnDestroy {
  // Carousel rotation angle (in degrees)
  rotationAngle = 0;

  // Auto-rotation speed (degrees per frame at 60fps)
  private rotationSpeed = 0.12;

  // Animation frame ID for cleanup
  private animationId: number | null = null;

  // Pause when hovering on a card
  isPaused = false;

  // Contact modal visibility
  showContactModal = false;

  // Angle between each card (360 / 4 = 90 degrees)
  private angleStep = 360 / 4;

  // For front-pause feature
  private lastPausedAt = -1;
  private pauseTimer: ReturnType<typeof setTimeout> | null = null;

  constructor(private cdr: ChangeDetectorRef) {}

  ngOnInit(): void {
    this.startAutoRotation();
  }

  ngOnDestroy(): void {
    this.stopAutoRotation();
    if (this.pauseTimer) {
      clearTimeout(this.pauseTimer);
    }
  }

  private startAutoRotation(): void {
    let isPausedAtFront = false;

    const animate = () => {
      if (!this.isPaused && !isPausedAtFront) {
        this.rotationAngle += this.rotationSpeed;

        // Keep angle within 0-360
        if (this.rotationAngle >= 360) {
          this.rotationAngle -= 360;
        }

        // Check if we hit a card position (0, 90, 180, 270)
        const currentPos = Math.floor(this.rotationAngle / this.angleStep);
        const positionAngle = currentPos * this.angleStep;
        const distanceToPosition = Math.abs(this.rotationAngle - positionAngle);

        // If we just crossed into a new card position
        if (distanceToPosition < 0.5 && currentPos !== this.lastPausedAt) {
          this.rotationAngle = positionAngle; // Snap
          this.lastPausedAt = currentPos;
          isPausedAtFront = true;

          // Resume after 500ms
          this.pauseTimer = setTimeout(() => {
            isPausedAtFront = false;
            this.rotationAngle += 0.5; // Tiny nudge
          }, 500);
        }

        this.cdr.detectChanges();
      }
      this.animationId = requestAnimationFrame(animate);
    };

    this.animationId = requestAnimationFrame(animate);
  }

  private stopAutoRotation(): void {
    if (this.animationId) {
      cancelAnimationFrame(this.animationId);
      this.animationId = null;
    }
  }

  // Called when mouse enters a card
  onCardMouseEnter(): void {
    this.isPaused = true;
  }

  // Called when mouse leaves a card
  onCardMouseLeave(): void {
    this.isPaused = false;
  }

  /**
   * Navigate to next card
   */
  nextCard(): void {
    this.rotationAngle += this.angleStep;
  }

  /**
   * Navigate to previous card
   */
  prevCard(): void {
    this.rotationAngle -= this.angleStep;
  }

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

  /**
   * Get the carousel container style (applies rotation to whole carousel)
   */
  getCarouselStyle(): { [key: string]: string } {
    return {
      'transform': `rotateY(${-this.rotationAngle}deg)`
    };
  }

  /**
   * Calculate styles for each card in the 3D carousel
   */
  getCardStyle(index: number): { [key: string]: string } {
    // Each card is positioned at a fixed angle around the carousel
    const cardAngle = index * this.angleStep;

    // Distance from center (translateZ) - larger = bigger circle
    const radius = 700;

    return {
      'transform': `rotateY(${cardAngle}deg) translateZ(${radius}px)`
    };
  }

  /**
   * Check if this card is currently facing front (active)
   */
  isCardActive(index: number): boolean {
    // Normalize rotation to 0-360
    const normalizedRotation = ((this.rotationAngle % 360) + 360) % 360;

    // Each card occupies 90 degrees of the rotation
    const cardAngle = index * this.angleStep;

    // Card is active when it's facing forward (within 45 degrees of front)
    const diff = Math.abs(normalizedRotation - cardAngle);
    const minDiff = Math.min(diff, 360 - diff);

    return minDiff < 45;
  }

  // Projects data
  projects: Project[] = [
    {
      title: 'KSP Mental Performance',
      year: '2024',
      role: 'Lead Designer',
      tags: ['Mobile App', 'UX/UI', 'Mental Health'],
      image: 'assets/projects/ksp/ksp-hero.png',
      route: '/projects/ksp-mental-performance'
    },
    {
      title: 'Continuo iPad App',
      year: '2024',
      role: 'Lead Product Designer · Flutter Developer',
      tags: ['Healthcare AI', 'iPad App', 'UX/UI', 'EdTech'],
      image: 'assets/projects/continuo/continuo-main-menu.png',
      route: '/projects/continuo'
    },
    {
      title: 'Zelda Puzzle',
      year: '2024',
      role: 'Designer · Front-End Developer',
      tags: ['Interaction Design', 'Creative UX', 'Web'],
      image: 'assets/projects/intor_test/triforce-ocarina.png',
      route: '/projects/zelda-puzzle'
    },
    {
      title: 'AI Fall Detection System',
      year: '2024',
      role: 'Full-Stack Developer · ML Engineer',
      tags: ['AI/ML', 'Healthcare', 'Computer Vision', 'React'],
      image: 'assets/fall-detection/fall-detection-hero.png',
      route: '/projects/fall-detection'
    }
  ];
}
