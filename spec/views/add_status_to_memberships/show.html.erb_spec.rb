require 'rails_helper'

RSpec.describe "add_status_to_memberships/show", type: :view do
  before(:each) do
    @add_status_to_membership = assign(:add_status_to_membership, AddStatusToMembership.create!(
      :boolean => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
