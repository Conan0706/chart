require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require "./models"

enable :sessions

helpers do
    def current_user
        User.find_by(id: session[:user])
    end
end

get "/" do
    @user = current_user
    erb :index
end

get "/signup" do
    erb :sign_up
end

post "/signup" do
    if params[:password] == params[:password_confirmation] && User.find_by(name: params[:name]) == nil
        user = User.create(
            name: params[:name],
            password: params[:password],
            password_confirmation: params[:password_confirmation]
        )
        
        if user.persisted?
            session[:user] = user.id
        end
        
        redirect "/home"
    else
        redirect "/signup"
    end
end

post "/signin" do
    user = User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
        session[:user] = user.id
    end
    redirect "/home"
end
        

get "/home" do
    @user = current_user
    @scores = Score.all
    erb :home
end

post "/score" do
    score = Score.create(
        user_id: current_user.id,
        score: params[:score],
        date: params[:date]
    )
    redirect "/home"
end
    