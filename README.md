Construct composable, structured, PostgreSQL queries in plain Ruby.

## Configure database connection

In a configuration file, named `config.rb` for example:

```ruby
module Queries
  Pgsnap.set_configuration do |config|
    config.dbname = 'your_db_name_here'
  end

  class Config < Pgsnap::Query; end
end
```

Inherit the configuration file in your query, named `query_for_one.rb`
for example:

```ruby
module Queries
  class Hello < Queries::Config
    def select_list
      select_list_item %('hello'), :greeting
    end
  end
end
```

Try it out in the console:

```ruby
pry(main)> q = Queries::Hello.new
pry(main)> q.result
#=> ["hello"]
pry(main)> q.columns
#=> [:greeting]
pry(main)> q.json
#=> [{"greeting"=>"hello"}]
```
