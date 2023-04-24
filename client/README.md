## Client

### Client Setup

- Installed in your system.
  [`flutter`](https://docs.flutter.dev/get-started/install) installed in your machine.
- Installed in your `pubspec.yaml` file.
  [`dio`](https://pub.dev/packages/dio)
  [`get`](https://pub.dev/packages/get)
  [`cached_network_image`](https://pub.dev/packages/cached_network_image)
  [`shared_preferences`](https://pub.dev/packages/shared_preferences)

Install Flutter dependencies by running.

```bash
   cd <PROJECT_FOLDER>/client
   flutter pub get
```

This folder contains your Flutter application.

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
