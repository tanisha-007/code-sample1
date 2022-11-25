# Scale
This system follows a lot of the same logic as the full system but with less complexity and less depth.

## Getting the system up an running
System up and running through calling `bin/setup`.
If unable to run system, there are a few tasks that have to be completed first, documented in the checklist below.

- [ ] Make sure you have the right Ruby version installed, 2.6.6
  * If you're using rvm or rbenv you can usually run their install command and they will find the version from the `.ruby-version` file.
- [ ] Make sure you have the right Node version installed, v12.18.4
  * If you're using nvm you can usually install the version by running `nvm install` which fetches version from `.nvmrc`.
  * You might also need to run `nvm use` or similar.
- [ ] Install bundler if needed
  * Running the following usually does the trick `gem install bundler --conservative`.
  * rbenv has a handy `rbenv shell [version]` command that usually fixes permission issues.
- [ ] Install Yarn if not already available.
  * Most easily done by running `npm install --global yarn`
- [ ] Install gems with bundler
  * Easily handled by running: `bin/bundle install`.
- [ ] Install packages through yarn
  * This is done through running `bin/yarn install`.
  * You might need to run `nvm use` or similar if you're using a version manager.
- [ ] Create and migrate the DB
  * Can be done through running `bin/rails db:setup`.
  * Alternatively, `bin/rails db:create`, `bin/rails db:migrate`
- [ ] Run the server!
  * You're so close to the goal, just run `bin/rails s` and we're off!

## Seeding
Seeding data is handled through seedbank.
The base data can be seeded by running `bin/rails db:seed:development:base`.
This seed file is also included automatically when running `bin/rails db:reset`.

## Linting with eslint and rubocop
All Seably code is checked for linting issues automatically on our CI machine.
To make sure the code will pass future linting, the following tools exist.

**To lint the ruby code run:**
```
bin/bundle exec rubocop
```
Add flag `-a` to fix the linting automatically.

**To lint the JS code run:**
```
bin/yarn eslint [FOLDER]
```
Add `--fix` flag to fix the linting automatically.

## Tests
The repo contains some of the tests the full system does, but it's not as extensively tested. For instance we've only included some unit tests for the models here, and not a full suite. Other libraries such as RSpec, has been skipped completely.

To run the tests:
```
bin/rails test
```

### Integration tests
Integration tests are written using Cypress.js, and are placed in the `/cypress/integration/` folder.
Seeding is done through `db:seed`-commands and require new seed files to be created if specific seeding is needed.

To run the tests:
```
bin/yarn cypress
```

**OR** if you're in headless environment like WSL, a VM or similar you can run:
```
bin/yarn cypress:ci
```
# scale-app
