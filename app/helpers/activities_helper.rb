module ActivitiesHelper
  def has activity
    if activity.type_object == Relationship.name
      relationship = Relationship.find_by id: activity.id_object
      if relationship
        followed_user = User.find_by id: relationship.followed_id
        "has #{activity.action} #{followed_user.full_name}"
      elsif !activity.destroy
        flash[:danger] = t "destroy_activity_wrong"
      end
    end
  end
end
