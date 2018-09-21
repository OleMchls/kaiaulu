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
    this.setState({
      images: {
        ...this.state.images,
        [resp.clientId]: resp.src
      }
    })
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
    this.capture()
  }

  render () {
    return (
      <div>
        <ul className="imageList">
        {Object.keys(this.state.images).map(key =>
          <li className="imageWrapper" key={`${key}-1`}><img src={this.state.images[key]}/></li>
        )}
        </ul>
        <Webcam
          className="capture"
          ref={this.setRef}
          screenshotFormat='image/jpeg'
          audio={false}
        />
      </div>
    )
  }
}

export default PicChat
