# Portfolio ⚡️ [![GitHub](https://img.shields.io/github/license/cobiwave/simplefolio?color=blue)](https://github.com/cobiwave/simplefolio/blob/master/LICENSE.md) ![GitHub stars](https://img.shields.io/github/stars/cobiwave/simplefolio) ![GitHub forks](https://img.shields.io/github/forks/cobiwave/simplefolio)

## A minimal portfolio template for Developers!

<h2 align="center">
  <img src="https://github.com/cobiwave/gatsby-simplefolio/blob/master/examples/example.gif" alt="Simplefolio" width="600px" />
  <br>
</h2>

## Features

⚡️ Modern UI Design + Reveal Animations\
⚡️ One Page Layout\
⚡️ Styled with Bootstrap v4.3 + Custom SCSS\
⚡️ Fully Responsive\
⚡️ Valid HTML5 & CSS3\
⚡️ Optimized with Parcel\
⚡️ Well organized documentation

To view the demo: **[click here]([https://the-simplefolio.netlify.app/](https://cheerful-travesseiro-494e8a.netlify.app/))**

---

## Why do you need a portfolio? ☝️

- Professional way to showcase your work
- Increases your visibility and online presence
- Shows you’re more than just a resume

## Getting Started 🚀

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

## Clone repository

- Klik op '+' rechtsboven in je scherm en selecteer 'Import repository'
- Vul onderstaande URL in bij 'Your old repository's clone URL':
  https://github.com/TimValks/portfolio
- Geef je nieuwe repository een naam
- Druk op 'Begin import' rechts onder in

---

## Template Instructions:

### Step 1 - STRUCTURE

Go to `/src/index.html` and put your information, there are 5 sections:

### (1) Hero Section

- On `.hero-title`, put your custom portfolio title.
- On `.hero-cta`, put your custom button label.

```html
 <!-- **** Hero Section **** -->
    <section id="hero" class="jumbotron">
      <div class="container">
        <img src="assets/Logo.png" alt="Logo" class="logo" height="250px" width="600px" style="margin-bottom: 50px;">
        <h1 class="hero-title load-hidden">
          Welkom, op de portfolio pagina van <span class="text-color-main">**Tim Valks**</span>.
          <br />
        </h1>
        <p class="hero-cta load-hidden">
          <a rel="noreferrer" class="cta-btn cta-btn--hero" href="#about"
            >Meer informatie</a
          >
        </p>
      </div>
    </section>
    <!-- /END Hero Section -->
```

### (2) About Section

- On `<img>` tag, fill the `src` property with your profile picture path, your picture must be located inside `/src/assets/` folder.
- On `<p>` tag with class name `.about-wrapper__info-text`, include information about you, I recommend to put 2 paragraphs in order to work well and a maximum of 3 paragraphs.
- On last `<a>` tag, include your CV (.pdf) path on `href` property, your resume CV must be located inside `/src/assets/` folder.

```html
<!-- **** About Section **** -->
<section id="about">
  <div class="container">
    <h2 class="section-title load-hidden">About me</h2>
    <div class="row about-wrapper">
      <div class="col-md-6 col-sm-12">
        <div class="about-wrapper__image load-hidden">
          <img
            alt="Profile Image"
            class="img-fluid rounded shadow-lg"
            height="auto"
            width="300px"
            src="assets/profile.jpg"
            alt="Profile Image"
          />
        </div>
      </div>
      <div class="col-md-6 col-sm-12">
        <div class="about-wrapper__info load-hidden">
          <p class="about-wrapper__info-text">
            This is where you can describe about yourself. The more you describe
            about yourself, the more chances you can!
          </p>
          <p class="about-wrapper__info-text">
            Extra Information about you! like hobbies and your goals.
          </p>
          <span class="d-flex mt-3">
            <a
              rel="noreferrer"
              target="_blank"
              class="cta-btn cta-btn--resume"
              href="assets/resume.pdf"
            >
              View Resume
            </a>
          </span>
        </div>
      </div>
    </div>
  </div>
</section>
<!-- /END About Section -->
```

### (3) Projects Section

- Each project lives inside a `row`.
- On `<h3>` tag with class name `.project-wrapper__text-title`, include your project title.
- On `<p>` tag with `loremp ipsum` text, include your project description.
- On first `<a>` tag, put your project url on `href` property.
- On second `<a>` tag, put your project repository url on `href` property.

---

- Inside `<div>` tag with class name `.project-wrapper__image`, put your project image url on the `src` of the `<img>` and put again your project url in the `href` property of the `<a>` tag.
- Recommended size for project image (1366 x 767), your project image must be located inside `/src/assets/` folder.

```html
<!-- **** Projects Section **** -->
<section id="projects">
  ...
  <!-- Notice: each .row is a project -->
  <div class="row">
    <div class="col-lg-4 col-sm-12">
      <div class="project-wrapper__text load-hidden">
        <h3 class="project-wrapper__text-title">Project Title</h3>
        <div>
          <p class="mb-4">
            Lorem ipsum dolor sit, amet consectetur adipisicing elit. Excepturi
            neque, ipsa animi maiores repellendus distinctio aperiam earum dolor
            voluptatum consequatur blanditiis inventore debitis fuga numquam
            voluptate ex architecto itaque molestiae.
          </p>
        </div>
        <a
          rel="noreferrer"
          target="_blank"
          class="cta-btn cta-btn--hero"
          href="#!"
        >
          See Live
        </a>
        <a
          rel="noreferrer"
          target="_blank"
          class="cta-btn text-color-main"
          href="#!"
        >
          Source Code
        </a>
      </div>
    </div>
    <div class="col-lg-8 col-sm-12">
      <div class="project-wrapper__image load-hidden">
        <a rel="noreferrer" href="#!" target="_blank">
          <div
            data-tilt
            data-tilt-max="4"
            data-tilt-glare="true"
            data-tilt-max-glare="0.5"
            class="thumbnail rounded js-tilt"
          >
            <img
              alt="Project Image"
              class="img-fluid"
              src="assets/project.jpg"
            />
          </div>
        </a>
      </div>
    </div>
  </div>
  <!-- /END Project -->
  ...
</section>
```
### (4) Cursus Section
- On 'li class="cursus-item", replace the current courses with the name of the course you followed
- Delete unused rows
  
    <!-- **** Cursus Section **** -->
<section id="cursussen" class="cursussen">
  <div class="container">
    <h2 class="section-title">Cursussen</h2>
    <ul class="cursus">
      <li class="cursus-item">Extract, Transform and Load Data in Power Bi - Coursera</li>
      <li class="cursus-item">Data Modeling in Power Bi - Coursera</li>
      <li class="cursus-item">Data Analyses and Visualization with Power Bi - Coursera</li>
      <li class="cursus-item">SQL Fundamentals - Datacamp</li>
      <li class="cursus-item">Associate Data Analyses in SQL - Datacamp</li>
      <li class="cursus-item">Data Visualization with Python - Coursera</li>
      <li class="cursus-item">Professional Scrum Master 1</li>
    </ul>
  </div>
</section>

### (6) Tools section
- Replace/add tools if necessary, by replacing the logo at '<img src=' and the name after 'width=20px>'

<section id="vaardigheden" class="vaardigheden">
  <div class="container">
    <h2 class="section-title">Skills</h2>
    <div class="programmas">
      <div class="programma"><img src="assets/Powerbi.png" alt="Power BI logo" height=20px width=20px> Power BI</div>
      <div class="programma"><img src="assets/sqllogo.png" alt="SQL logo" height=20px width=20px> SQL</div>
      <div class="programma"><img src="assets/Python.png" alt="Python logo" height=20px width=20px> Python</div>
      <div class="programma"><img src="assets/pandas.png" alt="Pandas logo" height=20px width=20px> Pandas</div>
      <div class="programma"><img src="assets/github.png" alt="Github logo" height=20px width=20px> Github</div>
      <div class="programma"><img src="assets/azure.png" alt="Azure logo" height=20px width=20px> Azure</div>
    </div>
  </div>
</section>

### (7) Contact Section

- On `<p>` tag with class name `.contact-wrapper__text`, include some custom call-to-action message.
- On `<a>` tag, put your email address on `href` property.

```html
<!-- **** Contact Section **** -->
<section id="contact">
  <div class="container">
    <h2 class="section-title">Contact</h2>
    <div class="contact-wrapper load-hidden">
      <p class="contact-wrapper__text">[Put your call to action here]</p>
      <a
        rel="noreferrer"
        target="_blank"
        class="cta-btn cta-btn--resume"
        href="mailto:example@email.com"
        >Call to Action</a
      >
    </div>
  </div>
</section>
<!-- /END Contact Section -->
```

### (8) Footer Section

- Put your Social Media URL on each `href` attribute of the `<a>` tags.
- If you an additional Social Media account different than Twitter, Linkedin or GitHub, then go to [Font Awesome Icons](https://fontawesome.com/v4.7.0/icons/) and search for the icon's class name you are looking.
- You can delete or add as many `<a>` tags your want.

```html
<footer class="footer navbar-static-bottom">
  ...
  <div class="social-links">
    <a href="#!" target="_blank">
      <i class="fa fa-twitter fa-inverse"></i>
    </a>
    <a href="#!" target="_blank">
      <i class="fa fa-linkedin fa-inverse"></i>
    </a>
    <a href="#!" target="_blank">
      <i class="fa fa-github fa-inverse"></i>
    </a>
  </div>
  ...
</footer>
```

### Step 2 - STYLES

Change the color theme of the website - (choose 2 colors to create a gradient)

Go to `/src/sass/abstracts/_variables.scss` and only change the values for this variables `$main-color` and `$secondary-color` with your prefered HEX color.
If you want to get some gradients inspiration I highly recommend you to check this website [UI Gradient](https://uigradients.com/#BrightVault)

```scss
// Default values
$main-color: #02aab0;
$secondary-color: #00cdac;
```

---

## Deployment 📦

Once you finish your setup. You need to put your website online!

I highly recommend to use [Netlify](https://netlify.com) because it is super easy.

## Others versions 👥

[Gatsby Simplefolio](https://github.com/cobiwave/gatsby-simplefolio) by [Jacobo Martinez](https://github.com/cobiwave)\
[Ember.js Simplefolio](https://github.com/sernadesigns/simplefolio-ember) by [Michael Serna](https://github.com/sernadesigns)

## Technologies used 🛠️

- [Parcel](https://parceljs.org/) - Bundler
- [Bootstrap 4](https://getbootstrap.com/docs/4.3/getting-started/introduction/) - Frontend component library
- [Sass](https://sass-lang.com/documentation) - CSS extension language
- [ScrollReveal.js](https://scrollrevealjs.org/) - JavaScript library
- [Tilt.js](https://gijsroge.github.io/tilt.js/) - JavaScript tiny parallax library

## Authors

- **Jacobo Martinez** - [https://github.com/cobiwave](https://github.com/cobiwave)

## Status

[![Netlify Status](https://api.netlify.com/api/v1/badges/3a029bfd-575c-41e5-8249-c864d482c2e5/deploy-status)](https://app.netlify.com/sites/the-simplefolio/deploys)

## License 📄

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments 🎁

I was motivated to create this project because I wanted to contribute on something useful for the dev community, thanks to [ZTM Community](https://github.com/zero-to-mastery) and [Andrei](https://github.com/aneagoie)
