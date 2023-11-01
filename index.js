// node server which will handle socket io connections

const io = require('socket.io')(8000)

const users = {};

io.on('connection', socket => {
    console.log("Connected Successfully", socket.id);

    // var name = prompt("Enter your name to join");
    socket.on('new-user-joined' ,name => {
        users[socket.id] = name;
        console.log(name);

        socket.broadcast.emit('user-joined', name);
    });

    socket.on('send', message => {
        // message.
        message['name'] = users[message['sentByMe']]['name'];
        console.log(users[message['sentByMe']]['name']);
        socket.broadcast.emit('receive', message);//{message : message, name: users[socket.id]})
        // socket.broadcast.emit('sender-name',users[message['sentByMe']]);
    });

    socket.on('disconnect', reason => {
        socket.broadcast.emit('left', users[socket.id]);
        delete users[socket.id];
    })
})