package com.fourweekdays.fourweekdays.common.email;

import jakarta.mail.MessagingException;

public interface EmailSender {

    void send(String to, String subject, String body) throws MessagingException;
}
