module ActivitiesHelper
  def had activity
    if activity.type_object == Relationship.name
      activity_relationship activity
    elsif activity.type_object == Review.name
      activity_review activity
    end
  end

  def activity_relationship activity
    relationship = Relationship.find_by id: activity.id_object
    if relationship.present?
      followed_user = User.find_by id: relationship.followed_id
      control_nil followed_user
      "#{I18n.t 'had'} #{activity.action} #{followed_user.full_name}"
    elsif !activity.destroy
      flash[:danger] = t "destroy_activity_wrong"
    end
  end

  def activity_review activity
    review = Review.find_by id: activity.id_object
    if review.present?
      book = Book.find_by id: review.book_id
      control_nil book
      "#{I18n.t 'had'} #{activity.action} #{I18n.t 'to'} \"#{book.title}\""
    elsif !activity.destroy
      flash[:danger] = t "destroy_activity_wrong"
    end
  end

  def control_nil object
    return if object.present?
    redirect_to root_path
  end
end
