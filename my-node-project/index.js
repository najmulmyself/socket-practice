const http = require("http");
const socketIo = require("socket.io");

const PORT = 3000;

const server = http.createServer((req, res) => {
  res.writeHead(200, { "Content-Type": "text/plain" });
  res.end("Hello, Node.js Server!");
});

const io = socketIo(server);

let usernames = {}; // Store usernames and their corresponding sockets

io.on("connect", (socket) => {
  console.log("A user connected");

  // Listen for setting the username
  socket.on("set_username", (data) => {
    const username = data;
    console.log(`User "${username}" connected`);
    usernames[socket.id] = username; // Store the username with the socket id
  });

  // Listen for chat messages
  socket.on("chat_message", (message) => {
    const username = usernames[socket.id]; // Retrieve the username from the socket id
    console.log(`Message received from "${username}":`, message);

    // Broadcast the message with the username to all connected clients (including the sender)
    io.emit("chat_message", { username, message });
  });

  // Listen for disconnection
  socket.on("disconnect", () => {
    const username = usernames[socket.id]; // Retrieve the username from the socket id
    console.log(`User "${username}" disconnected`);
    delete usernames[socket.id]; // Remove the username when the socket disconnects
  });
});

server.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
