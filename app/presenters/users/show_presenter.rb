module Users
  class ShowPresenter < SimpleDelegator

    def initialize(user)
      @user = user
      super(@user)
    end

    def show_user_name_length
      "This is length name <<#{@user.name.length}>>"
    end
  end
end
