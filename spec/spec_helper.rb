$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'active_record'
require 'automagical_validations'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

database_properties = {
  :adapter  => defined?(JRUBY_VERSION) ? "jdbcmysql" : "mysql2",
  :host     => "localhost",
  :username => "root",
  :password => "",
  :database => "automagical_validations_test"
}

ActiveRecord::Base.establish_connection database_properties

class Post < ActiveRecord::Base
  def self.rebuild_table
    ActiveRecord::Schema.define do
      self.verbose = false

      create_table :posts, :force => true do |t|
        yield t
      end
    end

    reset_column_information

    # Reset all validators to prevent test cases from messing with each other
    self._validators = columns.inject({}) do |memo, column|
      memo[column.name.to_sym] = []
      memo
    end
  end
end

class Comment < ActiveRecord::Base; end
