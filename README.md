# capistrano-kemal

This is a Capistrano v3 plugin that integrates Kemal tasks into capistrano deployment scripts to ease deployment.

## Installation

Add `capistrano-kemal` to your `Gemfile`.

```ruby
gem 'capistrano-kemal' 
```

Load `capistrano-kemal` in your `Capfile`.


```ruby
require 'capistrano/kemal'
```

That's it.

## Example

Here's an example 

```ruby
set :application, 'your-app'
set :repo_url, 'git@github.com:username/your-app.git'
set :deploy_to, '/home/user/apps/your-app/'
set :kemal_env, 'production'
set :kemal_file, 'src/app.cr' # main source file
set :kemal_app, 'app' # compiled binary name (usually filename of main source file without `.cr` extension)

after 'deploy:publishing', 'kemal:restart'
```
 
## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/bitfex/capistrano-kemal

