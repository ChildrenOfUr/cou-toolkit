# coU toolkit
An SDK for local development on the official Children of Ur game.

# This SDK is unstable, use at your own risk.

## Setup
To start using the SDK, run `pub get` to pull in dependencies.
You also need the proper `API_KEYS.dart` in the `keys/auth` and `keys/server` directories.
Once you've done that, you can run:

`pub run cou:setup`

to clone the project files and generate your workspaces.

Within these workspaces, you can `checkout` branches or create new ones. There are three workspaces currently:

1. sources/client
2. sources/server
3. sources/auth

## Use
You can fire up both servers, as well as serve the client by running:

`pub run cou:serve`

opening `localhost:8080` in a browser should load up the game.
