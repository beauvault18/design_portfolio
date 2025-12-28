import { Component } from '@angular/core';
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
  selector: 'app-recent-projects',
  standalone: true,
  imports: [CommonModule, RouterLink],
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
