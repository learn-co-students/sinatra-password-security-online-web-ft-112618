class User < ActiveRecord::Base
	has_secure_password #active record macro, works in conjunction with bcrypt
end
