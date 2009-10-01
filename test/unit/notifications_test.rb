require 'test_helper'

class NotificationsTest < ActionMailer::TestCase
  test "demand_closed" do
    @expected.subject = 'Notifications#demand_closed'
    @expected.body    = read_fixture('demand_closed')
    @expected.date    = Time.now

    assert_equal @expected.encoded, Notifications.create_demand_closed(@expected.date).encoded
  end

end
