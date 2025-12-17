import { Component, HostListener } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';

interface AnimationProject {
  title: string;
  description: string;
  thumbnail: string;
  videoUrl?: string;
  tags: string[];
  tools?: string[];
  featured?: boolean;
}

interface Category {
  id: string;
  label: string;
  icon: string;
}

@Component({
  selector: 'app-animation',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './animation.component.html',
  styleUrls: ['./animation.component.scss'],
})
export class AnimationComponent {
  // Modal state
  isModalOpen = false;
  currentVideo = '';
  currentVideoTitle = '';

  // Active category for navigation
  activeCategory = 'misfit';

  // Categories for navigation
  categories: Category[] = [
    { id: 'misfit', label: 'Misfit Athletics', icon: 'layers' },
    { id: 'titles', label: 'Title Sequences', icon: 'film' },
    { id: '3d', label: '3D Product Design', icon: 'cube' },
    { id: 'sword', label: 'Sword Animation', icon: 'sword' },
  ];

  // Misfit Athletics (Logo, Brand, Keychain - grouped together)
  misfitProjects: AnimationProject[] = [
    {
      title: 'Misfit Athletics Brand Animation',
      description: 'Dynamic logo animation and brand identity motion for a fitness brand. Features kinetic typography and energetic transitions.',
      thumbnail: 'assets/animation/misfit-thumb.png',
      videoUrl: 'assets/animation/misfit-video.mp4',
      tags: ['Logo Animation', 'Brand Identity', 'Motion Graphics'],
      tools: ['After Effects', 'Illustrator'],
      featured: true,
    },
    {
      title: 'Misfit Keychain',
      description: '3D modeled keychain design for Misfit Athletics merchandise. From concept to production-ready model.',
      thumbnail: 'assets/animation/misfitkeychain.png',
      tags: ['3D Modeling', 'Product Design', 'Merchandise'],
      tools: ['Blender', 'Fusion 360'],
    },
  ];

  // Title Sequences (Project Limitless, DJ, Hyrox - grouped together)
  titleProjects: AnimationProject[] = [
    {
      title: 'Project Limitless Intro',
      description: 'Cinematic title sequence for Project Limitless. Bold typography with dynamic visual effects and high-energy motion.',
      thumbnail: 'assets/animation/Project Limitless intro.mp4',
      videoUrl: 'assets/animation/Project Limitless intro.mp4',
      tags: ['Title Sequence', 'Cinematic', 'Motion Graphics'],
      tools: ['After Effects', 'Premiere Pro'],
      featured: true,
    },
    {
      title: 'DJ Event Promo',
      description: 'High-energy promotional animation for DJ events. Combines bold typography with dynamic visual effects and beat-synced motion.',
      thumbnail: 'assets/animation/dj.MP4',
      videoUrl: 'assets/animation/dj.MP4',
      tags: ['Event Promo', 'Music', 'Motion Graphics'],
      tools: ['After Effects', 'Cinema 4D'],
    },
    {
      title: 'Hyrox Event',
      description: 'Dynamic promotional animation for Hyrox fitness events. Energetic transitions and athletic-inspired visuals.',
      thumbnail: 'assets/animation/hyrox.MOV',
      videoUrl: 'assets/animation/hyrox.MOV',
      tags: ['Event Promo', 'Fitness', 'Motion Graphics'],
      tools: ['After Effects', 'Cinema 4D'],
    },
  ];

  // 3D Product Design (K'NEX toy)
  modelingProjects: AnimationProject[] = [
    {
      title: "K'NEX 3D Recreation",
      description: 'Detailed 3D model of a classic K\'NEX building set piece. Nostalgic recreation with modern rendering techniques, accurate materials, and product visualization.',
      thumbnail: 'assets/animation/product 2.jpg',
      tags: ['3D Modeling', 'Product Design', 'Nostalgia'],
      tools: ['Blender', 'Cinema 4D'],
      featured: true,
    },
  ];

  // Sword Animation Project
  swordProject: AnimationProject = {
    title: 'Game-Inspired 3D Sword Animation',
    description: 'A passion project bringing iconic video game swords to life through detailed 3D modeling and cinematic animation. This showcase features meticulously crafted weapon designs with dynamic lighting, particle effects, and fluid motion sequences inspired by classic action-adventure games.',
    thumbnail: 'assets/animation/sword-hero.jpg',
    videoUrl: 'assets/animation/sword-video.mp4',
    tags: ['3D Animation', 'Game Art', 'VFX', 'Cinematic'],
    tools: ['Blender', 'After Effects', 'DaVinci Resolve'],
    featured: true,
  };

  // Sword gallery items
  swordGallery: { image: string; caption: string }[] = [
    { image: 'assets/animation/sword-detail-1.png', caption: 'Blade Detail & Texturing' },
  ];

  // Open video modal
  openModal(videoUrl: string, title: string): void {
    this.currentVideo = videoUrl;
    this.currentVideoTitle = title;
    this.isModalOpen = true;
    document.body.style.overflow = 'hidden';
  }

  // Close video modal
  closeModal(): void {
    this.isModalOpen = false;
    this.currentVideo = '';
    this.currentVideoTitle = '';
    document.body.style.overflow = '';
  }

  // Handle escape key to close modal
  @HostListener('document:keydown.escape')
  onEscapeKey(): void {
    if (this.isModalOpen) {
      this.closeModal();
    }
  }

  // Scroll to section
  scrollToSection(sectionId: string): void {
    this.activeCategory = sectionId;
    const element = document.getElementById(sectionId);
    if (element) {
      const offset = 100;
      const elementPosition = element.getBoundingClientRect().top;
      const offsetPosition = elementPosition + window.pageYOffset - offset;
      window.scrollTo({
        top: offsetPosition,
        behavior: 'smooth',
      });
    }
  }

  // Track scroll for active category
  @HostListener('window:scroll')
  onScroll(): void {
    const sections = ['misfit', 'titles', '3d', 'sword'];
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
}
