= acts_as_singleton

http://github.com/stephencelis/acts_as_singleton


== DESCRIPTION

A lightweight singleton library for your Active Record models.

It just makes sense to store mutable, site-wide, admin-level settings in the
database. Right? A key-value table may be more flexible, but maybe we don't
want to be flexible!


== FEATURES/PROBLEMS

* Lightning-fast queries! Doesn't get any faster than this! (Guaranteed.)
* Follows the ultra-cool "singleton" pattern! (Tell your friends.)
* What? That's not the "cool" singleton in Ruby? (Don't tell your friends?)


== SYNOPSIS

  class HomepageSettings < ActiveRecord::Base
    include ActiveRecord::Singleton
  end


How Rubyish! Oh, you want it Railsish? Very well...

  class HomepageSettings < ActiveRecord::Base
    acts_as_singleton
  end


Have your cake and eat your silly idiom, too! Just try to create a row!

  HomepageSettings.instance # => #<HomepageSettings...>


Don't even try to access it otherwise. It won't work!


== REQUIREMENTS

* Active Record 2.3.2 or greater.
* A delicate palate.


== INSTALL

=== As a gem

Install:

  % gem install stephencelis-acts_as_singleton --source=http://gems.github.com


Configure:

  config.gem "stephencelis-acts_as_singleton",
    :lib => "acts_as_singleton",
    :source => "http://gems.github.com"


=== As a plugin

  % script/plugin install git://github.com/stephencelis/acts_as_singleton.git


== LICENSE

(The MIT License)

(c) 2009-* Stephen Celis, stephen@stephencelis.com.

Permission is hereby granted, free of charge, to any person obtaining a copy 
of this software and associated documentation files (the "Software"), to deal 
in the Software without restriction, including without limitation the rights 
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell 
copies of the Software, and to permit persons to whom the Software is 
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
