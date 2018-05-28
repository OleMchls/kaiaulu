import React, { Component } from 'react'
import Webcam from 'react-webcam'
import UUID from 'basic-uuid'
import socket from '../socket'

class PicChat extends Component {

  setRef = (webcam) => {
    this.webcam = webcam;
  }

  capture = () => {
    this.state.channel.push('shout', {
      src: this.webcam.getScreenshot(),
      clientId: this.state.clientId
    })
  }

  newImage = (resp) => {
    this.state.images[resp.clientId] = resp.src
    this.setState(this.state)
  }

  constructor(props) {
    super(props)

    this.state = {
      clientId: UUID.randomUUID().getId(),
      channel: null,
      images: {}
    }
  }

  componentDidMount() {
    // Now that you are connected, you can join channels with a topic:
    let channel = socket.channel('room:dnsimple', {})
    channel.join()
      .receive('ok', resp => { console.log('Joined successfully', resp) })
      .receive('error', resp => { console.log('Unable to join', resp) })

    channel.on("shout", this.newImage)

    let intervalID = setInterval(this.capture, 10000)

    this.state.channel = channel
    this.setState(this.state)
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
