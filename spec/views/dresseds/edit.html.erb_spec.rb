require 'rails_helper'

RSpec.describe "dresseds/edit", type: :view do
  before(:each) do
    @dressed = assign(:dressed, Dressed.create!())
  end

  it "renders the edit dressed form" do
    render

    assert_select "form[action=?][method=?]", dressed_path(@dressed), "post" do
    end
  end
end
