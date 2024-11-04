const prisma = require('@prisma/client').PrismaClient;
const prismaClient = new prisma();

const listAllChats = async (req, res) => {
    const chats = await prismaClient.chat.findMany();
    res.json(chats);
};

const addChat = async (req, res) => {
    const { content, sender_id, to_id } = req.body;
    const newChat = await prismaClient.chat.create({
        data: {
            content,
            sender_id: parseInt(sender_id),
            to_id: parseInt(to_id)
        }
    });
    res.json(newChat);
};

const updateChat = async (req, res) => {
    const { id } = req.params;
    const { content } = req.body;
    const updatedChat = await prismaClient.chat.update({
        where: { id: parseInt(id) },
        data: { content }
    });
    res.json(updatedChat);
};

const deleteChat = async (req, res) => {
    const { id } = req.params;
    await prismaClient.chat.delete({ where: { id: parseInt(id) } });
    res.json({ message: 'Chat deleted' });
};

module.exports = {
    listAllChats,
    addChat,
    updateChat,
    deleteChat
};
