const db = require('./db');

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
    const result = await db.query('SELECT username, role, name, phone FROM user WHERE username = ?', [username]);
    let message = 'Error in getting profile';

    if(result.length){
        message = result;
    }

    return {message};
}

module.exports = {
    updatePhone,
    updateName,
    getProfile
}