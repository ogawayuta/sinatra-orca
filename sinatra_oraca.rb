#!/usr/bin/ruby
#-*-coding: utf-8-*-
$:.unshift File.dirname(__FILE__)

require 'pp'
require 'uri'
require 'net/http'
require 'crack'
require 'crack/xml'
require 'sinatra'
require 'haml'
require 'orca_api'

use Rack::Protection
enable :sessions

set :bind, '0.0.0.0'
set :public_folder, File.dirname(__FILE__) + '/static'

Net::HTTP.version_1_2

opt = {
  :host => "192.168.4.123",
  :port=> "8000",
  :user => "ormaster",
  :passwd => "ormaster123"
}

helpers do
  def check_login
    unless session[:login]
      redirect to '/login'
    end
  end
end

get '/login' do
  haml :login
end

post '/login' do
  if params['user'] == 'soft' && params['passwd'] == 'bank'
    session['login'] = true
    redirect to '/'
  else
    session['message'] = 'ユーザまたはパスワードが違います'
    session['login'] = nil
    redirect to '/login'
  end
end

get '/logout' do
  session['login'] = nil
  redirect to '/login'
end

get '/' do
  check_login
  @patients=list_patients(opt)
  haml :index
end

get '/search' do
  check_login
  haml :search
end

post '/search' do
  @patients=search_patients(opt,search_name)
  check_login
end

get '/register' do
  check_login
  haml :register
end

post '/register' do
  check_login
  @patient = params 
  @id,@error = register_patient(opt,@patient)
  if @error
    session['message'] = @error
    haml :register
  else
    haml :register_result
  end
end

get '/modify' do
  check_login
  pp params
  @patient = params
  haml :modify
end

post '/modify' do
  check_login
  @params = params 
  @id,@error = modify_patient(opt,@params)
  session['message'] = @error
  redirect to '/'
end

get '/delete' do
  check_login
  pp params
  @patient = params
  haml :delete
end

post '/delete' do
  check_login
  @params = params 
  @id,@error = delete_patient(opt,@params)
  session['message'] = @error
  redirect to '/'
end
