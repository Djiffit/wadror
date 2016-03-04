require 'rails_helper'

RSpec.describe "add_status_to_memberships/index", type: :view do
  before(:each) do
    assign(:add_status_to_memberships, [
      AddStatusToMembership.create!(
        :boolean => ""
      ),
      AddStatusToMembership.create!(
        :boolean => ""
      )
    ])
  end

  it "renders a list of add_status_to_memberships" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
