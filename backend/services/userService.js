const db = require('./db');

async function addUser(user){
    if(!user || !user.username){
        throw new Error('Missing or invalid user');
    }

    const queryStmt = `INSERT INTO user (username, role, name, phone) VALUES (?, ?, ?, ?)`;
    const values = [user.username, user.role, user.name, user.phone];
    const result = await db.query(queryStmt, values);

    let message = 'Error in inserting a user';

    if(result.affectedRows){
        message = `${user.username} added to users`;
    }

    return {message};
}

async function updatePhone(username, phone){
    const result = await db.query('UPDATE user SET phone = ? WHERE username = ?', [phone, username]);
    let message = 'Error in updating phone';

    if(result.affectedRows){
        message = `phone updated to ${phone} for ${username}`;
    }

    return {message};
}

async function updateName(username, name){
    const result = await db.query('UPDATE user SET name = ? WHERE username = ?', [name, username]);
    let message = 'Error in updating name';

    if(result.affectedRows){
        message = `name updated to ${name} for ${username}`;
    }

    return {message};
}

async function getProfile(username){
    const result = await db.query('SELECT * FROM user WHERE username = ?', [username]);
    let message = 'Error in getting profile';

    if(result.length){
        message = result;
    }

    return {message};
}

module.exports = {
    addUser,
    updatePhone,
    updateName,
    getProfile
}