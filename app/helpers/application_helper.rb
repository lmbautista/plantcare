module ApplicationHelper
  def current_user
    env['warden'].user
  end

  def logged
    current_user.present?
  end
end
