const nodemailer = require('nodemailer');

function generateOTP() {
    let OTP = "";
    const characters = "0123456789";
    const charactersLength = characters.length;
    for (let i = 0; i < 6; i++) {
        OTP += characters.charAt(Math.floor(Math.random() * charactersLength));
    }
    return OTP;
}

async function sendMail(to, subject, text) {
    transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
            user: process.env.MAIL_USER,
            pass: process.env.MAIL_PASSWORD
        }
    });
    let mailOptions = {
        from: process.env.MAIL_USER,
        to: to,
        subject: subject,
        text: text
    };

    try {
        let info = await transporter.sendMail(mailOptions);
        console.log('Email sent: ' + info.response);
    } catch (error) {
        console.log(error);
    }
}



module.exports = {
    generateOTP,
    sendMail
}
