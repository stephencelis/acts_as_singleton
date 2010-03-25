module ActiveRecord
  # A lightweight singleton library for your Active Record models.
  #
  #   class HomepageSettings < ActiveRecord::Base
  #     include ActiveRecord::Singleton
  #   end
  #
  #   HomepageSettings.instance # => #<Homepage...>
  #
  # Like Ruby's built-in module, it will not prevent you from instantiating
  # more than one object, but it will make it more difficult.
  #
  #   HomepageSettings.__send__(:new).new_record? # => true
  #
  # Most methods assuming more than one database record will be made private
  # upon including this module. Make sure your public class methods do not
  # clash with the <tt>ActiveRecord::Singleton::PRIVATE</tt> pattern, or
  # define them after including the module.
  module Singleton
    VERSION = "0.0.2"

    # This pattern matches methods that should be made private because they
    # should not be used in singleton classes.
    # PRIVATE = /^all(?:oc.*)?$|alloc|create|find|firs|mini|max|new|d_sco|^upd/
    PRIVATE = /^all$|create|find|firs|mini|max|new|d_sco|^upd/

    def self.included(model)
      model.class_eval do
        private_class_method *methods.grep(PRIVATE) # Deny existent others.

        class << self
          def exists? # Refuse arguments.
            super
          end

          # Returns the first (presumably only) record in the database, or
          # creates one.
          #
          # If validation fails on creation, it will return an unsaved object.
          #
          #   HomepageSettings.instance.update_attributes :welcome => "Hello!"
          def instance
            first || create
          end

          def inspect
            super.sub(/id: .+?, /) {} # Irrelevant.
          end

          def find(*args)
            unless caller.first.include?("lib/active_record")
              raise NoMethodError,
                "private method `find' called for #{inspect}"
            end
            super # (:first) || create
          end

          def find_by_sql(sql)
            unless caller.first.include?("lib/active_record")
              raise NoMethodError,
                "private method `find' called for #{inspect}"
            end
            super # (:first) || create
          end
        end

        def clone
          raise TypeError, "can't clone instance of singleton #{self.class}"
        end

        def dup
          raise TypeError, "can't dup instance of singleton #{self.class}"
        end

        def inspect
          super.sub(/id: .+?, /) {} # Irrelevant.
        end
      end
    end
  end

  class << Base
    # Class method to provide a more Rails-like experience. Merely includes
    # the <tt>ActiveRecord::Singleton</tt> module.
    #
    #   class HomepageSettings < ActiveRecord::Base
    #     acts_as_singleton # Equivalent to "include ActiveRecord::Singleton".
    #   end
    def acts_as_singleton
      include Singleton
    end
  end
end
