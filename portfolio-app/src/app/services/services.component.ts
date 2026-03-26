import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { NavbarComponent } from '../shared/navbar/navbar.component';

interface ServicePackage {
  title: string;
  description: string;
  deliverables: string[];
  turnaround: string;
  startingAt: string;
}

@Component({
  selector: 'app-services',
  standalone: true,
  imports: [CommonModule, NavbarComponent],
  templateUrl: './services.component.html',
  styleUrls: ['./services.component.scss'],
})
export class ServicesComponent {
  showContactModal = false;

  services: ServicePackage[] = [
    {
      title: 'Landing Page',
      description: 'High converting landing page designed and built in code. Fully responsive, optimized for speed, and ready to deploy.',
      deliverables: [
        'Custom design',
        'Responsive HTML/CSS/JS',
        'Mobile optimized',
        'SEO ready',
        'Deployed and live',
      ],
      turnaround: '48 hours',
      startingAt: '$1,500',
    },
    {
      title: 'Full Website',
      description: 'Multi page website with custom design system, animations, and production code. Built in Angular, React, or Next.js.',
      deliverables: [
        'Up to 5 pages',
        'Custom design system',
        'Responsive across all devices',
        'Motion and micro interactions',
        'CMS integration available',
      ],
      turnaround: '1 to 2 weeks',
      startingAt: '$4,000',
    },
    {
      title: 'Pitch Deck',
      description: 'Investor ready presentation with compelling visual storytelling, data visualization, and brand aligned design.',
      deliverables: [
        'Up to 20 slides',
        'Custom visual design',
        'Data visualizations',
        'Editable source file',
        'PDF export',
      ],
      turnaround: '3 to 5 days',
      startingAt: '$1,200',
    },
    {
      title: 'Design System',
      description: 'Complete design system with typography, color tokens, spacing, components, and documentation. Built for scale.',
      deliverables: [
        'Typography scale',
        'Color and spacing tokens',
        'Component library',
        'Usage documentation',
        'Developer handoff ready',
      ],
      turnaround: '1 to 2 weeks',
      startingAt: '$3,000',
    },
  ];

  openContactModal(): void {
    this.showContactModal = true;
  }

  closeContactModal(): void {
    this.showContactModal = false;
  }
}
