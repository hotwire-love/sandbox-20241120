require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  test "CRUD tasks" do
    visit tasks_url

    assert_selector "h1", text: "Tasks"

    fill_in "Title", with: "ミルクを買う"
    click_on "Create Task"
    assert_text "Task was successfully created."
    within '#tasks' do
      assert_text "ミルクを買う"
    end
    assert_field "Title", with: ""
    assert_text "Remains: 1 / Total: 1"

    fill_in "Title", with: "ネギを買う"
    click_on "Create Task"
    assert_text "Task was successfully created."
    within '#tasks' do
      assert_text "ネギを買う"
    end
    assert_field "Title", with: ""
    assert_text "Remains: 2 / Total: 2"

    rows = all('#tasks tbody tr')
    assert_equal 2, rows.size
    within rows[0] do
      assert_text "ミルクを買う"
      assert_text "not yet"
      click_on "DONE"
      assert_text "done"
    end
    assert_text "Task was successfully updated."
    assert_text "Remains: 1 / Total: 2"

    within rows[1] do
      assert_text "ネギを買う"
      click_on "DELETE"
    end
    assert_text "Task was successfully deleted."
    refute_text "ネギを買う"
    assert_text "Remains: 0 / Total: 1"
  end
end
