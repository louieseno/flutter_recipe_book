## Flutter Recipe Book

A cookbook app where you can bookmark your own recipes found online using Edamam API.

### Pre-requisites

Please check and follow the following instructions in setting up your environment.

- [`client setup`](https://github.com/louieseno/flutter_recipe_book/blob/client/client/README.md)
- [`server setup`](https://github.com/louieseno/flutter_recipe_book/blob/client/server/README.md)

### Run the App

Once you've installed the project and system dependencies for both client and server environments, run the following commands to test the app.

1.  Open terminal and start your local backend server by running

```bash
   cd <PROJECT_FOLDER>/server
   npm run server-json
```

`json-server` will provide a ready to use endpoint base on your `db.json` file which will act as its storage for your bookmark recipes.

```
Resources
http://localhost:3000/recipes
```

2.  Open a simulator, emulator, or connect to an actual device to run your Flutter Application.

On another terminal start flutter by running this command.

```bash
   cd <PROJECT_FOLDER>/client
   flutter run
```

## :bangbang: Take Note

Change `localhost` to actual IP address of your system when running to an actual device or Android Emulator.

Update the following files:

1. `<PROJECT_FOLDER>/server/package.json`

```
   "server-json": "json-server --watch db.json --port 3000 -H localhost"
```

re-run command `npm run server-json`

2. `<PROJECT_FOLDER>/client/lib/services/json_server.dart`

```
const baseURL = 'http://localhost:3000';
```

re-run command `flutter run` or `hot restart`
