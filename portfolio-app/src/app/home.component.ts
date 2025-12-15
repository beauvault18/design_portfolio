import { Component, HostListener, ElementRef, ViewChildren, QueryList, AfterViewInit } from '@angular/core';
import { RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';

interface Project {
  title: string;
  year: string;
  role: string;
  tags: string[];
  image?: string;
}

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [RouterLink, CommonModule],
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss'],
})
export class HomeComponent implements AfterViewInit {
  @ViewChildren('projectCard') projectCards!: QueryList<ElementRef>;

  projects: Project[] = [
    {
      title: 'KSP Mental Performance',
      year: '2024',
      role: 'Lead Designer',
      tags: ['Mobile App', 'UX/UI', 'Mental Health'],
      image: ''
    },
    {
      title: 'Continou',
      year: '2025',
      role: 'Product Designer',
      tags: ['Web App', 'SaaS', 'Productivity'],
      image: ''
    },
    {
      title: "Zelda's Puzzle",
      year: '2024',
      role: 'UI Designer',
      tags: ['Game Design', 'Interactive', 'Puzzle'],
      image: ''
    }
  ];

  private ticking = false;

  ngAfterViewInit(): void {
    this.updateCardTransforms();
  }

  @HostListener('window:scroll', [])
  onWindowScroll(): void {
    if (!this.ticking) {
      requestAnimationFrame(() => {
        this.updateCardTransforms();
        this.ticking = false;
      });
      this.ticking = true;
    }
  }

  // Spring-like easing function (similar to Framer's spring animation)
  private applySpringEasing(t: number): number {
    const damping = 0.7;
    const stiffness = 0.2;
    return t * (2 - t * damping) * stiffness + t * (1 - stiffness);
  }

  private updateCardTransforms(): void {
    const cards = this.projectCards?.toArray();
    if (!cards || cards.length === 0) return;

    const stackSection = document.querySelector('.project-stack-section') as HTMLElement;
    if (!stackSection) return;

    const rect = stackSection.getBoundingClientRect();
    const sectionHeight = stackSection.offsetHeight;
    const windowHeight = window.innerHeight;

    // More sensitive scroll tracking - start animating earlier
    const scrolled = (windowHeight * 0.5) - rect.top;
    const totalScrollDistance = sectionHeight - (windowHeight * 0.5);

    // Calculate scroll progress
    const scrollProgress = Math.max(0, Math.min(1, scrolled / totalScrollDistance));

    const cardCount = cards.length;

    cards.forEach((cardRef, index) => {
      const card = cardRef.nativeElement as HTMLElement;

      // Calculate how far this card has scrolled with increased multiplier
      const cardProgress = scrollProgress * cardCount * 2;

      // Add delay for first and second cards - they need more scroll before animating
      let relativeProgress;
      if (index === 0) {
        // First card: Add a 0.6 threshold delay (60% more scroll needed before it starts moving)
        relativeProgress = Math.max(0, Math.min(1, (cardProgress - 0.6) / (1 - 0.6)));
      } else if (index === 1) {
        // Second card: Add a 0.4 threshold delay (40% more scroll for extended viewing)
        relativeProgress = Math.max(0, Math.min(1, (cardProgress - index - 0.4) / (1 - 0.4)));
      } else {
        // Third card and beyond: Normal animation
        relativeProgress = Math.max(0, Math.min(1, cardProgress - index));
      }

      // Apply spring-like easing
      const easedProgress = this.applySpringEasing(relativeProgress);

      // FRAMER-STYLE TRANSFORMS
      const scale = 1 - (easedProgress * 0.3); // Shrinks to 70%
      const translateY = easedProgress * -300; // Moves up 300px
      const translateZ = easedProgress * -400; // Depth effect
      const rotateX = easedProgress * -10; // Slight rotation
      const opacity = 1 - (easedProgress * 0.75); // Fades to 25%

      // All cards get z-index based on their position (first card on top)
      card.style.zIndex = `${cardCount - index}`;

      if (index < cardCount - 1) {
        card.style.transform = `perspective(1200px) translateY(${translateY}px) translateZ(${translateZ}px) rotateX(${rotateX}deg) scale(${scale})`;
        card.style.opacity = `${Math.max(0.25, opacity)}`;
      } else {
        // Last card stays in place
        card.style.transform = 'perspective(1200px) translateY(0) translateZ(0) rotateX(0) scale(1)';
        card.style.opacity = '1';
      }
    });
  }
}
