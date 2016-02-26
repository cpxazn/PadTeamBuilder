class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :trackable, :validatable
	validates :username, :presence => true, :uniqueness => {:case_sensitive => false} 
	validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true
	has_many :votes, dependent: :destroy
	has_many :comments
	
	def self.top
		where('votes_count > 0').order('votes_count desc').limit(10)
	end
end
