import { Component, AfterViewInit, ElementRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NavbarComponent } from '../shared/navbar/navbar.component';

interface ServicePackage {
  title: string;
  description: string;
  deliverables: string[];
  turnaround: string;
  startingAt: string;
  icon: string;
}

interface StatItem {
  value: string;
  label: string;
}

@Component({
  selector: 'app-services',
  standalone: true,
  imports: [CommonModule, NavbarComponent],
  templateUrl: './services.component.html',
  styleUrls: ['./services.component.scss'],
})
export class ServicesComponent implements AfterViewInit {
  showContactModal = false;

  stats: StatItem[] = [
    { value: '10+', label: 'Years Experience' },
    { value: '48hr', label: 'Fastest Delivery' },
    { value: '100%', label: 'Custom Code' },
    { value: '0', label: 'Templates Used' },
  ];

  services: ServicePackage[] = [
    {
      title: 'Landing Page',
      description: 'Designed and built in code. Responsive, fast, and ready to convert.',
      icon: '01',
      deliverables: [
        'Custom design',
        'Responsive HTML/CSS/JS',
        'Mobile optimized',
        'SEO ready',
        'Deployed and live',
      ],
      turnaround: '48 hours',
      startingAt: '$500',
    },
    {
      title: 'Full Website',
      description: 'Multi page site with design system, animations, and production code.',
      icon: '02',
      deliverables: [
        'Up to 5 pages',
        'Custom design system',
        'Responsive across all devices',
        'Motion and micro interactions',
        'CMS integration available',
      ],
      turnaround: '1 to 2 weeks',
      startingAt: '$1,500',
    },
    {
      title: 'Pitch Deck',
      description: 'Investor ready presentation with visual storytelling and data design.',
      icon: '03',
      deliverables: [
        'Up to 20 slides',
        'Custom visual design',
        'Data visualizations',
        'Editable source file',
        'PDF export',
      ],
      turnaround: '3 to 5 days',
      startingAt: '$400',
    },
    {
      title: 'Design System',
      description: 'Typography, tokens, components, and documentation. Built for scale.',
      icon: '04',
      deliverables: [
        'Typography scale',
        'Color and spacing tokens',
        'Component library',
        'Usage documentation',
        'Developer handoff ready',
      ],
      turnaround: '1 to 2 weeks',
      startingAt: '$1,500',
    },
  ];

  tools: string[] = [
    'Angular', 'React', 'Next.js', 'Flutter', 'TypeScript',
    'HTML/CSS', 'Python', 'After Effects', 'Blender', 'Adobe Suite'
  ];

  constructor(private el: ElementRef) {}

  ngAfterViewInit(): void {
    const observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add('visible');
          }
        });
      },
      { threshold: 0.1 }
    );

    const elements = this.el.nativeElement.querySelectorAll('.animate-in');
    elements.forEach((el: Element) => observer.observe(el));
  }

  openContactModal(): void {
    this.showContactModal = true;
  }

  closeContactModal(): void {
    this.showContactModal = false;
  }
}
