require 'rails_helper'

RSpec.describe "dresseds/index", type: :view do
  before(:each) do
    assign(:dresseds, [
      Dressed.create!(),
      Dressed.create!()
    ])
  end

  it "renders a list of dresseds" do
    render
  end
end
