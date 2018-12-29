Construct composable, structured, PostgreSQL queries in plain Ruby.

## Configure database connection

In a configuration file, named `queries/config.rb` for example:

<strong>In the case of a pure Ruby project</strong>

```ruby
module Queries
  Pgsnap.set_configuration do |config|
    config.dbname = 'your_db_name_here'
  end

  class Config < Pgsnap::Query; end
end
```

<strong>In the case of a Ruby on Rails project</strong> (automatically switches database based on the `RAILS_ENV` value)

```ruby
module Queries
  Pgsnap.set_configuration do |config|
    config.dbname = ActiveRecord::Base.connection.current_database
  end

  class Config < Pgsnap::Query; end
end
```

Inherit from the configuration file in your query subclass, named `queries/query_for_one.rb`:

```ruby
module Queries
  class Hello < Queries::Config
    def select_list
      column %('hello'), :greeting
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

Let's also try querying the base tables in your database, in a file named `queries/base_tables.rb`:

```ruby
module Queries
  class BaseTables < Queries::Config
    def select_list
      literal %(
        SELECT table_name
        FROM information_schema.tables
        WHERE table_schema='public' AND table_type='BASE TABLE'
      )
    end
  end
end
```

Try it out in the console:

```ruby
pry(main)> q = Queries::BaseTables.new
pry(main)> q.result
#=> [["schema_migrations"], ["ar_internal_metadata"], ["users"], ["questions"],["learning_units"]]
```
