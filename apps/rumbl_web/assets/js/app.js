// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

import "phoenix_html"
import Video from './video'
import socket from "./socket"

const video = document.getElementById("video")
Video.init(socket, video)
