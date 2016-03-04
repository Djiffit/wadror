require 'rails_helper'

RSpec.describe "add_status_to_memberships/edit", type: :view do
  before(:each) do
    @add_status_to_membership = assign(:add_status_to_membership, AddStatusToMembership.create!(
      :boolean => ""
    ))
  end

  it "renders the edit add_status_to_membership form" do
    render

    assert_select "form[action=?][method=?]", add_status_to_membership_path(@add_status_to_membership), "post" do

      assert_select "input#add_status_to_membership_boolean[name=?]", "add_status_to_membership[boolean]"
    end
  end
end
