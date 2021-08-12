#

![Plantcare][logo-plantcare]

**LETS GROW UP TOGETHER**. Helping to maintain and to improve your cute green place taking care of your plants remotely.

## Getting started

### Prerequisites

The setup steps expect following tools installed on the system.

- Github
- Ruby [2.7.4](https://github.com/lmbautista/plantcare/blob/master/.ruby-version#L1)
- Rails [6.1.3.2](https://github.com/lmbautista/plantcare/blob/master/Gemfile#L6)

### 1. Clone the repository

```bash
git clone git@github.com:organization/project-name.git
```

### 2. Create database.yml file

Export env variables existing in `config/database.yml`

```bash
export MYSQL_HOST=your_mysql_host \
export MYSQL_USER=your_mysql_user \
export MYSQL_ROOT_PASSWORD=your_mysql_root_password
```

### 3. Create and setup the database

Run the following commands to create and setup the database.

```ruby
bundle exec rake db:create
bundle exec rake db:setup
```

### 4. Clone the Plantcare API backend repository

```bash
# Currently private
```

[logo-plantcare]: https://user-images.githubusercontent.com/6224703/100526618-de707980-31ca-11eb-9d4a-41606bb73709.png "Plantcare"