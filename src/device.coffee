{div} = React.DOM

Device = React.createClass
  displayName: 'Device'
  render: ->
    div null, "#{@props.name} - #{@props.status ? 'on' : 'off'}"
