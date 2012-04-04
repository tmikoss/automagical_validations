#automagical_validations

automagical_validations provides way to automatically apply validations to ActiveRecord models based on the information that can be inferred from database schema.

##Use

automagical_validations defines an `ActiveRecord::Base` class method that takes column type (like ones you would use in a migration) as argument:

    class Post < ActiveRecord::Base
      automagically_validate :string, :text
    end

##What it does
###Column maximum length validations

automagical_validations will define maximum length validations on all columns matching the passed types.

If `automagically_validate` is invoked for columns that do not support `limit` attribute (depends chiefly on the adapter used), no validations will be created.

If a maximum length validation already exists for column (for example, `automagically_validate` is invoked after `validates_length_of`), additional validation will not be created.

##Installation

Add the following line to your `Gemfile`

    gem "automagical_validations"

and run the `bundle install` command.

##Contributing to automagical_validations

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright &copy; 2012 Toms Mikoss. See LICENSE.txt for
further details.
