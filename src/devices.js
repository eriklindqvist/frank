var DeviceList = React.createClass({
  getInitialState: function() {
    return {data: []};
  },
  componentDidMount: function() {
    console.log('Mount');
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      cache: false,
      success: function(data) {
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },
  render: function() {
    var deviceNodes = this.state.data.map(function(device) {
      return (
        <Device name={device.name} status={device.status}></Device>
      );
    });
    return (
      <div className="deviceList">
        {deviceNodes}
      </div>
    );
  }
})

body = $('body');
div = $('<div id="devices">');
body.append(div);

ReactDOM.render(
  <DeviceList url="/devices" />,
  document.getElementById('devices')
);
