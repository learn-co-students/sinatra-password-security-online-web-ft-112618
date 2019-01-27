require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

	configure do
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
	end

	get "/" do
		erb :index
	end

	get "/signup" do
		erb :signup
	end


	post "/signup" do
  	user = User.new(:username => params[:username], :password => params[:password])#:password comes form the has_secure_password macro
		#Because our user has has_secure_password, we won't be able to save this to the database unless our user filled out the password field.
		if user.save #you will only become a user if you fill out the password field.
				redirect "/login" #redirects to login
		else
			redirect "/failure"
		#Calling user.save will return false if the user can't be persisted
		end

	end

	get "/login" do
		erb :login
	end


#checking for a user in our database, password is handled by the authenticate method from has_secure_password
	post "/login" do
		user = User.find_by(:username => params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect "/success"
		else
			redirect "failure"
		end
	end

	get "/success" do
		if logged_in?
			erb :success
		else
			redirect "/login"
		end
	end

	get "/failure" do
		erb :failure
	end

	get "/logout" do
		session.clear
		redirect "/"
	end

	helpers do
		def logged_in?
			!!session[:user_id]
		end

		def current_user
			User.find(session[:user_id])
		end
	end

end
