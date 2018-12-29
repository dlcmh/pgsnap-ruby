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
        obsolete_on TIMESTAMP WITH TIME ZONE,
        car_brand_id BIGINT REFERENCES car_brands(id)
      )
    "
  SQL
  p cmd
  `#{cmd}`

  cmd = <<~SQL
  psql -d pgsnap -c "
    INSERT INTO car_models (year, name, obsolete_on, car_brand_id)
    VALUES
      (2017, 'TT', NULL, (SELECT id FROM car_brands where name = 'Audi')),
      (2018, 'TT', TO_DATE('20191231', 'YYYYMMDD'), (SELECT id FROM car_brands where name = 'Audi')),
      (2019, 'TT', NULL, (SELECT id FROM car_brands where name = 'Audi')),
      (2017, 'X5', NULL, (SELECT id FROM car_brands where name = 'BMW')),
      (2018, 'X5', NULL, (SELECT id FROM car_brands where name = 'BMW')),
      (2019, 'X5', NULL, (SELECT id FROM car_brands where name = 'BMW')),
      (2017, 'Civic', NULL, (SELECT id FROM car_brands where name = 'Honda')),
      (2018, 'Civic', NULL, (SELECT id FROM car_brands where name = 'Honda')),
      (2019, 'Civic', NULL, (SELECT id FROM car_brands where name = 'Honda')),
      (2017, 'AMG E63 S', NULL, (SELECT id FROM car_brands where name = 'Mercedes-Benz')),
      (2018, 'AMG E63 S', NULL, (SELECT id FROM car_brands where name = 'Mercedes-Benz')),
      (2019, 'AMG E63 S', NULL, (SELECT id FROM car_brands where name = 'Mercedes-Benz')),
      (2017, 'ES 250', TO_DATE('20181231', 'YYYYMMDD'), (SELECT id FROM car_brands where name = 'Lexus')),
      (2018, 'ES 350', NULL, (SELECT id FROM car_brands where name = 'Lexus')),
      (2019, 'ES 300h', NULL, (SELECT id FROM car_brands where name = 'Lexus')),
      (2017, 'XC90', NULL, (SELECT id FROM car_brands where name = 'Volvo')),
      (2018, 'XC90', NULL, (SELECT id FROM car_brands where name = 'Volvo')),
      (2019, 'XC90', NULL, (SELECT id FROM car_brands where name = 'Volvo'));
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

  # http://www.postgresqltutorial.com/postgresql-recursive-query/
  cmd = <<~SQL
    psql -d pgsnap -c "
      CREATE TABLE employees(
        employee_id SERIAL PRIMARY KEY,
        full_name VARCHAR NOT NULL,
        manager_id INTEGER
      )
    "
  SQL
  p cmd
  `#{cmd}`

  cmd = <<~SQL
  psql -d pgsnap -c "
    INSERT INTO employees (employee_id, full_name, manager_id)
    VALUES
      (1, 'Michael North', NULL),
      (2, 'Megan Berry', 1),
      (3, 'Sarah Berry', 1),
      (4, 'Zoe Black', 1),
      (5, 'Tim James', 1),
      (6, 'Bella Tucker', 2),
      (7, 'Ryan Metcalfe', 2),
      (8, 'Max Mills', 2),
      (9, 'Benjamin Glover', 2),
      (10, 'Carolyn Henderson', 3),
      (11, 'Nicola Kelly', 3),
      (12, 'Alexandra Climo', 3),
      (13, 'Dominic King', 3),
      (14, 'Leonard Gray', 4),
      (15, 'Eric Rampling', 4),
      (16, 'Piers Paige', 7),
      (17, 'Ryan Henderson', 7),
      (18, 'Frank Tucker', 8),
      (19, 'Nathan Ferguson', 8),
      (20, 'Kevin Rampling', 8);
  "
  SQL
  p cmd
  `#{cmd}`
end
