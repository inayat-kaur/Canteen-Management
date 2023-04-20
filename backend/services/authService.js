const db = require('./db');
const help = require('../helper');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

async function signUp(user){
    if(!user || !user.username){
        throw new Error('Missing or invalid user');
    }
    if(help.validateEmail(user.username) == false){
        throw new Error('Invalid email');
    }
    const salt = await bcrypt.genSalt(10);
    const hashedPassword = await bcrypt.hash(user.password, salt);
    const queryStmt = `INSERT INTO user (username, role, name, phone, password) VALUES (?, ?, ?, ?, ?)`;
    const values = [user.username, user.role, user.name, user.phone, hashedPassword];
    const result = await db.query(queryStmt, values);

    let message = 'Error in inserting a user';

    if(result.affectedRows){
        message = `${user.username} added to users`;
    }
    console.log(message);
    return {message};
}

async function login(username,password){
    if(!username){
        throw new Error('Missing or invalid user');
    }
    if(help.validateEmail(username) == false){
        throw new Error('Invalid email');
    }
    const result = await db.query('SELECT password FROM user WHERE username = ?', [username]);
    if(result.length == 0){
        throw new Error('User not found');
    }
    const validPassword = await bcrypt.compare(password, result[0].password);
    if(!validPassword){
        throw new Error('Invalid password');
    }

    const accessToken = jwt.sign({username: username}, process.env.ACCESS_TOKEN_SECRET);
    return accessToken;
}

function authenticateToken(req, res, next){
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];
    if(token == null){
        return res.sendStatus(401);
    }
    jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, (err, user) => {
        if(err){
            return res.sendStatus(403);
        }
        req.user = user;
        next();
    });
}

module.exports = {
    signUp,
    login,
    authenticateToken
};