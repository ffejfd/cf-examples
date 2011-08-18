#!/bin/sh
#
#    test-mongodb-generate.sh - Generates a rails project for testing MongoDB
#
#    Copyright (C) 2011 Canonical
#
#    Authors:
#               Marc Cluet <marc.cluet@canonical.com>
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as
#    published by the Free Software Foundation, version 3 of the License.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Create a rails 3.0 project under the test_mongodb link
echo " * Creating new Rails project test_mongodb"
rails new test_mongodb --skip-active-record

cd test_mongodb
echo " * Adding mongodb_mapper"
cat >> Gemfile << EOF
gem 'mongo_mapper'
gem 'rails3-generators'
EOF

echo " * Building bundle"
bundle install

echo " * Generating extra code"
cat >> config/initializers/mongo.rb << EOF
MongoMapper.connection = Mongo::Connection.new('localhost', 27017)
MongoMapper.database = "#myapp-#{Rails.env}"

if defined?(PhusionPassenger)
   PhusionPassenger.on_event(:starting_worker_process) do |forked|
     MongoMapper.connection.connect if forked
   end
end
EOF

mv -f config/application.rb config/application.rb.old
cat config/application.rb.old | sed s'/  end/    config.generators do |g|\n      g.fixture_replacement :factory_girl\n      g.orm :mongo_mapper\n    end\n  end/' > config/application.rb

echo " * Generating model for basic Rails application"
rails generate scaffold Account user_name:string description:string active:boolean birthday:date

echo " * Making default homepage our newly created project"
mv -f config/routes.rb config/routes.rb.old
cat config/routes.rb.old | sed 's/# root :to => "welcome#index"/root :to => "Accounts#index"/' > config/routes.rb
rm -f public/index.html

echo " * Pushing application to CloudFoundry"
vmc push

echo " * Done"
exit 0
