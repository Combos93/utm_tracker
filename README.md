# UtmTracker

This gem allow to save UTM tags into your Rails app. UtmTracker allows you to save in the user object with which advertisement he was registered.

## Requirements

- Ruby 2.7.1
- Rails 6.1.x

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'utm_tracker'
```

And then execute:

    $ bundle install

## Usage for Rails

1. You need to generate Rails migration and add utm_data into your User model for UTM-tags:

$ rails g migration add_utm_data_to_users utm_data:jsonb

and add not null and default modificators into rails migrations:
```ruby
def change
  add_column :users, :utm_data, :jsonb, null: false, default: {}
end
```

and then:

$ rails db:migrate

2. Prepare link into user registration controller:

$ https://example.com?utm[source]=google&utm[medium]=cpc&utm[campaign]=testcampaign&utm[content]={adgroupid}&utm[term]={keyword}

3. Add into ApplicationController next helper for save utm_tags into current_user session:
```ruby
class ApplicationController < ActionController::Base
  include UtmTracker::Helper
end
```

4. After that, you can use callback into your controllers for get utm data in current user session:
```ruby
before_action :get_utm_data
```

Add this callback where you plan to receive advertising traffic.

5. Into user registration controller add UtmTracker client after save user and put user object and session[:utm]:
```ruby
@utm = UtmTracker::Client.new(@user, session[:utm])
@utm.call
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/alexlev1/utm_tracker.

