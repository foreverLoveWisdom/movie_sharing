## Milestone 1: Project Setup

- [x] Create a new Ruby on Rails project
- [x] Initialize a Git repository for version control
- [x] Set up user authentication using Devise gem
- [x] Create a landing page with login and register buttons

## Milestone 2: Share Movie Feature & Show Movie List Feature

- [x] Create a "Share a movie" button that is only visible when user is signed in
- [x] Create a form for sharing a YouTube movie
- [x] Save the shared movie to the database
- [x] Display a success message after a movie has been shared
- [x] Guest and registered users can see a list of all shared movies
- [] Add pagination to the movie list page
- [x] Make the movie list page responsive
- [x] Write integration tests for sharing and viewing movies
- [x] Write unit tests for models

## Milestone 3: Finalization and Submission

- [x] Perform final testing to ensure that all features are working as expected
- [x] Update the README file with instructions on how to run the project locally
- [x] Upload the source code to GitHub
- [x] Submit the project to the assigned link

## Prerequisites

- Before setting up the project, please ensure that you have the following software installed on your computer:

  - Ruby version 3.2.1
  - Rails version 7.0.4.3
  - PostgreSQL database server
  - Git version control system

## Installation

- To install the project, follow these steps:

  1. Clone the project repository to your local machine using the Git command below:
     `git clone <repository-url>`

  - Replace <repository-url> with the URL of the project repository.

  2. Navigate to the project's root directory:
     `cd <project-directory>`

  - Replace <project-directory> with the name of the project directory.

  3. Install the required gems by running the following command:
     `bundle install`

## Database Setup

- The project uses PostgreSQL as the database for Active Record. To set up the database, follow these steps:

1. Log in to your PostgreSQL server using the psql command:
   `psql postgres`

2. Create a new user and database for the project:

```sql
CREATE ROLE <username> WITH LOGIN PASSWORD '<password>';
CREATE DATABASE <database-name> OWNER <username>;
```

- Replace <username> with a username of your choice, <password> with a password of your choice, and <database-name> with a name of your choice for the project database.

3. Grant all privileges to the new user on the new database:
   `GRANT ALL PRIVILEGES ON DATABASE <database-name> TO <username>;`

4. Exit the psql command-line interface by running the command:
   `\q`

5. Create the config/database.yml file with the appropriate database configuration settings for your PostgreSQL server:

```yml
default: &default
adapter: postgresql
encoding: unicode
host: <host>
username: <username>
password: <password>
database: <database-name>
pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
timeout: 5000

development:
  <<: *default

test:
  <<: *default
  database: <test-database-name>
```

- Replace <host> with the hostname of your PostgreSQL server, <username> and <password> with the username and password you created in step 2, <database-name> with the name of the project database you created in step 2, and <test-database-name> with a name of your choice for the test database.

6. Create the development and test databases by running the following commands:

```
rails db:create
rails db:create RAILS_ENV=test
```

7. Run the database migrations to create the necessary database tables:

```
rails db:migrate
rails db:migrate RAILS_ENV=test
```

## Running the Application

- To run the Ruby on Rails application locally, follow these steps:

1. In the project directory, start the Puma web server by running the following command:
   `rails server`

2. Open your web browser and navigate to http://localhost:3000/ to view the application.

## Running the Tests

- To run the tests for the project, follow these steps:
  `bundle exec rspec`
