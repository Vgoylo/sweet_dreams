module UserSearch
  prepend UsersHelper

  def search
    if params[:search]
      search = params[:search]
      @users = @users.where('name like ? or email like ?', "%#{search}%", "%#{search}%")
    end
  end
end
