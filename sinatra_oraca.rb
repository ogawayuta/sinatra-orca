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

<<<<<<< HEAD
enable :sessions

=======
>>>>>>> 5627c082e56d8e455577e4c645b125a0119fb8eb
set :bind, '0.0.0.0'
set :public_folder, File.dirname(__FILE__) + '/static'

Net::HTTP.version_1_2

opt = {
  :host => "192.168.4.123",
  :port=> "8000",
  :user => "ormaster",
  :passwd => "ormaster123"
}

<<<<<<< HEAD
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
  haml :login
end
get '/' do
  check_login
=======
get '/' do
>>>>>>> 5627c082e56d8e455577e4c645b125a0119fb8eb
  @patients = list_patients(opt)
  haml :index
end

get '/register' do
<<<<<<< HEAD
  check_login
=======
>>>>>>> 5627c082e56d8e455577e4c645b125a0119fb8eb
  haml :register
end

post '/register' do
<<<<<<< HEAD
  check_login
  @patient = params 
  @id,@error = register_patient(opt,@patient)
  if @error
    session['message'] = @error
=======
  @patient = params 
  @id,@error = register_patient(opt,@patient)
  if @error
>>>>>>> 5627c082e56d8e455577e4c645b125a0119fb8eb
    haml :register
  else
    haml :register_result
  end
end

get '/delete' do
<<<<<<< HEAD
  check_login
=======
>>>>>>> 5627c082e56d8e455577e4c645b125a0119fb8eb
  pp params
  @patient = params
  haml :delete
end

post '/delete' do
<<<<<<< HEAD
  check_login
  @params = params 
  @id,@error = delete_patient(opt,@params)
  session['message'] = @error
=======
  @params = params 
  @id,@error = delete_patient(opt,@params)
>>>>>>> 5627c082e56d8e455577e4c645b125a0119fb8eb
  redirect to '/'
end
