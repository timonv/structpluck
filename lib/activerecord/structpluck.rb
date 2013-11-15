require "activerecord/structpluck/version"

module Activerecord
  module Structpluck
    def pluck_structs(*column_names)
      column_names.map! do |column_name|
        if column_name.is_a?(Symbol) && attribute_alias?(column_name)
          attribute_alias(column_name)
        else
          column_name.to_s
        end
      end

      if has_include?(column_names.first)
        construct_relation_for_association_calculations.pluck(*column_names)
      else
        relation = spawn
        relation.select_values = column_names.map { |cn|
          columns_hash.key?(cn) ? arel_table[cn] : cn
        }
        result = klass.connection.select_all(relation.arel, nil, bind_values)
        columns = result.columns.map do |key|
          klass.column_types.fetch(key) {
            result.column_types.fetch(key) { result.identity_type }
          }
        end

        result = result.map do |attributes|
          values = klass.initialize_attributes(attributes).values

          columns.zip(values).map { |column, value| column.type_cast value }
        end

        FakeRecord = Struct.new(*column_names)
        result.map { |r| FakeRecord.new(r) }
      end
    end
  end
end
