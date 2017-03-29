require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  def setup
    @message = users(:example).messages.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @message.valid?, @message.errors.full_messages
  end

  test "should not be blank" do
    @message.content = " "
    assert !@message.valid?
  end

  test "should notice mentions" do
    @message.content = "@#{users(:example).username} is a jerk!"
    assert_not @message.mentions.empty?
  end

  test "should notice lack of mentions" do
    @message.content = "Somebody is a jerk, I just don't know their username!"
    assert @message.mentions.empty?
  end
end
