require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :default => :test

desc 'Set up development database'
task :db_setup do
  cmd = 'dropdb pgsnap'
  p cmd
  `#{cmd}`

  cmd = 'createdb pgsnap'
  p cmd
  `#{cmd}`

  cmd = <<~SQL
    psql -d pgsnap -c "
      CREATE TABLE car_brands(
        id BIGSERIAL PRIMARY KEY,
        name VARCHAR NOT NULL
      )
    "
  SQL
  p cmd
  `#{cmd}`

  cmd = <<~SQL
    psql -d pgsnap -c "
      INSERT INTO car_brands (name)
      VALUES
        ('Audi'),
        ('BMW'),
        ('Honda'),
        ('Mercedes-Benz'),
        ('Lexus'),
        ('Volvo');
    "
  SQL
  p cmd
  `#{cmd}`

  cmd = <<~SQL
    psql -d pgsnap -c "
      CREATE TABLE car_models(
        id BIGSERIAL PRIMARY KEY,
        year INTEGER NOT NULL,
        name VARCHAR NOT NULL,
        car_brand_id BIGINT REFERENCES car_brands(id)
      )
    "
  SQL
  p cmd
  `#{cmd}`

  cmd = <<~SQL
  psql -d pgsnap -c "
    INSERT INTO car_models (year, name, car_brand_id)
    VALUES
      (2017, 'TT', (SELECT id FROM car_brands where name = 'Audi')),
      (2018, 'TT', (SELECT id FROM car_brands where name = 'Audi')),
      (2019, 'TT', (SELECT id FROM car_brands where name = 'Audi')),
      (2017, 'X5', (SELECT id FROM car_brands where name = 'BMW')),
      (2018, 'X5', (SELECT id FROM car_brands where name = 'BMW')),
      (2019, 'X5', (SELECT id FROM car_brands where name = 'BMW')),
      (2017, 'Civic', (SELECT id FROM car_brands where name = 'Honda')),
      (2018, 'Civic', (SELECT id FROM car_brands where name = 'Honda')),
      (2019, 'Civic', (SELECT id FROM car_brands where name = 'Honda')),
      (2017, 'AMG E63 S', (SELECT id FROM car_brands where name = 'Mercedes-Benz')),
      (2018, 'AMG E63 S', (SELECT id FROM car_brands where name = 'Mercedes-Benz')),
      (2019, 'AMG E63 S', (SELECT id FROM car_brands where name = 'Mercedes-Benz')),
      (2017, 'ES 250', (SELECT id FROM car_brands where name = 'Lexus')),
      (2018, 'ES 350', (SELECT id FROM car_brands where name = 'Lexus')),
      (2019, 'ES 300h', (SELECT id FROM car_brands where name = 'Lexus')),
      (2017, 'XC90', (SELECT id FROM car_brands where name = 'Volvo')),
      (2018, 'XC90', (SELECT id FROM car_brands where name = 'Volvo')),
      (2019, 'XC90', (SELECT id FROM car_brands where name = 'Volvo'));
    "
  SQL
  p cmd
  `#{cmd}`

  cmd = <<~SQL
    psql -d pgsnap -c "
      CREATE TABLE car_customers(
        id BIGSERIAL PRIMARY KEY,
        name VARCHAR NOT NULL
      )
    "
  SQL
  p cmd
  `#{cmd}`

  cmd = <<~SQL
  psql -d pgsnap -c "
    INSERT INTO car_customers (name)
    VALUES
      ('Ignacia Hoke'),
      ('Lezlie Grainger'),
      ('Minda Dipiazza'),
      ('Leighann Edgerly'),
      ('Doria Jaques');
  "
  SQL
  p cmd
  `#{cmd}`

  cmd = <<~SQL
    psql -d pgsnap -c "
      CREATE TABLE car_purchases(
        id BIGSERIAL PRIMARY KEY,
        date TIMESTAMP WITH TIME ZONE NOT NULL,
        quantity SMALLINT NOT NULL,
        unit_price NUMERIC NOT NULL,
        discount NUMERIC NOT NULL,
        car_model_id BIGINT REFERENCES car_models(id)
      )
    "
  SQL
  p cmd
  `#{cmd}`

  cmd = <<~SQL
  psql -d pgsnap -c "
    INSERT INTO car_purchases (date, quantity, unit_price, discount, car_model_id)
    VALUES
      (
        (SELECT NOW() - INTERVAL '300 days'), 300, 30987, 10000,
        (SELECT id FROM car_models WHERE year = 2017 AND name = 'Civic')
      ),
      (
        (SELECT NOW() - INTERVAL '137 days'), 1, 333777, 0,
        (SELECT id FROM car_models WHERE year = 2019 AND name = 'AMG E63 S')
      ),
      (
        (SELECT NOW() - INTERVAL '10 days'), 23, 222666, 100000,
        (SELECT id FROM car_models WHERE year = 2019 AND name = 'ES 300h')
      );
  "
  SQL
  p cmd
  `#{cmd}`
end
