const express = require('express');
const { PrismaClient } = require('@prisma/client');
const app = express();
const prismaClient = new PrismaClient();

app.set('view engine', 'ejs');
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static('public'));

app.get('/', (req, res) => {
    res.render('index');
});

app.get('/manage-delete', async (req, res) => {
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
        res.status(500).send('Hiba történt az adatok lekérdezésekor.');
    }
});

app.get('/register', (req, res) => {
    res.render('register');
});

app.post('/register', async (req, res) => {
    const { username, email, password, birth_date } = req.body;
    try {
        await prismaClient.user.create({
            data: {
                username: username,
                email: email,
                password: password,
                birth_date: new Date(birth_date),
                created_at: new Date(),
                updated_at: new Date()
            }
        });
        res.redirect('/');
    } catch (error) {
        res.status(500).send('Hiba történt a regisztráció során.');
    }
});

app.get('/send-message', async (req, res) => {
    try {
        const users = await prismaClient.user.findMany();
        res.render('sendMessage', { users });
    } catch (error) {
        res.status(500).send('Hiba történt a felhasználók lekérdezésekor.');
    }
});

app.post('/chat', async (req, res) => {
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
        res.status(500).send('Hiba történt az üzenet létrehozásakor.');
    }
});

app.post('/chat/delete/:id', async (req, res) => {
    const chatId = parseInt(req.params.id);
    try {
        await prismaClient.chat.delete({
            where: { id: chatId }
        });
        res.redirect('/manage-delete');
    } catch (error) {
        res.status(500).send('Hiba történt az üzenet törlésekor.');
    }
});

app.post('/user/delete/:id', async (req, res) => {
    const userId = parseInt(req.params.id);
    try {
        await prismaClient.user.delete({
            where: { id: userId }
        });
        res.redirect('/manage-delete');
    } catch (error) {
        res.status(500).send('Hiba történt a felhasználó törlésekor.');
    }
});

app.get('/chatBetweenUsers', async (req, res) => {
    try {
        const users = await prismaClient.user.findMany();
        
        res.render('chatBetweenUsers', { users, chats: null });
    } catch (error) {
        console.error(error);
        res.status(500).send('Error loading users');
    }
});

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
        res.status(500).send('Error fetching chat');
    }
});


const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Szerver fut a ${PORT} porton.`);
});
