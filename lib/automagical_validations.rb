module AutomagicalValidations
  def automagically_validate(*types_to_validate)
    types_to_validate.map!{ |type| type.to_sym }

    columns.each do |column|
      # Do not touch the columns not specified
      next unless types_to_validate.include? column.type

      # Do not define validator on columns that have no limit information, even if asked to
      next unless column.limit

      # Do not define additional length validators if any are already in place
      next if validators_on(column.name).any? do |validator|
        validator.is_a?(ActiveModel::Validations::LengthValidator) && validator.options[:maximum]
      end

      validates_length_of column.name, :maximum => column.limit
    end
  end
end

ActiveRecord::Base.extend AutomagicalValidations