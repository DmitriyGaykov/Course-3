import { createTransport } from 'nodemailer';

export const send = async (recipient, sender, password, message) => {
    try {
        const transporter = createTransport({
            service: 'gmail',
            auth: {
                user: sender,
                pass: password
            }
        })

        const mailOptions = {
            from: sender,
            to: recipient,
            subject: 'Recvy Messenger',
            text: message
        }

        await transporter.sendMail(mailOptions);
        return 1;
    } catch (e) {
        console.log(e);
        return 0;
    }
}