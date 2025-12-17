import { Component } from '@angular/core';
import { RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';

interface DesignProject {
  title: string;
  category: string;
  description: string;
  image: string;
  tags: string[];
  route?: string;
}

@Component({
  selector: 'app-ui-design',
  standalone: true,
  imports: [RouterLink, CommonModule],
  templateUrl: './ui-design.component.html',
  styleUrls: ['./ui-design.component.scss'],
})
export class UiDesignComponent {
  designProjects: DesignProject[] = [
    {
      title: 'KSP Mental Performance',
      category: 'Mobile App Design',
      description: 'A comprehensive mental wellness app designed to help users track and improve their mental performance through guided exercises and analytics.',
      image: 'assets/ksp/hero-cover.png',
      tags: ['Mobile UI', 'UX Research', 'Prototyping'],
      route: '/projects/ksp-mental-performance'
    },
    {
      title: 'Continuo iPad App',
      category: 'Tablet App Design',
      description: 'An interactive iPad application for healthcare demonstrations, featuring role-based navigation and video content management.',
      image: 'assets/continuo/continuo-hero.png',
      tags: ['iPad UI', 'Healthcare', 'Flutter'],
      route: '/projects/continuo'
    },
    {
      title: 'Zelda Puzzle',
      category: 'Interactive Web Design',
      description: 'A browser-based puzzle game inspired by The Legend of Zelda, featuring canvas animations and audio integration.',
      image: 'assets/zelda-puzzle/intor_test/images/triforce-ocarina.png',
      tags: ['Web Design', 'Game UI', 'Animation'],
      route: '/projects/zelda-puzzle'
    }
  ];

  skills = [
    { name: 'UI Design', level: 95 },
    { name: 'UX Research', level: 88 },
    { name: 'Prototyping', level: 92 },
    { name: 'Design Systems', level: 85 },
    { name: 'User Testing', level: 80 },
    { name: 'Wireframing', level: 90 }
  ];

  tools = [
    { name: 'Figma', icon: 'figma' },
    { name: 'Sketch', icon: 'sketch' },
    { name: 'Adobe XD', icon: 'xd' },
    { name: 'Photoshop', icon: 'ps' },
    { name: 'Illustrator', icon: 'ai' },
    { name: 'After Effects', icon: 'ae' }
  ];
}
