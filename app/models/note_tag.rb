class NoteTag < ApplicationRecord
  belongs_to :dream
  belongs_to :tag
end
