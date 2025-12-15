import { Component } from '@angular/core';

@Component({
  selector: 'app-main-page',
  standalone: true,
  imports: [],
  template: `
    <div class="hero-bg">
      <svg class="circle-svg c1" width="420" height="420" viewBox="0 0 420 420"><circle cx="210" cy="210" r="200" stroke="#fff2" stroke-width="2" fill="none"/><circle cx="210" cy="210" r="150" stroke="#fff2" stroke-width="1.5" fill="none"/><circle cx="210" cy="210" r="100" stroke="#fff2" stroke-width="1" fill="none"/><circle cx="210" cy="210" r="50" stroke="#fff2" stroke-width="1" fill="none"/><circle cx="210" cy="210" r="4" fill="#fff6"/></svg>
      <svg class="circle-svg c2" width="320" height="320" viewBox="0 0 320 320"><circle cx="160" cy="160" r="150" stroke="#fff2" stroke-width="1.5" fill="none"/><circle cx="160" cy="160" r="100" stroke="#fff2" stroke-width="1" fill="none"/><circle cx="160" cy="160" r="50" stroke="#fff2" stroke-width="1" fill="none"/><circle cx="160" cy="160" r="4" fill="#fff6"/></svg>
      <svg class="circle-svg c3" width="220" height="220" viewBox="0 0 220 220"><circle cx="110" cy="110" r="100" stroke="#fff2" stroke-width="1" fill="none"/><circle cx="110" cy="110" r="50" stroke="#fff2" stroke-width="1" fill="none"/><circle cx="110" cy="110" r="4" fill="#fff6"/></svg>
      <div class="main-content">
        <h1 class="main-title">
          <span class="outlined">WEB &amp; MOBILE</span><br />
          <span class="outlined red">ANIMATION DESIGNER</span>
        </h1>
        <div class="desc-row">
          <p class="main-desc">
            Hello there, I am Beau - a product designer specializing in web mobile apps and animation. I craft user - focused designs that drive conversations and resonate with audiences.
          </p>
          <button class="contact-btn">Contact Me</button>
        </div>
      </div>
    </div>
  `,
  styles: `
    body, :host {
      margin: 0;
      padding: 0;
      font-family: 'Inter', 'Arial', sans-serif;
    }
    .hero-bg {
      min-height: 100vh;
      width: 100vw;
      background: #111216;
      position: relative;
      overflow: hidden;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .main-title {
      font-size: 4vw;
      font-weight: 900;
      styleUrls: ['./main-page.css'],
      letter-spacing: 0.04em;
    }
    .outlined {
      color: #fff;
      text-shadow: 2px 2px 0 #e11d48, 4px 4px 0 #000, 0 2px 8px #0008;
      -webkit-text-stroke: 2px #fff;
      text-stroke: 2px #fff;
      font-family: inherit;
      font-weight: 900;
      font-size: 1em;
      letter-spacing: 0.04em;
    }
    .outlined.red {
      color: #fff;
      text-shadow: 2px 2px 0 #e11d48, 4px 4px 0 #000, 0 2px 8px #0008;
      -webkit-text-stroke: 2px #e11d48;
      text-stroke: 2px #e11d48;
    }
    .desc-row {
      display: flex;
      flex-direction: row;
      align-items: center;
      justify-content: center;
      gap: 2vw;
      margin-top: 2vw;
      flex-wrap: wrap;
    }
    .desc {
      color: #fff;
      font-size: 1.2vw;
      max-width: 500px;
      margin: 0;
      font-weight: 400;
      text-align: left;
    }
    .contact-btn {
      background: #232427;
      color: #fff;
      border: 2px solid #fff;
      border-radius: 2em;
      padding: 1em 2.5em;
      font-size: 1.1vw;
      font-weight: 600;
      cursor: pointer;
      box-shadow: 0 2px 16px #0004;
      transition: background 0.2s, color 0.2s, border 0.2s;
      margin-left: 2vw;
    }
    .contact-btn:hover {
      background: #fff;
      color: #232427;
      border: 2px solid #e11d48;
    }
    @media (max-width: 900px) {
      .main-title { font-size: 7vw; }
      .desc { font-size: 2.5vw; }
      .contact-btn { font-size: 2.5vw; }
    }
    @media (max-width: 600px) {
      .main-title { font-size: 10vw; }
      .desc-row { flex-direction: column; gap: 2em; }
      .desc { font-size: 4vw; text-align: center; }
      .contact-btn { font-size: 4vw; margin-left: 0; }
    }
  `,
})
export class MainPage {

}
