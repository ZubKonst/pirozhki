module Timestampable
  extend ActiveSupport::Concern

  included do
    before_validation :set_created_time, on: :create
    before_validation :set_updated_time
  end

  private

  def set_created_time
    self.created_time ||= Time.now.to_i
  end

  def set_updated_time
    self.updated_time = Time.now.to_i
  end
end
