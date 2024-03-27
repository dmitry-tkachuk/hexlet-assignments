# frozen_string_literal: true

require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  test 'opens all bulletins page' do
    get root_url
    assert_response :success
    assert_select 'h1', 'Bulletins'
  end

  test 'opens one bulletin page with fixture' do
    bulletin = bulletins(:two)
    get bulletin_url(bulletin)
    assert_response :success
    assert_select 'h1', 'Bulletin page'
    assert_select 'h4', "I'am the second one"
    assert_select 'p', 'Hey ho'
  end
end
