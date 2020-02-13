## Inspiration
As college students, we are often attracted to events with free food and swag. Clubs, Hackathons, and teams often use free stuff as a way of advertising and bringing people in, however the word might not get out. This app is meant to simplify the entire process for everyone. This app can not only be used for a fun topic such as free food for college kids but also more serious, impactful events such as emergencies. Being able to upload images on a pinpoint on a map and allowing emergency personnel to respond based on the geolocation pins and images could be very important. This app could also be adapted to help people with food insecurity find not only food, but also shelter and a place to sleep.
## What it does
A club or team can create a location based post of their event. This then creates a pin on the map with a custom icon that shows the type of free things involved (food, swag, pizza, etc). The club/team can include things like a description and an image of the location which allows for users to view more information. 
Someone who is interested in becoming more active in the community and is also looking for free pizza or food can then see nearby events and are able to learn more.
## How we built it
We built this app using various modern technologies. We used Flutter by Google for Cross Platform Mobile App development. We used the Google Maps API to do all the map related tasks and to display the map field. We used Firebase Firestore and Firebase Storage as our noSQL database and image buckets respectively. 
## Challenges we ran into
We had a bit of trouble in the beginning with the many dependencies and versions of the different components we needed for the project. With all the various tools such as Google Maps, Firestore, and Firebase at various stages of development for a relatively new Mobile Dev Platform like Flutter, we had trouble with getting the right versions so that there we no dependency clashes. 
## Accomplishments that we are proud of
We are really proud of all the features we were able to add in a short period of time. We were able to work with user location data and process that data to find all the nearby freebies and we are able to display them with custom markers for the different types of freebeez.
## What we learned
We learned a lot about Flutter and GPS/location processing. Taking that information and being able to process and upload and read from the Firestore database was a bit difficult at first, but once the kinks were worked out, it was an extremely easy way to manage hundreds of entries.
We also learned that creating a proper structure in the beginning in terms of not only code, but also project merge structure, would go a long way in making sure that everything ran smoothly. 
## What's next for FreeBeez
This project could take many different paths. We have implemented the technology for geolocation based image tracking and crowdsourcing. We are able to adapt the app to fit other scenarios such as helping combat food and shelter insecurities as well as emergency response.

