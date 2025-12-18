import { Component, HostListener, AfterViewInit, OnDestroy } from '@angular/core';
import { CommonModule } from '@angular/common';
import { RouterLink } from '@angular/router';

@Component({
  selector: 'app-product-design',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './product-design.component.html',
  styleUrls: ['./product-design.component.scss'],
})
export class ProductDesignComponent implements AfterViewInit, OnDestroy {
  // Image Modal state
  isImageModalOpen = false;
  currentImage = '';
  currentImageTitle = '';

  // Intersection Observer for scroll animations
  private observer: IntersectionObserver | null = null;

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
    const oldMain = { image: this.currentMainImage, title: this.currentMainTitle };
    this.currentMainImage = thumbnail.image;
    this.currentMainTitle = thumbnail.title;
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
      title: 'Gameplay Mechanics Identified',
      items: ['Moving platforms', 'Hidden Boos that appear/disappear', 'Multi-level exploration', 'Trap steps & sliding elements', 'Secret passages'],
    },
    {
      title: 'Physical Features Selected',
      items: ['Rotating ghost platform', 'Pop-up Boo mechanism', 'Three-story structure', 'Hinged trap door stairs', 'Modular room layout'],
    },
    {
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
    { keyword: 'Translation', text: 'How to map digital experiences into physical products', definition: 'Converting game mechanics, visual cues, and interactive moments from screen to tactile, buildable play experiences.' },
    { keyword: 'Constraints', text: 'How cost constraints shape creative decisions', definition: 'Learning to maximize play value within strict manufacturing budgets by prioritizing high-impact features over expensive extras.' },
    { keyword: 'Guidelines', text: 'How to design within strict brand guidelines (Nintendo)', definition: 'Following precise color specifications, character proportions, and visual standards while still finding room for creative expression.' },
    { keyword: 'Prototyping', text: 'How to build intuitive play flow through prototyping', definition: 'Using physical mockups and testing to refine how kids naturally interact with and discover features in a toy.' },
    { keyword: 'Atmosphere', text: 'How environmental graphics dramatically influence toy atmosphere', definition: 'Small details like stickers, printed textures, and color choices transform a plastic shell into an immersive play world.' },
    { keyword: 'Collaboration', text: 'How to collaborate with engineering and manufacturing teams', definition: 'Working alongside engineers to balance design vision with production realities like tooling costs, part counts, and assembly.' },
  ];

  // White Erase Chair Project
  whiteEraseChair = {
    title: 'White Erase Chair',
    subtitle: 'Material-Driven Furniture Concept',
    description: 'The White Erase Chair is an experimental furniture design created by heat-forming a single acrylic sheet into a flexible, ergonomic seating form. Designed for library environments, the chair\'s smooth white acrylic surface doubles as a dry-erase writing surface — allowing users to jot down notes, sketch ideas, or bookmark thoughts directly on the chair while reading. This project explores material behavior, structural efficiency, and functional innovation through minimal construction. The result is a lightweight lounge chair shaped entirely by gravity, heat, and intuitive form development.',
    tags: ['Product Design', 'Material Exploration', 'Furniture Concept', 'Prototyping'],
    heroImage: 'assets/animation/emptychair.jpg',
  };

  whiteEraseProcess = [
    {
      number: '1',
      title: 'Material Exploration & Early Concepts',
      description: 'Experimented with heat-forming acrylic. When the heated sheet sagged, it unexpectedly formed a bean-like basin — sparking the idea for a seating surface.',
    },
    {
      number: '2',
      title: 'Form Development Through Heat Shaping',
      description: 'A 4x4 ft acrylic sheet was heated and draped over a rounded form. Gravity created natural curvature, producing a bowl-like geometry ideal for cradling the user.',
    },
    {
      number: '3',
      title: 'Ergonomic Testing & Cushion System',
      description: 'Developed a cushion system to secure posture and comfort within the firm acrylic basin. Flexible edges support dynamic movement without compromising structure.',
    },
    {
      number: '4',
      title: 'Prototype Assembly & Final Adjustments',
      description: 'Tested for durability and load distribution. The structure held weight without framing, revealing the strength of the molded acrylic form.',
    },
  ];

  whiteEraseGallery = [
    { image: 'assets/animation/mainchair.jpg', caption: 'User lounging in chair' },
    { image: 'assets/animation/sidechair.jpg', caption: 'Side profile view' },
  ];

  // White Erase Chair - current main image and title for swapping
  whiteEraseMainImage = 'assets/animation/emptychair.jpg';
  whiteEraseMainTitle = 'Empty Chair';

  // Swap thumbnail with main image for White Erase Chair
  swapWhiteEraseImage(item: { image: string; caption: string }, index: number): void {
    const oldMain = { image: this.whiteEraseMainImage, caption: this.whiteEraseMainTitle };
    this.whiteEraseMainImage = item.image;
    this.whiteEraseMainTitle = item.caption;
    this.whiteEraseGallery[index] = oldMain;
  }

  whiteEraseTools = ['Heat Gun', 'Acrylic Sheet', 'Hand Tools', 'Cushion Fabric & Foam', 'Sanding Tools'];

  whiteEraseLearnings = [
    { keyword: 'Material', text: 'How material properties drive form', definition: 'Understanding how acrylic responds to heat allowed the design to emerge organically from the material itself rather than forcing a predetermined shape.' },
    { keyword: 'Gravity', text: 'Using gravity as a design tool', definition: 'Letting heated material sag naturally created curves that are both structurally sound and visually elegant — a form no CAD software would generate.' },
    { keyword: 'Function', text: 'Adding function beyond seating', definition: 'The dry-erase surface transforms the chair from passive furniture into an active tool for thought — extending its purpose in library environments.' },
    { keyword: 'Iteration', text: 'Embracing happy accidents', definition: 'The original sink concept failed, but recognizing the seating potential in that failure led to a stronger, more original design direction.' },
    { keyword: 'Comfort', text: 'Balancing form with ergonomics', definition: 'A beautiful shape means nothing if it\'s unusable — cushion integration and edge flexibility were critical to making the concept functional.' },
    { keyword: 'Simplicity', text: 'One material, one process', definition: 'Limiting the design to a single sheet and heat-forming process forced creative problem-solving and resulted in a cleaner, more honest object.' },
  ];

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
    if (this.isImageModalOpen) {
      this.closeImageModal();
    }
  }

  // Initialize scroll animations
  ngAfterViewInit(): void {
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

    const fadeUpElements = document.querySelectorAll('.fade-in-up');
    fadeUpElements.forEach((el) => this.observer?.observe(el));

    // Observer for white-erase flip cards
    const flipCardsObserver = new IntersectionObserver(
      (entries) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            const flipCards = document.querySelectorAll('.white-erase-flip-card');
            flipCards.forEach((card) => {
              card.classList.add('animate-in');
            });
            flipCardsObserver.disconnect();
          }
        });
      },
      {
        threshold: 0.2,
        rootMargin: '0px 0px -10% 0px',
      }
    );

    const processGrid = document.querySelector('.white-erase-process-grid');
    if (processGrid) {
      flipCardsObserver.observe(processGrid);
    }
  }

  ngOnDestroy(): void {
    if (this.observer) {
      this.observer.disconnect();
    }
  }
}
