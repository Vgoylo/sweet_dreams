
  module Users
    class IndexPresenter < SimpleDelegator
      def initialize(user)
        @user = user
        super(@user)
      end

      def length_user_name
        @user.name.length
      end
    end
  end

