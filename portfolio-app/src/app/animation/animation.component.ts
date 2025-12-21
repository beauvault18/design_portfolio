import { Component, HostListener, AfterViewInit, OnDestroy } from '@angular/core';
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
export class AnimationComponent implements AfterViewInit, OnDestroy {
  // Video Modal state
  isModalOpen = false;
  currentVideo = '';
  currentVideoTitle = '';

  // Image Modal state
  isImageModalOpen = false;
  currentImage = '';
  currentImageTitle = '';

  // Contact Modal state
  showContactModal = false;

  // Intersection Observer for scroll animations
  private observer: IntersectionObserver | null = null;

  // Active category for navigation
  activeCategory = 'misfit';

  // Categories for navigation
  categories: Category[] = [
    { id: 'misfit', label: 'Misfit Athletics', icon: 'layers' },
    { id: 'titles', label: 'Title Sequences', icon: 'film' },
    { id: 'sword', label: 'Sword Animation', icon: 'sword' },
  ];

  // Misfit Athletics - Main podcast video
  misfitPodcastVideo = 'assets/animation/podcast-video.mp4';

  // Misfit Athletics - Bottom row items (thumbnail, keychain, video)
  misfitBottomItems = {
    designTemplate: {
      title: 'Misfit Design Template',
      image: 'assets/animation/misfit-thumb.png',
      description: 'Brand design template and visual identity system',
    },
    keychain: {
      title: 'Misfit Keychain',
      image: 'assets/animation/misfitkeychain.png',
      description: '3D modeled keychain design for merchandise',
    },
    brandVideo: {
      title: 'Misfit Brand Animation',
      videoUrl: 'assets/animation/misfit-video.mp4',
      description: 'Dynamic logo animation and brand identity motion',
    },
  };

  // Misfit Athletics Case Study Data
  misfitAbout = `Misfit Athletics is a performance-driven fitness brand known for its high-intensity training programs, competitive athlete development, and bold, recognizable visual identity. Their community spans CrossFit athletes, everyday gym members, and teams competing at elite levels.`;

  misfitChallenge = `With a growing digital presence and rapidly expanding media output, Misfit needed updated motion graphics, social media animations, and merchandise visuals that stayed true to the brand's attitude — sharp, energetic, and unmistakably purple.`;

  misfitRole = [
    'Title sequences for podcast + video content',
    'Logo motion & intro animations for social campaigns',
    'Concept artwork for future merchandise',
    'Visual refresh of the brand graphic toolkit',
    'Creation of 3D and 2D assets for marketing',
  ];

  misfitDeliverables = [
    {
      icon: 'film',
      title: 'Title Animations',
      items: ['Podcast intro animation', 'Lower-third nameplates', 'Episode transition stingers', 'Social reels title templates'],
    },
    {
      icon: 'layers',
      title: 'Motion Identity Toolkit',
      items: ['Animated logo lockups', 'Color-driven atmospheric lighting', 'Geometric movement patterns', 'Accent shapes inspired by athletic motion'],
    },
    {
      icon: 'cube',
      title: 'Merchandise Concepts',
      items: ['3D-modeled keychain (Sharpen The Axe)', 'Apparel graphics', 'Simplified logo variants for embroidery', 'Sticker + decal concepts'],
    },
  ];

  misfitMotionPrinciples = [
    {
      number: '01',
      title: 'Strength Through Geometry',
      description: "The Misfit 'M' uses sharp-angle geometry. I used this to guide transitions, wipes, and logo reveals throughout all motion work.",
    },
    {
      number: '02',
      title: 'Athlete Energy',
      description: 'Motion is fast, decisive, and purposeful — matching how athletes move. Cuts are snappy, elements accelerate into place, and animations end with impact.',
    },
    {
      number: '03',
      title: 'Purple Identity Glow',
      description: "Misfit's signature purple becomes an atmospheric light source. A soft purple ambient glow adds depth and mood across intros and title cards.",
    },
  ];

  misfitOutcome = [
    'Elevated Misfit\'s digital presence across all platforms',
    'Made podcast + social content feel more premium and cohesive',
    'Provided reusable brand assets the team can scale into future campaigns',
    'Reinforced purple as a signature emotional anchor for the brand',
  ];

  // Title Sequences (Project Limitless, DJ, Hyrox - grouped together)
  titleProjects: AnimationProject[] = [
    {
      title: 'Project Limitless',
      description: 'A cinematic podcast intro designed to establish a strong brand identity. Features bold typography, smooth transitions, and high-energy motion synchronized to the show\'s tone.',
      thumbnail: 'assets/animation/Project Limitless intro.mp4',
      videoUrl: 'assets/animation/Project Limitless intro.mp4',
      tags: ['Podcast Intro', 'Title Sequence', 'Cinematic'],
      tools: ['After Effects', 'Premiere Pro'],
    },
    {
      title: 'DJ Event Promo',
      description: 'A fast-paced promotional animation created for a DJ\'s social content. Uses rhythm-driven cuts, bright color accents, and kinetic typography to match the intensity of live music.',
      thumbnail: 'assets/animation/dj.MP4',
      videoUrl: 'assets/animation/dj.MP4',
      tags: ['Social Media', 'Music', 'Kinetic Type'],
      tools: ['After Effects', 'Cinema 4D'],
    },
    {
      title: 'Hyrox Event',
      description: 'A dynamic motion graphic package built for HYROX fitness events. Athletic-inspired visuals, impactful transitions, and high-contrast type designed to elevate social media announcements.',
      thumbnail: 'assets/animation/hyrox.MOV',
      videoUrl: 'assets/animation/hyrox.MOV',
      tags: ['Fitness', 'Event Promo', 'Athletic'],
      tools: ['After Effects', 'Cinema 4D'],
    },
  ];

  // Title Sequences Case Study Data
  titleApproach = `Crafting title sequences for different industries — a podcast, a DJ brand, and a fitness event — required a flexible design system rooted in strong typography, rhythm-based animation, and clear visual storytelling.`;

  titlePrinciples = [
    { title: 'Define the emotional tone', description: 'Cinematic, energetic, or athletic' },
    { title: 'Match animation timing to audio rhythm', description: 'Synced to dialogue, music, or movement' },
    { title: 'Lead with typography', description: 'Support with motion, never distract' },
    { title: 'Brand identity in 2 seconds', description: 'Make the brand unmistakable immediately' },
  ];

  titleMotionRules = [
    {
      number: '01',
      title: 'Rhythm-Driven Motion',
      description: 'Every cut, scale, and reveal synced to dialogue cadence, music tempo, or athletic movement pacing.',
    },
    {
      number: '02',
      title: 'Typography as the Hero',
      description: 'Large, high-contrast type as the anchor. Motion supports the message — never distracts from it.',
    },
    {
      number: '03',
      title: 'Clean Transitions With Impact',
      description: 'Fast, intentional transitions designed to "hit" on beat or action. Energy without overwhelming.',
    },
    {
      number: '04',
      title: 'Modular Animation System',
      description: 'Reusable elements like line wipes, logo reveals, and glow pulses for professional polish.',
    },
  ];

  titleTools = [
    {
      name: 'After Effects',
      uses: ['Kinetic type animation', 'Glow + atmospheric lighting', 'Smooth camera movements', 'Time-remapped transitions'],
    },
    {
      name: 'Premiere Pro',
      uses: ['Audio syncing', 'Refining pacing and cuts', 'Final composition'],
    },
    {
      name: 'Cinema 4D',
      uses: ['3D logo turntables', 'Light sweeps', 'Depth-based camera animations', 'Metallic + neon textures'],
    },
  ];

  titleCreativeDecisions = [
    {
      project: 'Project Limitless',
      subtitle: 'Podcast Intro',
      style: 'Cinematic & Authoritative',
      points: ['Slower, more authoritative movement', 'Subtle glow accents', 'Clean typography for credibility'],
      goal: 'Make the show instantly feel premium and trustworthy.',
    },
    {
      project: 'DJ Event Promo',
      subtitle: 'Social Media Animation',
      style: 'Fast & Rhythm-Locked',
      points: ['Energetic color pulses', 'Quick cuts and sharp wipes', 'Typography mimicking beat drops'],
      goal: 'Match the hype and pace of live music culture.',
    },
    {
      project: 'Hyrox Event',
      subtitle: 'Fitness Media Promo',
      style: 'High-Intensity Athletic',
      points: ['Strong horizontal motion (mirrors competition flow)', 'High-contrast visuals', 'Impact transitions mimicking buzzer energy'],
      goal: 'Bring competition adrenaline into motion graphics form.',
    },
  ];

  titleOutcome = [
    'Consistent high-quality motion identity across all projects',
    'Clean, bold animations tailored to each specific audience',
    'A modular system that scales across future video content',
    'Professional polish through strong type, rhythm, and lighting',
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

  // Sword Case Study Data
  swordOverview = `This personal project explores how iconic fantasy-inspired game weapons can be reimagined through modern 3D workflows. The goal was to design, model, texture, and animate a hero sword asset that feels cinematic, magical, and game-ready — blending stylized fantasy with realistic rendering techniques.`;

  swordOverviewHighlight = `This project allowed me to push creative direction, develop strong prop-focused lighting, and refine the technical discipline behind clean topology and polished animation.`;

  swordProcess = [
    {
      number: '01',
      title: 'Concept & Reference',
      description: 'Studied design language from classic action-adventure games, focusing on silhouette, proportion, color identity, and magical themes. Defined the sword\'s visual direction before modeling.',
    },
    {
      number: '02',
      title: '3D Modeling',
      description: 'Built the sword in Blender using subdivision-friendly topology. Special attention was given to blade sharpness, guard structure, and hilt form to create a clean hero asset.',
    },
    {
      number: '03',
      title: 'Texturing & Materials',
      description: 'Applied PBR materials with subtle edge wear, surface variation, and realistic metal roughness. Used emission maps to introduce magical glow elements characteristic of fantasy weapons.',
    },
    {
      number: '04',
      title: 'Animation & Cinematic FX',
      description: 'Created a dramatic animation sequence featuring atmospheric camera movement, particle dust, bloom lighting, and energy effects. Focused on establishing mood and scale through timing and composition.',
    },
  ];

  swordDesignIntent = [
    'Capture the feeling of discovering a legendary weapon',
    'Combine stylized fantasy with realistic metal rendering',
    'Use color, glow, and light streaks to suggest magical energy',
    'Craft cinematic framing inspired by game cutscenes',
    'Build a clean, reusable workflow for future prop animations',
  ];

  swordTools = ['Blender', 'After Effects', '3ds Max', 'Photoshop'];

  swordHighlights = [
    { icon: 'cube', text: 'Hero-prop modeling with clean topology' },
    { icon: 'sparkles', text: 'Magical VFX created through emission, particles, and bloom' },
    { icon: 'sun', text: 'Strong use of atmospheric lighting and depth' },
    { icon: 'film', text: 'Cinematic motion direction with slow reveals and hero shots' },
    { icon: 'palette', text: 'Exploration of fantasy-inspired design without using licensed IP' },
  ];

  swordLearnings = [
    'How to create stylized cinematic lighting for props',
    'How to balance realism with fantasy materials',
    'How to design VFX that enhance storytelling',
    'How to structure a clean modeling + texturing pipeline',
    'How to use camera motion to elevate static objects',
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

  // Open image modal
  openImageModal(imageUrl: string, title: string): void {
    this.currentImage = imageUrl;
    this.currentImageTitle = title;
    this.isImageModalOpen = true;
    document.body.style.overflow = 'hidden';
  }

  // Close image modal
  closeImageModal(): void {
    this.isImageModalOpen = false;
    this.currentImage = '';
    this.currentImageTitle = '';
    document.body.style.overflow = '';
  }

  // Handle escape key to close modals
  @HostListener('document:keydown.escape')
  onEscapeKey(): void {
    if (this.isModalOpen) {
      this.closeModal();
    }
    if (this.isImageModalOpen) {
      this.closeImageModal();
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
    const sections = ['misfit', 'titles', 'sword'];
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

  // Start video preview on hover
  startPreview(event: MouseEvent, videoUrl: string): void {
    const card = event.currentTarget as HTMLElement;
    const video = card.querySelector('.project-card__video-preview') as HTMLVideoElement;
    if (video) {
      video.currentTime = 0;
      video.play().catch(() => {
        // Autoplay may be blocked, fail silently
      });
    }
  }

  // Stop video preview on mouse leave
  stopPreview(event: MouseEvent): void {
    const card = event.currentTarget as HTMLElement;
    const video = card.querySelector('.project-card__video-preview') as HTMLVideoElement;
    if (video) {
      video.pause();
      video.currentTime = 0;
    }
  }

  // Initialize scroll animations
  ngAfterViewInit(): void {
    // Observer for general fade-in-up elements
    this.observer = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add('is-visible');
          }
        });
      },
      {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px',
      }
    );

    // Observe all fade-in-up elements (except title cards)
    const fadeUpElements = document.querySelectorAll('.fade-in-up:not(.title-card)');
    fadeUpElements.forEach((el) => this.observer?.observe(el));

    // Special observer for title sequence cards - triggers when header is in middle of page
    const titleCardsObserver = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            // Trigger all title cards to animate
            const titleCards = document.querySelectorAll('.title-card');
            titleCards.forEach((card) => {
              card.classList.add('is-visible');
            });
            // Disconnect after triggering once
            titleCardsObserver.disconnect();
          }
        });
      },
      {
        threshold: 0.5, // Trigger when 50% visible (near middle)
        rootMargin: '-20% 0px -30% 0px', // Trigger when element is in middle portion of viewport
      }
    );

    // Observe the title sequences header
    const titlesHeader = document.getElementById('titles-header');
    if (titlesHeader) {
      titleCardsObserver.observe(titlesHeader);
    }

    // Observer for titles-hero animated title sequence
    const titlesHeroObserver = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            entry.target.classList.add('is-animating');
            titlesHeroObserver.disconnect();
          }
        });
      },
      {
        threshold: 0.3,
        rootMargin: '0px 0px -10% 0px',
      }
    );

    const titlesHero = document.querySelector('.titles-hero');
    if (titlesHero) {
      titlesHeroObserver.observe(titlesHero);
    }

    // Trigger smoke explosion on category nav when scan line reaches bottom
    const categoryNav = document.querySelector('.category-nav');
    if (categoryNav) {
      // The scan line animation takes 8.5s total: 6s drop + 2.5s smoke (no extra wait)
      // Line reaches bottom at 71% of 8.5s = ~6s
      const triggerExplosion = () => {
        categoryNav.classList.add('is-exploding');
        // Remove class after smoke animation completes (2.5s) so it can be triggered again
        setTimeout(() => {
          categoryNav.classList.remove('is-exploding');
        }, 2500);
      };

      // First trigger at 6s when scan line first hits bottom
      // Then repeat every 8.5s to match the full animation cycle
      setTimeout(() => {
        triggerExplosion();
        setInterval(triggerExplosion, 8500);
      }, 6000);
    }
  }

  // Cleanup observer on destroy
  ngOnDestroy(): void {
    if (this.observer) {
      this.observer.disconnect();
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
