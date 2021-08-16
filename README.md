# Demo

## Requirements

Simple requirements render happy developers! The only requirements for this quickstart to run are `Docker` and `Compose`! 🐳

## Plug and Play

This demo should be **almost** a _plug and play_ experience. The "**almost**" part of it will be clear in a second!

### Local usage

To use this repository locally, you should first create a `.env` file and fill the `FINTOC_PUBLIC_KEY` variable with your Fintoc public key!

```sh
cp .env.example .env
nano .env  # or your favorite editor
```

Then, you should build the containers:

```sh
docker-compose build
```

After that, create and migrate the database:

```sh
docker-compose run web rails db:create db:migrate
```

Now, start the application:

```sh
docker-compose up
```

And this is the _tricky_ part. Because you are trying to test a local server using callback URLs, the application uses `ngrok` to expose the webhook endpoints to the internet. This means that, once you start the server, you should see a log line on your console that should look like this:


```sh
ngrok_1 | t=2021-07-15T14:53:04+0000 lvl=info msg="started tunnel" obj=tunnels name=command_line addr=http://web:3000 url=https://d4d13f905941.ngrok.io
```

Notice that the `url` attribute of this line will contain a URL that should look like `https://<random-string>.ngrok.io`. This `<random-string>` will change every time that you start the server, but we need to pass that URL to direct our webhooks on development without restarting the server, thus changing the URL!

Once the server starts and you find the `ngrok` URL, you should edit the file `app/javascript/components/WithModal.vue`. On that file, you should see a line that reads `'https://xxxxxxxxxxxx.ngrok.io'`. Replace the `xxxxxxxxxxxx` portion of the string with your `<random-string>`. After saving the file, the app should _hot-reload_, and you're good to go!

You should be able to enter `http://localhost:3000` and see your application running!

#### Production-like setup

Because of how Docker works, the previous setup will be **very** useful for developing the application (volumes mounted on the developing folder to actualize changes on the container, HMR, etc). Nevertheless, sometimes you need to check that, for example, your static assets **will** get shown on your production server. Because with the regular usage guide we are introducing **a lot** of dev tools specifically for improving our development workflow, some errors might get _muffled_. That's why I included a _production-like_ setup on this repository, so that you can test **exactly** what your production setup will be running. **Note**: because of the `ngrok` situation and because that this setup **does not reload itself without stopping the containers, re-building and then starting them again**, there is no way to test the webhooks. You should only use this setup to test configurations and stuff like that.

To use the _production-like_ setup locally, you should first create a `.env` file and fill the `FINTOC_PUBLIC_KEY` variable with your Fintoc public key!

```sh
cp .env.example .env
nano .env  # or your favorite editor
```

Then, you should build the containers:

```sh
docker-compose -f docker-compose.production.yml build
```

After that, create and migrate the database:

```sh
docker-compose -f docker-compose.production.yml run web rails db:create db:migrate
```

Now, start the application:

```sh
docker-compose -f docker-compose.production.yml up
```

You should be able to enter `http://localhost:3000` and see a production version of your application!

### Deploying to Heroku

To deploy the application to Heroku, the steps are as follows:

First, create a new Heroku app:

```sh
heroku create
```

This should show on the console the name of the newly created application. From now on, `<app-name>` should be replaced with that name.

Then, add the `heroku-postgresql` addon to the Heroku app:

```sh
heroku addons:create -a <app-name> heroku-postgresql:hobby-dev
```

This command will add the **free** basic `heroku-postgresql` addon to your app (you can upgrade this later if you desire).

Next, build the image and push it to Container Registry:

```sh
heroku container:push -a <app-name> web
```

Now, release the image to your app:

```sh
heroku container:release -a <app-name> web
```

After having the image deployed, run the database migrations:

```sh
heroku run -a <app-name> rails db:migrate
```

Finally, make sure to fill the environment on the heroku dashboard:

- `DATABASE_URL`: The URL of the database that the application will use. This variable should already be filled, because of the step where you created a database on your Heroku application.
- `FINTOC_PUBLIC_KEY`: The public key of the account being used to access to the Fintoc API.
- `FINTOC_SECRET_KEY`: The secret key of the account being used to access to the Fintoc API.
- `SECRET_KEY_BASE`: Used by Rails for randomized operations. Set it to a random string.
- `RAILS_SERVE_STATIC_FILES`: A flag that tells Rails to serve its static files. Any value would suffice, but I would recommend setting it to `true` for consistency.
- `RAILS_ENV`: The environment for the Rails runtime. Set it to `production`.
- `NODE_ENV`: The environment for the Node runtime. Set it to `production`.

You should now be able to use `https://<app-name>.herokuapp.com` with the deployed application!
