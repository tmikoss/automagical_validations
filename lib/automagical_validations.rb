module AutomagicalValidations
  def automagically_validate(*types_to_validate)
    return unless self.table_exists?

    validation_settings = {}

    if types_to_validate.first.is_a? Hash
      validation_settings = types_to_validate.first
      validation_settings.symbolize_keys!
    else
      types_to_validate.each do |type|
        validation_settings[type.to_sym] = {}
      end
    end

    columns.each do |column|
      # Do not touch the columns not specified
      next unless validation_settings[column.type]

      # Do not define validator on columns that have no limit information, even if asked to
      next unless column.limit

      # Do not define additional length validators if any are already in place
      next if validators_on(column.name).any? do |validator|
        validator.is_a?(ActiveModel::Validations::LengthValidator) && validator.options[:maximum]
      end

      validates_length_of column.name, validation_settings[column.type].merge({:maximum => column.limit})
    end
  end
end

ActiveRecord::Base.extend AutomagicalValidations