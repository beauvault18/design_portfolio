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

  // Intersection Observer for scroll animations
  private observer: IntersectionObserver | null = null;

  // Active category for navigation
  activeCategory = 'misfit';

  // Categories for navigation
  categories: Category[] = [
    { id: 'misfit', label: 'Misfit Athletics', icon: 'layers' },
    { id: 'titles', label: 'Title Sequences', icon: 'film' },
    { id: '3d', label: '3D Product Design', icon: 'cube' },
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

  // 3D Product Design - Boo's Castle
  booCastleMain = {
    title: "Boo's Castle",
    description: "A detailed 3D product design inspired by Nintendo's iconic Boo character. Complete toy packaging design with multiple angles showcasing the haunted castle playset.",
    image: 'assets/animation/product 2.jpg',
    tags: ['3D Modeling', 'Product Design', 'Toy Design'],
    tools: ['Blender', 'Cinema 4D'],
  };

  // Left side thumbnails (Box and Ghost)
  booCastleLeft = [
    { image: 'assets/animation/box.png', title: 'Box Design' },
    { image: 'assets/animation/ghost.png', title: 'Ghost Character' },
  ];

  // Right side thumbnails (Views)
  booCastleRight = [
    { image: 'assets/animation/backview.png', title: 'Back View' },
    { image: 'assets/animation/sideview.png', title: 'Side View' },
  ];

  // Current main image
  currentMainImage = 'assets/animation/product 2.jpg';
  currentMainTitle = "Boo's Castle";

  // Swap thumbnail with main image
  swapWithMain(thumbnail: { image: string; title: string }, side: 'left' | 'right', index: number): void {
    // Store current main
    const oldMain = { image: this.currentMainImage, title: this.currentMainTitle };

    // Set new main from thumbnail
    this.currentMainImage = thumbnail.image;
    this.currentMainTitle = thumbnail.title;

    // Replace thumbnail with old main
    if (side === 'left') {
      this.booCastleLeft[index] = oldMain;
    } else {
      this.booCastleRight[index] = oldMain;
    }
  }

  // K'NEX Case Study Data
  caseStudyOverview = `During high school, I joined a specialized design program where I collaborated directly with the K'NEX product team on a licensed Super Mario playset. The goal was to translate an iconic "Ghost House" level from the Mario universe into a physical toy that would meet strict manufacturing constraints and perform well on retail shelves.`;

  caseStudyHighlight = `Despite being a student, I contributed to core parts of the product's development: gameplay research, feature selection, price-point modeling, prototyping, and visual design. The final design was part of the K'NEX x Nintendo Mario line and sold in major retail stores.`;

  caseStudyResponsibilities = [
    'Gameplay Research & Feature Extraction',
    'Cost Modeling & Feature Prioritization',
    'Visual Design: Painting & Sticker Development',
    'Prototype Assembly & User Testing',
    'Brand Guideline Compliance (Nintendo)',
  ];

  caseStudyTranslation = [
    {
      icon: '🎮',
      title: 'Gameplay Mechanics Identified',
      items: ['Moving platforms', 'Hidden Boos that appear/disappear', 'Multi-level exploration', 'Trap steps & sliding elements', 'Secret passages'],
    },
    {
      icon: '🏗️',
      title: 'Physical Features Selected',
      items: ['Rotating ghost platform', 'Pop-up Boo mechanism', 'Three-story structure', 'Hinged trap door stairs', 'Modular room layout'],
    },
    {
      icon: '💡',
      title: 'Why These Choices Matter',
      items: ['Tactile engagement over visual tricks', 'Replayable discovery moments', 'Age-appropriate complexity', "Compatible with existing K'NEX parts", '"Haunted" atmosphere captured'],
    },
  ];

  caseStudyFeatures = {
    kept: ['Rotating ghost platform', 'Pop-up Boo figure', 'Three-story structure', 'Trap door mechanism', 'Custom decal sheets', 'Mario & Boo minifigures'],
    cut: ['LED lighting effects', 'Sound module', 'Motorized elements', 'Extra character figures', 'Larger footprint design', 'Complex gear mechanisms'],
  };

  caseStudyChallenges = [
    {
      title: 'Translating Digital Mechanics Into Physical Play',
      problem: 'The Mario Ghost House level contains visual tricks and illusions that are impossible to fully replicate physically.',
      solution: 'Focused on mechanics that could be "felt" physically: movement, levels, reveals, and tactile discovery moments.',
    },
    {
      title: 'Hitting a Price Point Without Sacrificing Play Value',
      problem: 'Fun vs. cost was a constant balancing act throughout development.',
      solution: "Reused standard K'NEX parts, removed costly ideas, emphasized modular construction that maximized play value.",
    },
    {
      title: 'Sticker Legibility at Small Scale',
      problem: 'Nintendo graphics are highly detailed; sticker surfaces on toys are very small.',
      solution: 'Simplified shapes, increased contrast, prioritized silhouettes over texture for maximum visual impact.',
    },
  ];

  caseStudyLearnings = [
    { icon: '🎯', text: 'How to map digital experiences into physical products' },
    { icon: '💰', text: 'How cost constraints shape creative decisions' },
    { icon: '🎨', text: 'How to design within strict brand guidelines (Nintendo)' },
    { icon: '🔄', text: 'How to build intuitive play flow through prototyping' },
    { icon: '✨', text: 'How environmental graphics dramatically influence toy atmosphere' },
    { icon: '🤝', text: 'How to collaborate with engineering and manufacturing teams' },
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

  swordTools = ['Blender', 'After Effects', 'DaVinci Resolve', 'Photoshop'];

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
  }

  // Cleanup observer on destroy
  ngOnDestroy(): void {
    if (this.observer) {
      this.observer.disconnect();
    }
  }
}
