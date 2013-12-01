require 'test/unit'
require 'structpluck'
require 'support/test_class'

class StructpluckTest < Test::Unit::TestCase
  def setup 
    setup_schema_and_database
  end

  def test_simple_struct
    TestClass.create!(title: 'test', description: 'othertest', created_at: Time.now)
    structs = TestClass.struct_pluck(:title)
    
    assert_equal 'test', structs.first.title
  end

  def test_multiple_columns_and_results
    TestClass.create!(title: 'test', description: 'othertest', created_at: Time.now)
    TestClass.create!(title: 'test2', description: 'othertest2', created_at: Time.now)

    structs = TestClass.struct_pluck(:title, :description)
    assert structs.length == 2
    assert structs[0].title == 'test'
    assert structs[1].title == 'test2'

    assert structs[0].description == 'othertest'
    assert structs[1].description == 'othertest2'
  end
end
