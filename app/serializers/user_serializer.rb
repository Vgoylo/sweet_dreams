class UserSerializer < ActiveModel::Serializer
  attributes :id, :name_length, :email, :dream_description

  has_many :dreams

  def name_length
    "#{self.object.name.length}"
  end

  def dream_description
    object.dreams.last.description
  end
end
