{div} = React.DOM

Device = React.createClass
  displayName: 'Device'
  render: ->
    s = if @props.status then 'on' else 'off'
    div className:s, "#{@props.name}"
