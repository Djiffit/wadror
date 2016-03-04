require 'rails_helper'

RSpec.describe "add_status_to_memberships/new", type: :view do
  before(:each) do
    assign(:add_status_to_membership, AddStatusToMembership.new(
      :boolean => ""
    ))
  end

  it "renders new add_status_to_membership form" do
    render

    assert_select "form[action=?][method=?]", add_status_to_memberships_path, "post" do

      assert_select "input#add_status_to_membership_boolean[name=?]", "add_status_to_membership[boolean]"
    end
  end
end
