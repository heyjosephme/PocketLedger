require "test_helper"

class FlashComponentTest < ViewComponent::TestCase
  test "renders success flash message" do
    render_inline(FlashComponent.new(type: "success", message: "Expense was successfully created."))

    assert_selector "div[data-controller='flash']"
    assert_text "Expense was successfully created."
    assert_selector "div.from-green-600"
  end

  test "renders error flash message" do
    render_inline(FlashComponent.new(type: "error", message: "Something went wrong."))

    assert_selector "div[data-controller='flash']"
    assert_text "Something went wrong."
    assert_selector "div.from-red-600"
  end

  test "renders notice flash message" do
    render_inline(FlashComponent.new(type: "notice", message: "Please check your email."))

    assert_selector "div[data-controller='flash']"
    assert_text "Please check your email."
    assert_selector "div.from-blue-600"
  end

  test "renders alert flash message" do
    render_inline(FlashComponent.new(type: "alert", message: "Warning: This action cannot be undone."))

    assert_selector "div[data-controller='flash']"
    assert_text "Warning: This action cannot be undone."
    assert_selector "div.from-amber-500"
  end

  test "includes close button" do
    render_inline(FlashComponent.new(type: "notice", message: "Test message"))

    assert_selector "button[data-action='click->flash#close']"
  end

  test "has auto-dismiss data attribute" do
    render_inline(FlashComponent.new(type: "success", message: "Success!"))

    assert_selector "div[data-flash-duration-value='5000']"
  end
end
