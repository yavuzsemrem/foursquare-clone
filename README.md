<h1 align="center">
  <br>
  <a href="#"><img src="https://raw.githubusercontent.com/amitmerchant1990/electron-markdownify/master/app/img/markdownify.png" alt="Foursquare" width="200"></a>
  <br>
  Foursquare Clone
  <br>
</h1>

<h4 align="center">A location-based app where users can sign in, add new places, and view locations on a map, built with Swift and Back4App.</h4>

<div>
<p align="center">  <a href="https://www.instagram.com/_yavuzsemrem/" target="_blank" rel="noreferrer" style="text-decoration: none;"><img src="https://skillicons.dev/icons?i=instagram" width="35" height="35";/></a>  <a href="https://www.linkedin.com/in/yavuz-selim-emrem-65baa0273/" target="_blank" rel="noreferrer" style="text-decoration: none;"><img src="https://cdn.iconscout.com/icon/free/png-512/free-linkedin-2752135-2284952.png?f=avif&w=512" width="35" height="35" /></a>  <a href="https://x.com/s3limm06" target="_blank" rel="noreferrer" style="text-decoration: none;"><img src="https://static.vecteezy.com/system/resources/previews/042/148/611/non_2x/new-twitter-x-logo-twitter-icon-x-social-media-icon-free-png.png" width="35" height="35" /></a>  <a href="mailto:selimemrem@gmail.com" target="_blank" rel="noreferrer" style="text-decoration: none;"><img src="https://upload.wikimedia.org/wikipedia/commons/7/7e/Gmail_icon_%282020%29.svg" width="35" height= "35" /></a>  <a href="https://open.spotify.com/user/00a5n7i8o5xwfdbq9kz6i8wra?si=36cfe13b9bbb4b85" target="_blank" rel="noreferrer" style="text-decoration: none;"><img src="https://cdn3.emoji.gg/emojis/SpotifyLogo.png" width="35" height="35" /></a>  <a href="https://steamcommunity.com/profiles/76561199496950614/" target="_blank" rel="noreferrer" style="text-decoration: none;"><img src="https://cdn.freebiesupply.com/images/large/2x/steam-logo-transparent.png" width="35" height="35" /></a>  <a href="https://discord.com/users/s3limm#1529" target="_blank" rel="noreferrer" style="text-decoration: none;"><img src="https://raw.githubusercontent.com/danielcranney/readme-generator/main/public/icons/socials/discord.svg" width="35" height="35" /></a>  </p>
</div>

<p align="center">
  <a href="#key-features">Key Features</a> •
  <a href="#how-to-use">How To Use</a> •
  <a href="#technologies-used">Technologies Used</a> •
  <a href="#documentation">Documentation</a> •
  <a href="#license">License</a>
</p>

![screenshot](https://raw.githubusercontent.com/amitmerchant1990/electron-markdownify/master/app/img/markdownify.gif)

## Key Features

- **User authentication** via **Sign In** and **Sign Up** options.
- Users can add new places with details like:
  - Name
  - Type
  - Image
  - Location (selected on the map)
- **CRUD operations** are performed using **Parse**.
- Places are displayed in a list using **TableView**.
- Click on a place to see:
  - Details entered by the user
  - Location on the map
- Open the place in **Apple Maps** to generate a route from your current location.
- Cloud database support via **Back4App**.
- Map integration using **MapKit**.
- User session management using **UserDefaults**.

## How To Use

To run this project on your local machine, you'll need to have **Xcode** installed. Then, follow these steps:

```bash
# Clone this repository
$ git clone https://github.com/yourusername/foursquare-clone

# Go into the repository
$ cd foursquare-clone

# Open the project in Xcode
$ open FoursquareClone.xcodeproj

# Run the app
$ xcodebuild

````

## Technologies Used

- <b>Swift</b> - Main programming language.

- <b>Parse Cloud Server</b> - For handling backend services.

- <b>Back4App Cloud Database</b> - To store places and user data.

- <b>UserDefaults</b> - To manage user session.

- <b>TableView</b> - For listing places on the main screen.

- <b>MapKit</b> - For displaying and interacting with maps.

- <b>UIKit</b> - For UI components.

- <b>CocoaPods</b> - For managing dependencies.

- <b>Swift Package Manager</b> - For adding and managing Swift libraries.

## Documentation

- [Parse iOS Guide](https://docs.parseplatform.org/ios/guide/#images) - Official guide on how to integrate Parse in iOS apps.
- [Parse-Swift GitHub Repository](https://github.com/parse-community/Parse-Swift) - Swift SDK for Parse.
- [Back4App Documentation](https://www.back4app.com/docs) - Comprehensive documentation for using Back4App.
- [Back4App Dashboard](https://backend.back4app.com/apps/) - Access your Back4App dashboard to manage your app.


## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
