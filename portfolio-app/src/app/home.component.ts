import { Component, ElementRef, ViewChild, AfterViewInit, OnDestroy } from '@angular/core';

@Component({
  selector: 'app-home',
  standalone: true,
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements AfterViewInit, OnDestroy {
  // --- Cinematic Project Stack Scroll Animation ---
  projects = [
    { title: 'KSP Mental Performance' },
    { title: 'Continuo' },
    { title: 'Zelda Puzzle' }
  ];

  cardTransforms: string[] = [];
  cardOpacities: number[] = [];

  @ViewChild('projectStack', { static: true }) projectStack!: ElementRef;
  private _observer!: IntersectionObserver;

  private scrollHandler = () => {
    const section = this.projectStack?.nativeElement as HTMLElement;
    if (!section) return;

    const rect = section.getBoundingClientRect();
    const windowH = window.innerHeight || 1;
    // Progress: 0 (section top at bottom of viewport) to 1 (section bottom at top)
    const progress = Math.min(
      1,
      Math.max(
        0,
        (windowH - rect.top) / (rect.height + windowH)
      )
    );

    // Animate each card with stagger
    this.projects.forEach((_, i) => {
      // Each card's "active" window is offset
      const base = i * 0.25;
      const local = Math.min(1, Math.max(0, (progress - base) * 4));
      // Scale: 1 (active) → 0.9 → 0.85 (further back)
      const scale = 1 - 0.1 * local - 0.05 * Math.max(0, local - 0.7) / 0.3;
      // Opacity: 1 → 0.7 → 0.5
      const opacity = 1 - 0.5 * local;
      // Translate: 0 → 40px
      const translate = 40 * local;
      this.cardTransforms[i] = `scale(${scale}) translateY(${translate}px)`;
      this.cardOpacities[i] = Math.max(0.5, Math.min(1, opacity));
    });
  };

  ngAfterViewInit() {
    this.cardTransforms = this.projects.map(() => 'scale(1) translateY(0)');
    this.cardOpacities = this.projects.map(() => 1);

    // IntersectionObserver to enable/disable scroll effect
    this._observer = new IntersectionObserver(
      ([entry]) => {
        if (entry.isIntersecting) {
          window.addEventListener('scroll', this.scrollHandler, { passive: true });
          this.scrollHandler();
        } else {
          window.removeEventListener('scroll', this.scrollHandler);
        }
      },
      { threshold: 0.01 }
    );
    this._observer.observe(this.projectStack.nativeElement);
  }

  ngOnDestroy() {
    window.removeEventListener('scroll', this.scrollHandler);
    if (this._observer) this._observer.disconnect();
  }
}
