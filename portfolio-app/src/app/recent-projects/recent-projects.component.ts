import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';
import { NavbarComponent } from '../shared/navbar/navbar.component';

interface Project {
  title: string;
  year: string;
  role: string;
  tags: string[];
  image?: string;
  route?: string;
}

@Component({
  selector: 'app-recent-projects',
  standalone: true,
  imports: [CommonModule, RouterLink, NavbarComponent],
  templateUrl: './recent-projects.component.html',
  styleUrls: ['./recent-projects.component.scss'],
})
export class RecentProjectsComponent {
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

  // Projects data
  projects: Project[] = [
    {
      title: 'Rebuilt to Inspire',
      year: '2025',
      role: 'Full Stack Designer & Developer',
      tags: ['AI/ML', 'Healthcare', 'Full Stack', 'Cancer Recovery'],
      image: 'assets/projects/rebuilt-to-inspire/rti-hero.png',
      route: '/projects/rebuilt-to-inspire'
    },
    {
      title: 'KSP Mental Performance',
      year: '2024',
      role: 'UX Designer',
      tags: ['Mobile App', 'UX/UI', 'Mental Health'],
      image: 'assets/projects/ksp/ksp-hero.png',
      route: '/projects/ksp-mental-performance'
    },
    {
      title: 'Lock It In',
      year: '2025',
      role: 'Full Stack Designer & Developer',
      tags: ['React Native', 'Mobile App', 'Sports', 'Firebase'],
      image: 'assets/projects/lock-it-in/lockin-hero.png',
      route: '/projects/lock-it-in'
    },
    {
      title: 'Recovery Rebuild',
      year: '2025',
      role: 'Product Designer & Strategist',
      tags: ['Product Strategy', 'Design System', 'WHOOP', 'Wearables'],
      image: 'assets/projects/recovery-rebuild/whoop-hero.png',
      route: '/projects/recovery-rebuild'
    },
    {
      title: 'Continuo iPad App',
      year: '2024',
      role: 'Product Designer · Flutter Developer',
      tags: ['Healthcare AI', 'iPad App', 'UX/UI', 'EdTech'],
      image: 'assets/projects/continuo/continuo-main-menu.png',
      route: '/projects/continuo'
    },
    {
      title: 'Zelda Puzzle',
      year: '2024',
      role: 'UX/UI Designer · Developer',
      tags: ['Interaction Design', 'Creative UX', 'Web'],
      image: 'assets/projects/intor_test/triforce-ocarina.png',
      route: '/projects/zelda-puzzle'
    },
    {
      title: 'AI Fall Detection System',
      year: '2024',
      role: 'Developer · ML Engineer',
      tags: ['AI/ML', 'Healthcare', 'Computer Vision', 'React'],
      image: 'assets/fall-detection/fall-detection-hero.png',
      route: '/projects/fall-detection'
    }
  ];
}
