# tmdb_client_kobe

A simple Client to show upcoming movies from The Movie Database, Go into movies details (poster, backdrop images, genres, release date, overview) and Search the database for movies and obtain the same infos if any.

## third party libraries

In this project I've decided to use and why:

- Provider: State Managemnet. It's the google's recomendation, and it's really easy to go with.
- Get_it: Dependency Injection. With Provider ^3.0 it has became possible to make with only Provider an almost as simple dependecy injection as the one made with Get it!, but for the simplicity, and my familiarity with Get It! I've decided to keep using it, at least for now, for productivity matters.
- Sentry: I've connect the sentry client to keep track of issues and error that might happen.
- AutoSizeText: Simple library to help rescaling text widgets automaticaly, used here also for productivity matters.
- FloatingSearchBar: Simple floating search bar almost out of the box.

## notes & possible issues

- The project was not tested in IOS simply for the fact that I don't have any in my posetion at the time of development. Maybe it will be necessary a small configuration to give network permission to the app in order to render the network images.
- As for the time of development I didn't limit the size of the images and therefore the amount of bites downloaded for every image, so the OS could take some actions against the app considering it's behaviour suspicius and kill it.
