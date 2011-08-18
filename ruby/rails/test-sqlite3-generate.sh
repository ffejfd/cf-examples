#!/bin/sh
#
#    test-sqlite3-generate.sh - Generates a rails project for testing sqlite3
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

# Create a rails 3.0 project under the test_sqlite3 link
echo " * Creating new Rails project test_sqlite3"
rails new test_sqlite3 -d sqlite3

cd test_sqlite3
echo " * Generating model for basic Rails application"
rails generate scaffold Account user_name:string description:text active:boolean birthday:date

echo " * Making default homepage our newly created project"
mv -f config/routes.rb config/routes.rb.old
cat config/routes.rb.old | sed 's/# root :to => "welcome#index"/root :to => "Accounts#index"/' > config/routes.rb
rm -f public/index.html

echo " * Pushing application to CloudFoundry"
vmc push

echo " * Done"
exit 0
