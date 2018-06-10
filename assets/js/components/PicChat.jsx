import React, { Component } from 'react'
import Webcam from 'react-webcam'
import UUID from 'basic-uuid'
import socket from '../socket'

class PicChat extends Component {

  setRef = (webcam) => {
    this.webcam = webcam;
  }

  capture = () => {
    this.channel.push('shout', {
      src: this.webcam.getScreenshot(),
      clientId: this.clientId
    })
  }

  newImage = (resp) => {
    this.setState({images: {[resp.clientId]: resp.src}})
  }

  constructor(props) {
    super(props)

    this.clientId = UUID.randomUUID().getId()
    this.channel = null
    this.state = {
      images: {}
    }
  }

  componentDidMount() {
    // Now that you are connected, you can join channels with a topic:
    this.channel = socket.channel('room:dnsimple', {})
    this.channel.join()
      .receive('ok', resp => { console.log('Joined successfully', resp) })
      .receive('error', resp => { console.log('Unable to join', resp) })

    this.channel.on("shout", this.newImage)

    let intervalID = setInterval(this.capture, 10000)
  }

  render () {
    return (
      <div>
        <ul>
        {Object.keys(this.state.images).map(key =>
          <img key={key} src={this.state.images[key]}/>
        )}
        </ul>
        <Webcam
          ref={this.setRef}
          screenshotFormat='image/jpeg'
        />
      </div>
    )
  }
}

export default PicChat
