var Device = React.createClass({
  render: function() {
    return (
      <div className="device">
        {this.props.name} - {this.props.status ? 'on' : 'off'}
      </div>
    );
  }
});
