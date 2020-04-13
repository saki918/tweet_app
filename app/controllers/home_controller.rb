class HomeController < ApplicationController
  # ログインしているユーザーの閲覧禁止
  before_action :forbid_login_user, only: [:top]

  def top
  end

  def about
  end
end
