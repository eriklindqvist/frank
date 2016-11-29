require 'rubygems'

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end

get '/devices' do
  content_type :json
  out = `ssh pi@raspberry2 'tdtool -l'`
  num_devices = out.match(/Number of devices: ([0-9].)/)[1].to_i
  out.lines[1..num_devices].map { |l|
    cols = l.chomp.split("\t")
    {key: cols[0], name: cols[1], status: on?(cols[2])}
  }.to_json
end

post '/device/:id' do
  out = `ssh pi@raspberry2 'tdtool --list-devices | grep -e "id=#{params[:id]}\\s"'`
  out.split("=").last.downcase
end

post '/device' do
  if on? params[:status]
    status = 'n'
  elsif off? params[:status]
    status = 'f'
  else
    return [403, 'invalid status']
  end

  `ssh pi@raspberry2 'tdtool -#{status} #{params[:id]}'`
end

def on? str
  str.downcase == 'on'
end

def off? str
  str.downcase == 'off'
end
