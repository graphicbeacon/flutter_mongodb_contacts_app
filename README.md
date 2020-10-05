# Flutter and MongoDB Mini-Course solution | Contacts List App

This is the solution for the [mini-course](https://youtu.be/juKDXPk7kU4) on YouTube. This runs for Flutter Mobile and Web.

## Running the server

1. Set up a Project and Cluster on [MongoDb Cloud](https://cloud.mongodb.com)
2. Amend **server/lib/server.dart** line 7 with the correct URI string.
3. Launch server by running the commands below:
```bash
$ cd server
$ dart bin/main.dart
``` 

## Running the client

1. CD into the client folder
2. Enter `flutter run` in the Terminal to launch the project in your emulator. Make sure you have one connected.

## Build the web version

1. CD into **client** directory
2. Run `flutter build web`
3. Install the `serve` package to launch the built artifact
```bash
$ pub global activate serve
$ cd build/web
$ serve
```

Enjoy💙😊