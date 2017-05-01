module ApplicationHelper
  def current_user
    env['warden'].user
  end

  def unlogged
    current_user.blank?
  end
end
