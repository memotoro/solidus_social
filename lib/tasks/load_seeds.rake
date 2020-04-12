# frozen_string_literal: true

namespace :solidus_social do
  desc "Loads permissions data."
  task load_permissions: :environment do
    permissions = ['Spree::PermissionSets::AuthenticationMethodDisplay', 'Spree::PermissionSets::AuthenticationMethodManagement']
    permissions.each do |permission|
      Spree::PermissionSet.find_or_create_by(name: permission.split('PermissionSets::').last, set: permission.to_s)
    end
  end
end
