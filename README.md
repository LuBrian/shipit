# Ship.it

**Getting Started (to run on your localhost):**

1. `bundle install`
2. `shotgun -p 3000 -o 0.0.0.0`
3. Visit `http://localhost:3000/` in your browser

**Online access:** http://lhlshipit.herokuapp.com/

**Goal:**
the app enables customers to add packages and track them when shipped. It allows drivers to accept a package from a list of available packages. A driver is responsible for updating the state of his packages. 

**Context:** app done in four days in a team of four for the midterm project at LighthouseLabs

**Features:**
- Customers:
  - Log in/sign up (with profile picture)
  - Upload of a new package
  - Dashboard with list of packages
  - Package detail page with map showing current location

- Drivers:
  - Log in/sign up (with profile picture)
  - List of non-accepted packages
  - Own list of accepted packages with a map showing their locations as well as the driver's
  - Package detail page with fare indications

A package has four states:
- ready for pick up: a customer has uploaded a package ready to be picked up
- accepted: a driver has accepted to pick up a package
- picked: a driver has picked up a package
- delivered: a driver has delivered a package
Every time a state is change, the location of the package is saved and uploaded into the database

**Languages used:**
- Ruby
- HTML5
- CSS3
- Javascript

**Frameworks used:**
- backend => Activerecord and Sinatra
- frontend => Materializecss

**APIs used:**
- Google map API
- Google distance matrix API
- Google geocoding API
- Google directions API
- Web geolocalization API

