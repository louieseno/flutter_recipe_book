## Client Setup

## Installed in your system.

- [`flutter`](https://docs.flutter.dev/get-started/install) installed in your machine.

## Dependencies in your `pubspec.yaml` file.

- [`dio`](https://pub.dev/packages/dio)
- [`get`](https://pub.dev/packages/get)
- [`cached_network_image`](https://pub.dev/packages/cached_network_image)
- [`shared_preferences`](https://pub.dev/packages/shared_preferences)
- [`envied`](https://pub.dev/packages/envied)
- [`envied_generator`](https://pub.dev/packages/envied_generator)
- [`build_runner`](https://pub.dev/packages/build_runner)

## Install Flutter dependencies by running.

```bash
   cd <PROJECT_FOLDER>/client
   flutter pub get
```

## Set up your `.env` file

For this project we are using [`Edamam API`](https://rapidapi.com/edamam/api/recipe-search-and-diet) for fetching recipies online.

:warning: Note: `lib/env/` configuration folder is not ignored in the version control to allow you from testing and use my API keys with a hard limit of **1000 request/month**.

If you wish to use your own API Key after subscribing to `Edamam API`.

- Copy `.env.example` into `.env`. Your `.env` file should be at the project root `(client)` like this:

```
X-RapidAPI-Key=""
X-RapidAPI-Host=""
```

- Then generate `env.g.dart` file by running:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

If you will encounter any problem like file is not updating, try troubleshooting by:

- Cleaning all the generated files and purge the code-gen cache and re-run the command after to generate.

```bash
flutter pub run build_runner clean
```

- Delete the `env.g.dart` file and re-run the command to generate.

## Architecture

This app is architectured based on Uncle Bob's Clean Archutecture. The main focus of the architecture is separation of concerns and scalability. It consists of four main modules: `Presenter`, `Domain`, `Data`, and `Device`.

- **Presenter** -
  Our UI components, basically everything that it’s a widget or a widget’s controller.

- **Domain** -
  Defines the business logic and entities of the application.

  1. **Entities**

  - Enterprise-wide business rules
  - Made up of classes that can contain methods
  - Business objects of the application
  - Used application-wide
  - Least likely to change when something in the application changes

  2. **Usecases**

  - Application-specific business rules
  - Encapsulate all the usecases of the application
  - Orchestrate the flow of data throughout the app
  - Should not be affected by any UI changes whatsoever
  - Might change if the functionality and flow of application change

  3. **Repositories**

  - Abstract classes that define the expected functionality of outer layers
  - Are not aware of outer layers, simply define expected functionality
  - E.g. The Login usecase expects a Repository that has login functionality
  - Passed to Usecases from outer layers

- **Data** -
  Represents the data-layer of the application. The Data module, which is a part of the outermost layer, is responsible for data retrieval. This can be in the form of API calls to a server, a local database, or even both.

  1. **Repositories**

  - Every Repository should implement Repository from the Domain layer.
  - Responsible for any API calls and high-level data manipulation

- **Device** -
  Part of the outermost layer, Device communicates directly with the platform i.e. Android and iOS. Device is responsible for Native functionality such as GPS and other functionality present within the platform itself like the filesystem. Device calls all Native APIs.

## State Management

This app is using Getx for overseeing states, make routing, and performing dependency injection.

Basing on our architecture we are attaching a controller for each of our screens inside in our Presenter Module to provide a reactive update for our dependent widgets.
