class VisitCity < ActiveRecord::Base

  after_save :update_radius

  private

  def update_radius

    case self.count_visit
      when 0..10
        self.update_column(:radius, 1)
      when 11..20
        self.update_column(:radius, 2)
      when 21..30
        self.update_column(:radius, 3)
      when 31..40
        self.update_column(:radius, 4)
      when 41..50
        self.update_column(:radius, 5)
      when 51..60
        self.update_column(:radius, 6)
      when 61..70
        self.update_column(:radius, 7)
      when 71..80
        self.update_column(:radius, 8)
      when 81..90
        self.update_column(:radius, 9)
      else
        self.update_column(:radius, 10)
    end

  end

end
