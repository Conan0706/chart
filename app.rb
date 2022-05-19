require 'bundler/setup'
Bundler.require
require 'sinatra/reloader' if development?

require "./models"
require "date"
require "google_drive"
 
g_session = GoogleDrive::Session.from_config("config.json")

sheets = g_session.spreadsheet_by_url("https://docs.google.com/spreadsheets/d/12YMejz2Va4jaIEFn-TjSFceVcz9Spj9oGaCeXr2PMhM/edit#gid=0")

ws = sheets.worksheet_by_title("シート1")




enable :sessions

helpers do
    def current_user
        User.find_by(id: session[:user])
    end
end

get "/" do
    @user = current_user
    
    # ws[1,2] = "hello world!!"
    # ws.save
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
            password_confirmation: params[:password_confirmation],
            number: params[:number]
        )
        if user.persisted?
            session[:user] = user.id
        end
        number = params[:number].to_i
        ws[number,1] = params[:name]
        ws.save
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

get "/signout" do
    session[:user] = nil
    redirect "/"
end

get "/home" do
    year = Date.today
    @now_year = year.year.to_s + "年"
    @user = current_user
    score = Score.all
    @scores = Score.order(date: "ASC")
    @chart_score = []
    @chart_date = []
    
    erb :home
end

post "/score" do
    score = Score.create(
        user_id: current_user.id,
        score: params[:score],
        date: params[:date]
    )
    score_column = 2
    number = current_user.number
    scores = Score.all
    scores.each do |score|
        if current_user.id == score.user_id
            ws[number,score_column] = score.score
            ws.save
            score_column += 1
        end
    end
    score = 2
    redirect "/home"
end

post "/goal" do
    user =User.find_by(id: current_user.id )
    if user.goal
        user.goal = params[:goal]
        user.save
    end
    redirect "/home"
end

post "/:id/edit" do
   user = User.find_by(id: params[:id].id) 
   
end
    