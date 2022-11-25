# frozen_string_literal: true

module Manage
  module Settings
    class VesselPolicy < OrganizationScopedPolicy
      def new?
        true
      end

      def create?
        true
      end

      def edit?
        true
      end

      def update?
        true
      end

      def destroy?
        true
      end

      def delete_modal?
        true
      end

      def delete_vessel?
        true
      end
    end
  end
end
