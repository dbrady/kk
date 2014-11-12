module Kk

  class Entry < Sequel::Model

    def before_create
      super
      now = DateTime.now
      self.created_at ||= now
    end

    def before_update
      super
      now = DateTime.now
      self.updated_at ||= now
    end
  end

end
