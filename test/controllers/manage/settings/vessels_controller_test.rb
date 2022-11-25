# frozen_string_literal: true

require "test_helper"

class Manage::Settings::VesselsControllerTest < ActionController::TestCase
  context "GET delete_modal" do
    should "return true" do
      setup_data
      get :delete_modal, params: { id: @vessel_1.id, organization_id: @organization.id, format: :js }, xhr: true
      assert_equal response.status, 200
      assert_equal response.content_type, "text/javascript"
    end
  end

  context "PATCH delete_vessel" do
    context "when move user to vessel is blank" do
      context "When vessel present with given id" do
        should "return success message and delete vessel" do
          setup_data
          get :delete_vessel, params: { id: @vessel_1.id, organization_id: @organization.id,
                                        vessel: { move_users_to_vessel_id: nil } }, xhr: true
          assert_equal flash[:success], "Vessel updated"
          assert_equal Vessel.count, 1
          assert_redirected_to edit_manage_organization_settings_meta_data_path
        end
      end

      context "When vessel not present with given id" do
        should "return success message" do
          setup_data
          assert_raises(ActiveRecord::RecordNotFound) do
            get :delete_vessel, params: { id: 0, organization_id: @organization.id,
                                          vessel: { move_users_to_vessel_id: nil } }, xhr: true
            assert_equal flash[:danger], "There were issues updating the vessel"
            assert_template :edit
          end
        end
      end
    end

    context "when move user to vessel is present" do
      should "should assign employees" do
        setup_data
        get :delete_vessel, params: { id: @vessel_1.id, organization_id: @organization.id,
                                      vessel: { move_users_to_vessel_id: @vessel_2.id }, format: :js }, xhr: true
        assert_equal(@vessel_2.employments.count, 1)
        assert_equal Vessel.count, 1
      end
    end
  end

  private

  def setup_data
    admin = UserFactory.create(
      email: "admin@example.com",
      password: "password",
      first_name: "Admin",
      last_name: "Example"
    )
    @organization = OrganizationFactory.create(name: "Organization")
    @organization.employees << admin
    admin.add_role(:admin, @organization)
    @vessel_1 = @organization.vessels.create(name: "Test1")
    @vessel_2 = @organization.vessels.create(name: "Test2")
    @organization.employments.first.update(vessel: @vessel_1)
    sign_in_as(admin)
  end
end
