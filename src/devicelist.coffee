{div} = React.DOM

DeviceList = React.createClass
  getInitialState: ->
    data: []
  componentDidMount: ->
    $.ajax
      url: @props.url
      dataType: 'json'
      success: ((data) ->
        @setState data: data
      ).bind(this)
      error: ((xhr, status, err) ->
        console.error @props.url, status, err.toString()
      ).bind(this)

  render: ->
    deviceNodes = this.state.data.map (device) ->
      React.createElement(Device, { name: device.name, status: device.status })
    console.log deviceNodes

    div({ className: 'deviceList' }, deviceNodes)

$('body').append($('<div id="devices">'))

ReactDOM.render(React.createElement(DeviceList, { url: '/devices' }), document.getElementById('devices'));
