require 'test/unit'
require 'rubygems'
require 'active_record'
require "#{File.dirname(__FILE__)}/../init"
require 'active_support'
require 'active_support/test_case'

def setup_db
  ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :dbfile => ':memory:')
  ActiveRecord::Schema.define(:version => 1) do
    create_table :homepage_settings do |t|
      t.text :welcome_message
      t.timestamp :published_at, :expired_at
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
end

class ActsAsSingletonTest < ActiveSupport::TestCase
  setup do
    setup_db
  end

  teardown do
    teardown_db
  end

  test "should be provocative" do
    assert_raise(NoMethodError) { HomepageSettings.new }
    assert_raise(NoMethodError) { HomepageSettings.create }
    assert_raise(NoMethodError) { HomepageSettings.update }
    assert_raise(NoMethodError) { HomepageSettings.alloc }
    assert_raise(NoMethodError) { HomepageSettings.all }
    assert_raise(NoMethodError) { HomepageSettings.first }
    assert_raise(NoMethodError) { HomepageSettings.find }
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
end
