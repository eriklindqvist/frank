# Frank
A simple front-end to tdtool using Sinatra and Reactjs

## Running

```
$ bundle install
$ rackup
```

Will start thin on default port 9292

## API

### List devices
`get '/devices'`

**Parameters**
None

**Response**
```json
[
  {"key":"1","name":"Device 1","status":true},
  {"key":"2","name":"Device 2","status":false},
  {"key":"3","name":"Device 3","status":true}
]
```

### Set status

`get '/device/:id/:status'`

**Parameters**

Name | Type | Description
--- | --- | ---
id | int | ID of device
status | string | The status to set. Can be `"on"` or `"off"`. Otherwise will return 403 Invalid Status.

## Develop

Start a server using the rackup file:

`$ shotgun config.ru`

Or if you want a different port or server:

`$ shotgun --server=thin --port=9292 config.ru`

Then start coffee watching the src-directory to compile on the fly to the public directory:

`$ coffee -b -o public/js/ -cw src/`
