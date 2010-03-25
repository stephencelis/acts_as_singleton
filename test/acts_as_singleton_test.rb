require 'test/unit'
require 'active_record'
require "#{File.dirname(__FILE__)}/../init"
require 'active_support'
require 'active_support/test_case'
ActiveRecord::Migration.verbose = false

def setup_db
  ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')
  ActiveRecord::Schema.define(:version => 1) do
    create_table :homepage_settings do |t|
      t.string :type
      t.text :welcome_message
      t.timestamp :published_at, :expired_at
    end

    create_table :cottages do |t|
      t.belongs_to :home_away_from_home, :polymorphic => true
    end
  end
end

def teardown_db
  ActiveRecord::Base.connection.tables.each do |table|
    ActiveRecord::Base.connection.drop_table(table)
  end
end

setup_db
class HomepageSettings < ActiveRecord::Base
  acts_as_singleton
  has_many :cottages, :as => :home_away_from_home
end

class LoggedInSettings < HomepageSettings
end

class Cottage < ActiveRecord::Base
  belongs_to :home_away_from_home, :polymorphic => true
  validates_associated :home_away_from_home
end

class ActsAsSingletonTest < ActiveSupport::TestCase
  setup do
    setup_db
  end

  teardown do
    teardown_db

    HomepageSettings.instance_eval do
      remove_instance_variable :@instance if defined? @instance
    end
  end

  test "should be provocative" do
    assert_raise(NoMethodError) { HomepageSettings.new }
    assert_raise(NoMethodError) { HomepageSettings.create }
    assert_raise(NoMethodError) { HomepageSettings.update }
    assert_raise(NoMethodError) { HomepageSettings.alloc }
    assert_raise(NoMethodError) { HomepageSettings.all }
    assert_raise(NoMethodError) { HomepageSettings.first }
    assert_raise(NoMethodError) { HomepageSettings.find }
    assert_raise(NoMethodError) { HomepageSettings.find_by_sql("") }
    assert_raise(NoMethodError) { HomepageSettings.named_scope }
    assert_raise(NoMethodError) { HomepageSettings.minimum }
    assert_raise(NoMethodError) { HomepageSettings.maximum }
    assert_raise(ArgumentError) { HomepageSettings.exists? 1 }
    assert_raise(TypeError) { HomepageSettings.instance.clone }
    assert_raise(TypeError) { HomepageSettings.instance.dup }
  end

  test "should be lazy" do
    assert !HomepageSettings.exists?
    assert_instance_of HomepageSettings, HomepageSettings.instance
    assert HomepageSettings.exists?
  end

  test "should be equal" do
    assert_equal HomepageSettings.instance, HomepageSettings.instance
  end

  test "should be unidentifiable" do
    assert_no_match(/id: .+?,/, HomepageSettings.inspect)
    assert_no_match(/id: .+?,/, HomepageSettings.instance.inspect)
  end

  test "should be mutable" do
    assert_nothing_raised do
      HomepageSettings.instance.update_attributes! :welcome_message => "OH HAI"
    end
  end

  test "should honor STI" do
    ActiveRecord::Base.clear_active_connections!
    HomepageSettings.instance # Fetch parent.
    LoggedInSettings.instance # Fetch child.
    assert_nothing_raised ActiveRecord::SubclassNotFound do
      LoggedInSettings.instance # Fetch again.
    end
  end

  test "should honor polymorphism" do
    HomepageSettings.instance.cottages.create
  end
end
