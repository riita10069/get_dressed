require 'rails_helper'

RSpec.describe "dresseds/new", type: :view do
  before(:each) do
    assign(:dressed, Dressed.new())
  end

  it "renders new dressed form" do
    render

    assert_select "form[action=?][method=?]", dresseds_path, "post" do
    end
  end
end
