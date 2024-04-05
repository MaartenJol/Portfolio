# Portfolio ⚡️ 

Voorbeeld: **[click here]([https://the-simplefolio.netlify.app/](https://cheerful-travesseiro-494e8a.netlify.app/))**

---

## Stappenplan om de template aan te passen
Hieronder zie je 8 onderdelen waarmee je bovenstaand voorbeeld kan aanpassen naar je eigen portfolio.

Voordat je dit kan aanpassen moet je deze repository clonen naar je eigen pagina. Dat is hier onder uitgelegd.

## Clone repository

- Klik op '+' rechtsboven in je scherm en selecteer 'Import repository'
- Vul onderstaande URL in bij 'Your old repository's clone URL':
  https://github.com/TimValks/portfolio
- Geef je nieuwe repository een naam
- Druk op 'Begin import' rechts onder in

---

## Template instructies:

### Step 1 - STRUCTUUR

Ga naar `/src/index.html` en pas de 8 verschillende secties aan. Bij sommige onderdelen wordt ergens naar gelinkt (bijvoorbeeld je CV of een dashboard), deze bestanden moet je toevoegen aan `/src/assets`:

### (1) Hero Sectie

- Bij `.hero-title`, kan je de titel van je portfolio aanpassen.
- Bij `.hero-cta`, kan je tekst in de knop aanpassen.

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

### (2) About section

- Bij `<img>`, vul het `src` pad in om bij jou profielfoto te komen, zoals gezegd moet je profielfoto in de `/src/assets/` map staan. De profielfoto staat er nu in als `src="assets/trainees--2.jpg"`
- Bij `<p>` met class name `.about-wrapper__info-text`, voeg informatie over jezelf toe, ik zou een tekst maken van 2 alineas waarbij je iets over jezelf verteld en het werk dat je nu doet.
- Als laatste `<a>` , voeg je CV (.pdf) pad toe bij `href`, je CV moet weer in de `/src/assets/` map staan.

```html
 <!-- **** About Section **** -->
    <section id="about">
      <div class="container">
        <h2 class="section-title load-hidden">Over mij</h2>
        <div class="row about-wrapper">
          <div class="col-md-6 col-sm-12">
            <div class="about-wrapper__image load-hidden">
              <img
                alt="Profile Image"
                class="img-fluid rounded shadow-lg"
                height="auto"
                width="300px"
                src="assets/trainees--2.jpg"
                alt="Profile Image"
              />
            </div>
          </div>
          <div class="col-md-6 col-sm-12">
            <div class="about-wrapper__info load-hidden">
              <p class="about-wrapper__info-text">
                
Hallo, ik ben Tim Valks, 23 jaar oud en woonachtig in Ommel. Na het behalen van mijn master Human Movement Sciences aan de Maastricht University, heb ik een jaar lang als bewegingswetenschapper gewerkt bij NAC Breda. Gedurende deze periode was ik verantwoordelijk voor de data-analyse van het onder-21 team. Mijn passie voor het werken met data groeide gestaag, wat mij ertoe bracht te kiezen voor het traineeship van de Talent Academy van Veneficus. Hier heb ik mezelf verder ontwikkeld door middel van trainingen en praktische opdrachten, gericht op het werken met verschillende programma's zoals Power BI, SQL en Python.
<br><br>
                Mijn achtergrond in bewegingswetenschappen, gecombineerd met mijn nieuwe expertise in data-analyse, stelt mij in staat om van een abstract vraagstuk tot een goed eindresultaat te komen door mijn analytische en resultaatgerichte aanpak. Vanwege mijn bescheiden karakter observeer ik aanvankelijk alles zorgvuldig om vervolgens met een sterke en goed onderbouwde argumentatie voor resultaten te zorgen.
              <p class="about-wrapper__info-text">
                Wilt u meer over mijn achtergrond weten dan kan u hieronder mijn CV vinden.
              </p>
              <span class="d-flex mt-3">
                <a
                  rel="noreferrer"
                  target="_blank"
                  class="cta-btn cta-btn--resume"
                  href="assets/CV Tim Valks.pdf"
                >
                  Bekijk CV
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

- Elk project heeft zijn eigen `row`.
- Bij `<h3>` met class name `.project-wrapper__text-title`, voeg de project titel toe.
- Bij `<p>` met `loremp ipsum` tekst, voeg je project beschrijving toe.
- Bij `<a>` , voeg een deel van je project toe (bijvoorbeeld een deel van een dashboard).
- Optioneel bij een tweede `<a>`, voeg bijvoorbeeld de project omschrijving toe.

---

- In de `<div>` tag met class name `.project-wrapper__image`, voeg een afbeelding van het project toe bij `src` in `<img>` en voeg weer op dezelfe manier vanuit `src/assets/` dit bestand toe.
- Hieronder zie je 2 voorbeelden van projecten die zijn toegevoegd aan het voorbeeld portfolio. Waarbij het eerste project  1 `<a>` heeft en het tweede project twee `<a>`.

```html
    <!-- **** Projects Section **** -->
    <section id="projecten">
      <div class="container">
        <div class="project-wrapper">
          <h2 class="section-title dark-blue-text">Projecten</h2>

    <!-- Notice: each .row is a project -->
          <div class="row">
            <div class="col-lg-4 col-sm-12">
              <div class="project-wrapper__text load-hidden">
                <h3 class="project-wrapper__text-title">PLUS klantherkomstonderzoek</h3>
                <div>
                  <p class="mb-4">
                    Elk jaar voert de PLUS een onderzoek uit naar de herkomst van alle klanten die hun winkels bezoeken. Dit onderzoek werd gerapporteerd in PDF-formaat en was daardoor erg statisch. Het was mijn taak om dit rapport dynamisch te maken in Power BI en tegelijkertijd ervoor te zorgen dat het proces van het laden tot het implementeren van een dashboard volledig geautomatiseerd werd.
                  </p>
                </div>
                <a
                  rel="noreferrer"
                  target="_blank"
                  class="cta-btn cta-btn--hero"
                  href="assets/Portfolio.pbix"
                >
                  Bekijk dashboard
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
                      src="assets/PLUS.png"
                    />
                  </div>
                </a>
              </div>
            </div>
          </div>
          <!-- /END Project -->

          <!-- Notice: each .row is a project -->
          <div class="row">
            <div class="col-lg-4 col-sm-12">
              <div class="project-wrapper__text load-hidden">
                <h3 class="project-wrapper__text-title">Criminaliteit</h3>
                <div>
                  <p class="mb-4">
                    Vanuit Veneficus is mij aan mij gevraagd of ik een eindopdracht kon bedenken en maken die zou aansluiten op de Power Bi cursussen die trainees gaan volgen. Hiervoor heb ik van de CBS data opgehaald over de criminaliteit in Nederland. Vervolgens heb ik deze getransformeerd om er uiteindelijk verschillende dashboards mee te maken.
                  </p>
                </div>
                <a
                  rel="noreferrer"
                  target="_blank"
                  class="cta-btn cta-btn--hero"
                  href="assets/Criminaliteit.pbix"
                >
                  Zie dashboard
                </a>
                <a
                  rel="noreferrer"
                  target="_blank"
                  class="cta-btn text-color-main"
                  href="assets/Opdracht_Criminaliteit_in_Nederland.pdf"
                >
                  Zie opdracht
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
                      src="assets/Criminaliteit.png"
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
- Bij `<li class="cursus-item">`, vervang de huidige cursus namen met de cursussen die je zelf hebt gevolgd.
- Verwijder de rijen die je niet gebruikt of voeg rijen toe als je meer cursussen hebt gevolgd.

```html 
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
```

### (5) Tools section
- Vervang/ voeg tools toe, als je tools gaat vervangen dan moet je de afbeelding bij `<img>` vervangen en de naam na `width=20px>`

```html 
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
```
### (6) Contact Section

- Bij `<p>` met class name `.contact-wrapper__text`, voeg je emailadres en telefoonnummer toe quote toe.
- Bij `<a>` , voeg je emailadres toe bij `href` 

```html
    <!-- **** Contact Section **** -->
    <section id="contact">
      <div class="container">
        <h2 class="section-title">Contact</h2>
        <div class="contact-wrapper load-hidden">
          <p class="contact-wrapper__text">Email: tim.valks@veneficus.nl <br>
        Telefoonnummer: +31639123801</p>
          <a
            rel="noreferrer"
            target="_blank"
            class="cta-btn cta-btn--resume"
            href="mailto:tim.valks@veneficus.nl"
            >Call to Action</a
          >
        </div>
      </div>
    </section>
    <!-- /END Contact Section -->
```

### (7) Footer Section

- Voeg je Social media URL toe aan elk `href` van `<a>`.
- Als je andere social media accounts wil toevoegen dan Twitter, Linkedin or GitHub, ga dan naar [Font Awesome Icons](https://fontawesome.com/v4.7.0/icons/) en zoek naar de logo class names..
- Je kan zoveel `<a>` toevoegen en verwijderen als je wil.

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

De achtergrond kleur is nu de kleur van Veneficus. Deze zal behouden moeten worden tenzij anders besproken met Veneficus.

Ga naar `/src/sass/abstracts/_variables.scss` en verander de kleurcode van `$main-color` en `$secondary-color` met de HEX kleurcode die je wil.


```scss
// Default values
$main-color: #0aaf68;
$secondary-color: #0aaf68;
```

---

## Deployment 📦

Als je klaar ben met je setup. Dan moet je je portfolio online gaan zetten!

Ik heb hiervoor [Netlify](https://netlify.com) gebruikt, dit werkt heel makkelijk en voor de hand liggend.

## Others versions 👥

[Gatsby Simplefolio](https://github.com/cobiwave/gatsby-simplefolio) by [Jacobo Martinez](https://github.com/cobiwave)\
[Ember.js Simplefolio](https://github.com/sernadesigns/simplefolio-ember) by [Michael Serna](https://github.com/sernadesigns)


## License 📄

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

