# frozen_string_literal: true

class Vessel < ApplicationRecord
  scope :by_name, -> { order(name: :asc) }

  belongs_to :organization
  has_many :employments

  validates_presence_of :name
  attr_accessor :move_users_to_vessel_id
end
