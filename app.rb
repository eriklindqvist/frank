require 'rubygems'

set :ssh, "ssh #{ENV['TDTOOL_USER']}@#{ENV['TDTOOL_HOST']}"

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

get '/devices' do
  content_type :json
  out = `#{settings.ssh} 'tdtool -l'`
  num_devices = out.match(/Number of devices: ([0-9].)/)[1].to_i
  out.lines[1..num_devices].map { |l|
    cols = l.chomp.split("\t")
    {key: cols[0], name: cols[1], status: on?(cols[2])}
  }.to_json
end

get '/device/:id' do
  get_device_status params[:id]
end

post '/device/:id' do
  get_device_status params[:id]
end

post '/device' do
  if on? params[:status]
    status = 'n'
  elsif off? params[:status]
    status = 'f'
  else
    return [403, 'invalid status']
  end

  `#{settings.ssh} 'tdtool -#{status} #{params[:id]}'`
end

def on? str
  str.downcase == 'on'
end

def off? str
  str.downcase == 'off'
end

def get_device_status(id)
  `#{settings.ssh} 'tdtool --list-devices | grep -e "id=#{id}\\s"'`.split("=").last.downcase
end
