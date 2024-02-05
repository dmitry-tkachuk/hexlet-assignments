# frozen_string_literal: true

require_relative 'test_helper'
require_relative '../lib/stack'

class StackTest < Minitest::Test
  # BEGIN
  def setup
    @stack = Stack.new
  end

  def test_add_element
    @stack.push!(1)
    assert { @stack.to_a == [1] }
    assert { @stack.size == 1 }
  end

  def test_remove_element
    @stack.push!(1)
    @stack.pop!
    assert { @stack.empty? }
    assert { @stack.empty? }
  end

  def test_clear_stack
    @stack.push!(1)
    @stack.push!(2)
    @stack.clear!
    assert { @stack.empty? }
    assert { @stack.empty? }
  end

  def test_empty_stack
    assert { @stack.empty? }
    @stack.push!(1)
    refute { @stack.empty? }
  end
  # END
end

test_methods = StackTest.new({}).methods.select { |method| method.start_with? 'test_' }
raise 'StackTest has not tests!' if test_methods.empty?
