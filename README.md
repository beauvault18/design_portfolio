# portfolio-app: AI Onboarding & Codebase Guide

## 1. Project Overview

**portfolio-app** is a personal design portfolio web application for showcasing UI/UX, animation, and product design work. It features:
- A visually rich, responsive single-page experience
- Animated hero sections and image carousels
- "About Me" and project sections
- Modular, maintainable Angular codebase

## 2. Tech Stack
- **Language:** TypeScript, HTML, SCSS
- **Framework:** Angular 21 (standalone components)
- **Build Tools:** Angular CLI, npm
- **Testing:** Vitest
- **Other:** RxJS, TSLib

## 3. Project Structure
```
DESIGN_PORTFOLIO_FINAL/
├── backup_project.bat           # Windows batch script for project backup
└── portfolio-app/
    ├── angular.json             # Angular CLI config
    ├── package.json             # NPM dependencies & scripts
    ├── tsconfig.json            # TypeScript config (base)
    ├── tsconfig.app.json        # TypeScript config (app-specific)
    ├── README.md                # Angular CLI default README
    ├── public/                  # Static assets (favicon, etc.)
    └── src/
        ├── index.html           # App entry HTML
        ├── main.ts              # Angular bootstrap
        ├── styles.scss          # Global styles
        ├── assets/              # Image assets
        └── app/
            ├── app.ts           # Root Angular component
            ├── app.config.ts    # Angular app config & routing
            ├── home.component.* # Home page (HTML, SCSS, TS)
            ├── about.component.*# About page (HTML, SCSS, TS)
            ├── about-me/        # About Me subpage
            │   ├── about-me.component.*
            └── main-page/       # Main hero/landing section
                ├── main-page.ts
                └── main-page.css
```

## 4. File-by-File Documentation

### /portfolio-app/src/main.ts
- **Purpose:** Bootstraps Angular app with `App` root component and `appConfig`.
- **Key Functions:** `bootstrapApplication(App, appConfig)`

### /portfolio-app/src/index.html
- **Purpose:** HTML entry point; hosts `<app-root>`.

### /portfolio-app/src/styles.scss
- **Purpose:** Global styles, font imports, navigation bar, resets.

### /portfolio-app/src/app/app.ts
- **Purpose:** Root Angular component. Renders navigation and router outlet.
- **Exports:** `App` class (Angular component)
- **Key Methods:** N/A (template-driven)

### /portfolio-app/src/app/app.config.ts
- **Purpose:** Angular application configuration and routing.
- **Exports:** `appConfig` (routes: Home, About)

### /portfolio-app/src/app/home.component.*
- **Purpose:** Home page hero section, navigation, and intro.
- **Exports:** `HomeComponent` (Angular component)
- **Key Methods:** N/A (template-driven)

### /portfolio-app/src/app/about.component.*
- **Purpose:** About page with hero, image carousel, stats, experience, and narrative.
- **Exports:** `AboutComponent` (Angular component)
- **Key Methods:**
  - `nextImages()`, `prevImages()` (carousel navigation)
  - `visibleImages` (getter for carousel)

### /portfolio-app/src/app/about-me/about-me.*
- **Purpose:** About Me subpage; bio, skills, and story.
- **Exports:** `AboutMe` (Angular component)

### /portfolio-app/src/app/main-page/main-page.ts
- **Purpose:** Standalone hero/landing section with SVG animation and intro.
- **Exports:** `MainPage` (Angular component)

### /portfolio-app/src/assets/
- **Purpose:** Image assets for carousel and hero sections.

### /portfolio-app/public/
- **Purpose:** Static public assets (e.g., favicon)

### /portfolio-app/backup_project.bat
- **Purpose:** Windows batch script to back up the project (excludes 'psyche' folders)

## 5. Data Flow & Architecture
- **User navigation** triggers Angular router to load components.
- **Component templates** render UI, bind to properties (e.g., image arrays for carousels).
- **No backend/database**; all data is static or in-memory.
- **Assets** (images) are loaded from `/src/assets`.

## 6. Database Schema
- _Not applicable_: This project is frontend-only and does not use a database.

## 7. Configuration & Environment
- **Config files:**
  - `angular.json`: Angular CLI build and project config
  - `tsconfig.json`, `tsconfig.app.json`: TypeScript settings
  - `package.json`: Scripts, dependencies
- **Environment variables:** None required by default
- **API keys:** None required

## 8. Build/Run Commands
```sh
# Install dependencies
npm install

# Run development server
npm start
# or
npx ng serve

# Build for production
npm run build

# Run tests
npm test
```

## 9. Key Patterns & Conventions
- **Naming:**
  - Components: `*.component.ts`, `*.component.html`, `*.component.scss`
  - Standalone components use Angular's `standalone: true`
- **File Organization:**
  - Each component in its own file(s)
  - Subpages in their own folders
- **Architecture:**
  - Angular standalone components, no NgModules
  - Routing defined in `app.config.ts`
- **Styling:**
  - SCSS for component and global styles
  - Shared navigation bar styles in `styles.scss`
- **No backend or persistent storage**

---

_This README is designed for rapid onboarding of AI coding assistants and new contributors. For further details, see code comments and Angular documentation._
