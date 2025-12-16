import { Component, HostListener, ElementRef, ViewChildren, QueryList, AfterViewInit, OnDestroy } from '@angular/core';
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
export class HomeComponent implements AfterViewInit, OnDestroy {
  @ViewChildren('projectCard') projectCards!: QueryList<ElementRef>;

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
    }
  ];

  private ticking = false;
  private virtualScrollProgress = 0; // Track internal scroll progress (0-1)
  private isLocked = false; // Is section currently locked?

  ngAfterViewInit(): void {
    this.updateCardTransforms();
    // Add wheel event listener for scroll locking
    window.addEventListener('wheel', this.onWheel.bind(this), { passive: false });
  }

  ngOnDestroy(): void {
    window.removeEventListener('wheel', this.onWheel.bind(this));
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

  private onWheel(event: WheelEvent): void {
    const stackSection = document.querySelector('.project-stack-section') as HTMLElement;
    if (!stackSection) return;

    const rect = stackSection.getBoundingClientRect();

    // Check if section is at the top of viewport (locked position)
    const isAtTop = rect.top <= 0 && rect.bottom > window.innerHeight;

    if (isAtTop) {
      // We're in the locked zone - handle virtual scrolling
      event.preventDefault();

      const delta = event.deltaY > 0 ? 0.02 : -0.02; // Scroll increment
      this.virtualScrollProgress = Math.max(0, Math.min(1, this.virtualScrollProgress + delta));

      // If we've scrolled through all cards (progress = 1) and scrolling down, unlock
      if (this.virtualScrollProgress >= 1 && event.deltaY > 0) {
        this.isLocked = false;
        // Scroll to footer
        const footer = document.querySelector('.page-footer') as HTMLElement;
        if (footer) {
          window.scrollTo({ top: footer.offsetTop, behavior: 'smooth' });
        }
      }
      // If at start and scrolling up, unlock upward
      else if (this.virtualScrollProgress <= 0 && event.deltaY < 0) {
        this.isLocked = false;
        // Allow normal scroll up
        return;
      } else {
        this.isLocked = true;
        this.updateCardTransforms();
      }
    } else if (rect.top > 0) {
      // Section hasn't reached top yet - reset progress
      this.virtualScrollProgress = 0;
      this.isLocked = false;
    }
  }

  private updateCardTransforms(): void {
    const cards = this.projectCards?.toArray();
    if (!cards || cards.length === 0) return;

    const stackSection = document.querySelector('.project-stack-section') as HTMLElement;
    if (!stackSection) return;

    const rect = stackSection.getBoundingClientRect();

    // Use virtual scroll progress if locked, otherwise use actual scroll position
    let scrollProgress: number;

    if (this.isLocked) {
      // Use the virtual scroll progress controlled by wheel events
      scrollProgress = this.virtualScrollProgress;
    } else {
      // Calculate based on actual scroll position
      const sectionHeight = stackSection.offsetHeight;
      const windowHeight = window.innerHeight;

      // Start transitions when section reaches top of viewport
      const scrolled = Math.max(0, -rect.top);
      const totalScrollDistance = sectionHeight - windowHeight;

      // Calculate overall scroll progress (0-1)
      scrollProgress = Math.max(0, Math.min(1, scrolled / totalScrollDistance));
    }

    cards.forEach((cardRef, index) => {
      const card = cardRef.nativeElement as HTMLElement;

      // ============================================================
      // SCROLL PROGRESS CALCULATION
      // Each card gets its own scroll window
      // Card transitions happen sequentially with overlap
      // ============================================================

      // Each card occupies 33% of total scroll (0.33)
      // This means all 3 cards fit perfectly in the scroll distance
      // Small overlap for smooth transitions
      const scrollWindowSize = 0.35;
      const scrollOverlap = 0.05;
      const cardStart = index * (scrollWindowSize - scrollOverlap);
      const cardEnd = cardStart + scrollWindowSize;

      // Normalize scroll progress for this specific card (0 = entering, 1 = exited)
      let cardProgress = 0;

      // FIRST CARD SPECIAL CASE: Should be fully visible at start
      if (index === 0 && scrollProgress <= cardStart) {
        cardProgress = 0.45; // Put it in the "hold" phase (between 0.25 and 0.65)
      } else if (scrollProgress < cardStart) {
        // Card hasn't entered yet - keep it visible but positioned below
        // Set to early entering state (slightly before phase 1 starts)
        cardProgress = -0.1; // Negative value to indicate "waiting" state
      } else if (scrollProgress >= cardStart && scrollProgress <= cardEnd) {
        // Card is in its active scroll window
        cardProgress = (scrollProgress - cardStart) / scrollWindowSize;
      } else {
        // Card has exited
        cardProgress = 1;
      }

      // ============================================================
      // ANIMATION PHASES (High-End Portfolio Style)
      // Phase 1 (0.0 - 0.25): Enter from below
      // Phase 2 (0.25 - 0.65): Hold active (centered, scale 1, sharp)
      // Phase 3 (0.65 - 1.0): Exit (scale down, blur, fade)
      // ============================================================

      let finalY = 0;           // Vertical position offset
      let finalScale = 1;       // Scale transform
      let finalOpacity = 1;     // Opacity
      let finalBlur = 0;        // Blur filter (px)
      let finalBrightness = 1;  // Brightness filter

      // WAITING STATE (cardProgress < 0)
      // Card is waiting below, visible but not yet entering
      if (cardProgress < 0) {
        finalY = 180;              // Positioned below viewport
        finalScale = 1.0;          // Normal scale
        finalOpacity = 0.4;        // Partially visible so user can see it waiting
        finalBlur = 8;             // More blurred to distinguish from active
        finalBrightness = 0.7;     // Dimmed
      }

      // PHASE 1: ENTERING (0.0 - 0.25)
      // Next card slides up from below with slight scale-up
      else if (cardProgress < 0.25) {
        const phaseProgress = cardProgress / 0.25; // Normalize to 0-1

        // Smooth easing function (ease-out cubic)
        const eased = 1 - Math.pow(1 - phaseProgress, 3);

        // Smoothly transition from waiting state to centered active state
        finalY = (1 - eased) * 180;           // Slide from +180px to 0
        finalScale = 1.0;                     // Keep consistent scale
        finalOpacity = 0.4 + (eased * 0.6);   // Fade from 0.4 to 1.0
        finalBlur = (1 - eased) * 8;          // Blur from 8px to 0
        finalBrightness = 0.7 + (eased * 0.3); // Brighten from 0.7 to 1.0
      }

      // PHASE 2: ACTIVE/HOLD (0.25 - 0.65)
      // Card is fully visible, centered, sharp - the dominant card
      else if (cardProgress >= 0.25 && cardProgress < 0.65) {
        finalY = 0;
        finalScale = 1.0;
        finalOpacity = 1;
        finalBlur = 0;
        finalBrightness = 1;
      }

      // PHASE 3: EXITING (0.65 - 1.0)
      // Current card scales down, blurs, and fades as next card takes over
      else {
        const phaseProgress = (cardProgress - 0.65) / 0.35; // Normalize to 0-1

        // Smooth easing function (ease-in cubic)
        const eased = Math.pow(phaseProgress, 3);

        finalY = eased * -40;                     // Slight upward drift
        finalScale = 1.0 - (eased * 0.15);        // Scale from 1.0 to 0.85
        finalOpacity = 1 - (eased * 0.6);         // Fade from 1 to 0.4
        finalBlur = eased * 6;                    // Blur from 0 to 6px
        finalBrightness = 1 - (eased * 0.2);      // Dim from 1.0 to 0.8
      }

      // ============================================================
      // Z-INDEX STACKING
      // Active card (closest to center of its window) gets highest z-index
      // This ensures proper overlap during transitions
      // ============================================================
      const cardMidpoint = cardStart + (scrollWindowSize / 2);
      const distanceFromActive = Math.abs(scrollProgress - cardMidpoint);
      const zIndex = Math.round((1 - Math.min(distanceFromActive, 1)) * 100);

      card.style.zIndex = `${zIndex}`;

      // ============================================================
      // APPLY TRANSFORMS
      // Use only transform and opacity for 60fps performance
      // Combine all transforms into single property to avoid reflows
      // ============================================================

      const transform = `translate(-50%, calc(-50% + ${finalY}px)) scale(${finalScale})`;
      const filter = `blur(${finalBlur}px) brightness(${finalBrightness})`;

      card.style.transform = transform;
      card.style.filter = filter;
      card.style.opacity = `${finalOpacity}`;

      // Ensure smooth sub-pixel rendering
      card.style.willChange = 'transform, opacity, filter';
    });
  }
}
