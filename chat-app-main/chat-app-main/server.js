const express = require('express');
const { PrismaClient } = require('@prisma/client');
const app = express();
const prismaClient = new PrismaClient();

app.set('view engine', 'ejs');
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'));

// Home route
app.get('/', (req, res) => {
    res.render('index');
});

// Manage delete route
app.get('/manage-delete', async (req, res) => { // Updated route path
    try {
        const chats = await prismaClient.chat.findMany({
            include: {
                sender: true,
                to: true
            }
        });
        const users = await prismaClient.user.findMany();
        res.render('manageDelete', { chats, users });
    } catch (error) {
        console.error(error);
        res.status(500).send('Error fetching data.');
    }
});

// Registration form route
app.get('/register', (req, res) => {
    res.render('register');
});

// Registration submit route
app.post('/register', async (req, res) => {
    const { username, email, password, birth_date } = req.body;
    
    // Validate and parse birth_date
    let parsedBirthDate;
    try {
        parsedBirthDate = new Date(birth_date);
        if (isNaN(parsedBirthDate)) {
            throw new Error('Invalid birth date');
        }
    } catch (error) {
        console.error('Birth date parsing error:', error);
        return res.status(400).send('Invalid birth date format.');
    }

    try {
        await prismaClient.user.create({
            data: {
                username: username,
                email: email,
                password: password,
                birth_date: parsedBirthDate,
                created_at: new Date(),
                updated_at: new Date()
            }
        });
        res.redirect('/');
    } catch (error) {
        console.error(error); // Log Prisma error details for debugging
        res.status(500).send('Error during registration.');
    }
});

// Send message form route
app.get('/sendmessage', async (req, res) => {
    try {
        const users = await prismaClient.user.findMany();
        res.render('sendmessage', { users });
    } catch (error) {
        console.error(error);
        res.status(500).send('Error fetching users.');
    }
});

// Chat message submit route
app.post('/chat', async (req, res) => { // Updated route path
    const { content, sender_id, to_id } = req.body;
    try {
        await prismaClient.chat.create({
            data: {
                content: content,
                sender_id: parseInt(sender_id),
                to_id: parseInt(to_id),
                created_at: new Date()
            }
        });
        res.redirect('/');
    } catch (error) {
        console.error(error);
        res.status(500).send('Error creating message.');
    }
});

// Delete chat route
app.post('/chat/delete/:id', async (req, res) => {
    const chatId = parseInt(req.params.id);
    try {
        await prismaClient.chat.delete({
            where: { id: chatId }
        });
        res.redirect('/manage-delete');
    } catch (error) {
        console.error(error);
        res.status(500).send('Error deleting message.');
    }
});

// Delete user route
app.post('/user/delete/:id', async (req, res) => {
    const userId = parseInt(req.params.id);
    try {
        await prismaClient.user.delete({
            where: { id: userId }
        });
        res.redirect('/manage-delete');
    } catch (error) {
        console.error(error);
        res.status(500).send('Error deleting user.');
    }
});

// Chat between users route
app.get('/chatBetweenUsers', async (req, res) => {
    try {
        const users = await prismaClient.user.findMany();
        res.render('chatBetweenUsers', { users, chats: null });
    } catch (error) {
        console.error(error);
        res.status(500).send('Error loading users.');
    }
});

// Fetch chat route
app.post('/getChat', async (req, res) => {
    const { sender, receiver } = req.body;

    try {
        const users = await prismaClient.user.findMany();
        const chats = await prismaClient.chat.findMany({
            where: {
                OR: [
                    { sender_id: parseInt(sender), to_id: parseInt(receiver) },
                    { sender_id: parseInt(receiver), to_id: parseInt(sender) }
                ]
            },
            include: {
                sender: true,
                to: true
            },
            orderBy: {
                created_at: 'asc'
            }
        });

        res.render('chatBetweenUsers', { users, chats });
    } catch (error) {
        console.error(error);
        res.status(500).send('Error fetching chat.');
    }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}.`);
});
        