const prisma = require('@prisma/client').PrismaClient;
const prismaClient = new prisma();

const listAllUsers = async (req, res) => {
    const users = await prismaClient.user.findMany();
    res.json(users);
};

const addUser = async (req, res) => {
    const { username, password, email, birth_date } = req.body;
    const newUser = await prismaClient.user.create({
        data: {
            username,
            password,
            email,
            birth_date: new Date(birth_date)
        }
    });
    res.json(newUser);
};

const updateUser = async (req, res) => {
    const { id } = req.params;
    const { username, email, birth_date } = req.body;
    const updatedUser = await prismaClient.user.update({
        where: { id: parseInt(id) },
        data: {
            username,
            email,
            birth_date: new Date(birth_date)
        }
    });
    res.json(updatedUser);
};

const deleteUser = async (req, res) => {
    const { id } = req.params;
    await prismaClient.user.delete({ where: { id: parseInt(id) } });
    res.json({ message: 'User deleted' });
};

module.exports = {
    listAllUsers,
    addUser,
    updateUser,
    deleteUser
};
