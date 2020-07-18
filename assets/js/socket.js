import { Socket } from 'phoenix'

let socket = new Socket('/socket', {
  params: { token: window.userToken },
  logger: (kind, msg, data) => console.log(`TCL: ${kind}: ${msg}`, data),
})

export default socket
