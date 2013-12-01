require 'active_record'

class TestClass < ActiveRecord::Base
  include Structpluck
end

def setup_schema_and_database
  # ActiveRecord::Base.logger = Logger.new(STDERR)
  # ActiveRecord::Base.colorize_logging = false

  ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :dbfile  => ":memory:",
    :database => "test_structp"
  )

  ActiveRecord::Base.connection.drop_table :test_classes rescue nil

  ActiveRecord::Schema.define do
    create_table :test_classes do |table|
      table.column :title, :string
      table.column :description, :string
      table.column :created_at, :datetime
    end
  end
end
