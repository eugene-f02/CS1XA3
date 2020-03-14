# CS 1XA3 Project02 - fedorivy


## Overview

This webpage is **Eugene Fedoriv**'s custom CV.
It includes information about me such as education, work experience, technical projects, skills, awards and etc.   

Independently developed:  
* **HTML** file for this website
* Entire **CSS** design
* **JavaScript** features and animations utilizing **jQuery**
 
## Custom Javascript Code Description:

* The upper part of the navigation bar that includes my name and contact information gets hidden when you scroll down the page (*anywhere below the halfway point(approx.) of the **Welcome** section*). This allows to display and focus more on the content of the CV as opposed to the space-consuming section of the navigation bar.

* Hovering the mouse cursor over social media icons (*i.e Facebook, LinkedIn, etc*) located in the upper part of the navigation bar creates an effect of **highlighting** that specific icon by adding a border around the image.  

* Hovering the mouse cursor over CV categories (*i.e About Me, Education, Skills, etc.*) located in the lower part of the navigation bar creates an effect of **highlighting** that specific category in the navigation bar by changing the background colour of the circle of that CV category.  

* Clicking onto the CV categories (*i.e About Me, Education, Skills, etc.*) located in the lower part of the navigation bar will bring you to the corresponding section of the CV (*using animated scroll down*). 

* Clicking onto the golden circle with an arrow **^** located in the lower part of the navigation bar will bring you to the top of the page. 

* When you first enter **"About Me"** section of my CV, the three bars associated with each of the languages I speak will be animated (*i.e. increasing width of the bars*), indicating my level of proficiency of each of the languages

* When you first enter **"Education"** section of my CV, the progress bar indicating how far I'm from graduating will be animated in the way that it grows from 0 up until almost the end of the first year. In addition, the circle containing the "1st Year" text will get an animation of the growing border.

* Hovering the mouse cursor over **McMaster image** located in the **"Education"** section of my CV, will result in displaying the university's location underneath the image.  

* When you first enter **"Skills"** section of my CV, the skills from all of the four categories will fade in one by one retaining colour ranging from **red**(*i.e. most familiar with*) to **green**(*i.e. least familiar with*). When the 'fade in' stage is over, a second after that, all of the skills change their colour to black. However, if you hover over a specific skill, it will change its colour to one of the **red** - **green** gradient colour that was associated with it during the 'fade in' stage.  

* **Technical Projects** section includes a button next to each of the projects. When you click on either of the buttons, a gif image associated with that project toggles between being displayed and hidden and text of the button toggles between **+** and **-**. In addition, hovering over a button will **highlight** it.  

* When you first enter either of the following section: **Work Experience**, **Volunteering**, or **Extracurriculars**
 the appropriate image associated with that section will show up.
 
* **Awards** section includes a button next to each of the awards, and clicking on those buttons will result in displaying/hiding additional information about the award. **Highlighting** effect and toggle between **+** and **-** is implemented in a similar way to the buttons in the **Technical Projects** section.


## References
- CSS attr() and data attribute - [Link](https://css-tricks.com/css-attr-function-got-nothin-custom-properties/)
- Horizontal divider with orange cirlce in the middle that seprates CV sections was taken from - [Link](https://codepen.io/Oddgson/pen/VPrYbv)
- CSS linear-gradient() Function - [Link](https://www.w3schools.com/cssref/func_linear-gradient.asp)
- jQuery resize() Method - [Link](https://www.w3schools.com/jquery/event_resize.asp)
- CSS Viewport Units - [Link](https://www.sitepoint.com/css-viewport-units-quick-start/)
- vw calculator - [Link](https://codepen.io/lakshmiR/pen/YGWXoo)
- setTimeout() Method - [Link](https://www.w3schools.com/jsref/met_win_settimeout.asp)
- jQuery on() Method -[Link](https://www.w3schools.com/jquery/event_on.asp)

