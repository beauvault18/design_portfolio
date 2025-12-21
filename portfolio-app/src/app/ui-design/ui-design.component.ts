import { Component, HostListener } from '@angular/core';
import { RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';
import { DomSanitizer, SafeResourceUrl } from '@angular/platform-browser';

interface DesignProject {
  title: string;
  category: string;
  description: string;
  image: string;
  tags: string[];
  route?: string;
}

interface Category {
  id: string;
  label: string;
  icon: string;
}

interface Prototype {
  title: string;
  label: string;
  description: string;
  embedUrl: SafeResourceUrl;
  figmaUrl: string;
  isWide?: boolean;
}

interface ProcessStep {
  number: string;
  title: string;
  description: string;
}

@Component({
  selector: 'app-ui-design',
  standalone: true,
  imports: [RouterLink, CommonModule],
  templateUrl: './ui-design.component.html',
  styleUrls: ['./ui-design.component.scss'],
})
export class UiDesignComponent {
  // Active category for navigation
  activeCategory = 'projects';

  // Contact modal visibility
  showContactModal = false;

  // Categories for navigation
  categories: Category[] = [
    { id: 'projects', label: 'Featured Projects', icon: 'layout' },
    { id: 'prototypes', label: 'Prototypes', icon: 'smartphone' },
    { id: 'process', label: 'Design Process', icon: 'tool' },
  ];

  // Design Projects
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
      image: 'assets/projects/continuo/continuo-main-menu.png',
      tags: ['iPad UI', 'Healthcare', 'Flutter'],
      route: '/projects/continuo'
    },
    {
      title: 'Zelda Puzzle',
      category: 'Interactive Web Design',
      description: 'A browser-based puzzle game inspired by The Legend of Zelda, featuring canvas animations and audio integration.',
      image: 'assets/projects/intor_test/triforce-ocarina.png',
      tags: ['Web Design', 'Game UI', 'Animation'],
      route: '/projects/zelda-puzzle'
    }
  ];

  // Interactive Prototypes
  prototypes: Prototype[] = [];

  // Design Philosophy
  designPhilosophy = 'Every design decision starts with understanding user needs, pain points, and goals. I believe in creating interfaces that are not just visually appealing, but truly serve the people who use them. My approach combines systematic thinking with creative exploration to deliver solutions that are both beautiful and functional.';

  designHighlight = 'Great design is invisible—it gets out of the way and lets users accomplish their goals effortlessly.';

  // Process Steps
  processSteps: ProcessStep[] = [
    {
      number: '01',
      title: 'Discover',
      description: 'Research users, analyze competitors, and define the problem space through interviews and data analysis.'
    },
    {
      number: '02',
      title: 'Define',
      description: 'Synthesize research into personas, user journeys, and clear design requirements.'
    },
    {
      number: '03',
      title: 'Design',
      description: 'Create wireframes, visual designs, and interactive prototypes that bring ideas to life.'
    },
    {
      number: '04',
      title: 'Deliver',
      description: 'Hand off polished designs with detailed specs, collaborate with developers, and iterate based on feedback.'
    }
  ];

  // Skills
  skills = [
    { name: 'UI Design' },
    { name: 'UX Research' },
    { name: 'Prototyping' },
    { name: 'Design Systems' },
    { name: 'User Testing' },
    { name: 'Wireframing' }
  ];

  // Tools
  tools = [
    { name: 'Figma' },
    { name: 'Sketch' },
    { name: 'Adobe XD' },
    { name: 'Photoshop' },
    { name: 'Illustrator' },
    { name: 'After Effects' },
    { name: 'Unity' }
  ];

  constructor(private sanitizer: DomSanitizer) {
    this.initializePrototypes();
  }

  private initializePrototypes(): void {
    const prototypeData = [
      {
        title: 'Oddish Hover',
        label: 'Hover Interaction',
        description: 'A playful Pokemon-inspired hover interaction with charming character animations.',
        embedUrl: 'https://www.figma.com/embed?embed_host=share&url=https%3A%2F%2Fwww.figma.com%2Fproto%2F67iGNn5lLLDez3DeIG9E5x%2FOddish-Hover%3Fnode-id%3D0-1',
        figmaUrl: 'https://www.figma.com/proto/67iGNn5lLLDez3DeIG9E5x/Oddish-Hover?node-id=0-1'
      },
      {
        title: 'Plant Side Menu',
        label: 'UI Component',
        description: 'An elegant side navigation menu with smooth animations and plant-themed styling.',
        embedUrl: 'https://www.figma.com/embed?embed_host=share&url=https%3A%2F%2Fwww.figma.com%2Fproto%2FijsfV4riyTjm3Y4wVj0HOb%2FPlant-Side-Menu%3Fnode-id%3D0-1',
        figmaUrl: 'https://www.figma.com/proto/ijsfV4riyTjm3Y4wVj0HOb/Plant-Side-Menu?node-id=0-1'
      },
      {
        title: 'Tokyo Hover',
        label: 'Hover Interaction',
        description: 'A dynamic hover effect inspired by Tokyo aesthetics with smooth transitions.',
        embedUrl: 'https://www.figma.com/embed?embed_host=share&url=https%3A%2F%2Fwww.figma.com%2Fproto%2F14Mga7Iup55iOUCdMdKKjq%2FTokyo-Hover%3Fnode-id%3D0-1',
        figmaUrl: 'https://www.figma.com/proto/14Mga7Iup55iOUCdMdKKjq/Tokyo-Hover?node-id=0-1'
      },
      {
        title: 'Navigation Buttons',
        label: 'UI Component',
        description: 'A collection of interactive navigation button styles with hover states.',
        embedUrl: 'https://www.figma.com/embed?embed_host=share&url=https%3A%2F%2Fwww.figma.com%2Fproto%2F1oSj6j5oiy3jvONACjATtj%2FNavigation-buttons%3Fnode-id%3D0-1',
        figmaUrl: 'https://www.figma.com/proto/1oSj6j5oiy3jvONACjATtj/Navigation-buttons?node-id=0-1'
      },
      {
        title: 'Liquid Menu',
        label: 'UI Component',
        description: 'A fluid navigation menu with liquid morphing effects and smooth state transitions.',
        embedUrl: 'https://www.figma.com/embed?embed_host=share&url=https%3A%2F%2Fwww.figma.com%2Fproto%2FviNhhsI7HBFodJA50Hwby2%2FLiquid-Menu%3Fnode-id%3D0-1',
        figmaUrl: 'https://www.figma.com/proto/viNhhsI7HBFodJA50Hwby2/Liquid-Menu?node-id=0-1'
      },
      {
        title: 'Splash Logo',
        label: 'Logo Animation',
        description: 'An animated splash logo with smooth motion effects and dynamic transitions.',
        embedUrl: 'https://www.figma.com/embed?embed_host=share&url=https%3A%2F%2Fwww.figma.com%2Fproto%2FGaOwQ2oRcn2mouHSUW26R9%2FSplash-logo%3Fnode-id%3D0-1',
        figmaUrl: 'https://www.figma.com/proto/GaOwQ2oRcn2mouHSUW26R9/Splash-logo?node-id=0-1'
      },
      {
        title: 'Drink Drop',
        label: 'Wireframe Walkthrough',
        description: 'A Figma wireframe walkthrough for the Drink Drop app concept.',
        embedUrl: 'https://www.figma.com/embed?embed_host=share&url=https%3A%2F%2Fwww.figma.com%2Fproto%2F5n2DYvncRkwdDtl7kGwvUI%2FDrink_Drop%3Fnode-id%3D0-1',
        figmaUrl: 'https://www.figma.com/proto/5n2DYvncRkwdDtl7kGwvUI/Drink_Drop?node-id=0-1',
        isWide: true
      }
    ];

    this.prototypes = prototypeData.map(p => ({
      ...p,
      embedUrl: this.sanitizer.bypassSecurityTrustResourceUrl(p.embedUrl)
    }));
  }

  // Scroll to section
  scrollToSection(sectionId: string): void {
    this.activeCategory = sectionId;
    const element = document.getElementById(sectionId);
    if (element) {
      element.scrollIntoView({
        behavior: 'smooth',
      });
    }
  }

  // Track scroll for active category
  @HostListener('window:scroll')
  onScroll(): void {
    const sections = ['projects', 'prototypes', 'process'];
    for (const section of sections) {
      const element = document.getElementById(section);
      if (element) {
        const rect = element.getBoundingClientRect();
        if (rect.top <= 150 && rect.bottom >= 150) {
          this.activeCategory = section;
          break;
        }
      }
    }
  }

  // Open contact modal
  openContactModal(): void {
    this.showContactModal = true;
  }

  // Close contact modal
  closeContactModal(): void {
    this.showContactModal = false;
  }
}
