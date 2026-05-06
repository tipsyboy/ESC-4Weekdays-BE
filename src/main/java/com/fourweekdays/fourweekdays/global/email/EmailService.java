package com.fourweekdays.fourweekdays.global.email;

import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrder;
import jakarta.mail.MessagingException;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
// 현재 발주는 공급업체 직접 ASN 응답 흐름으로 전환 중이라 메일 발송 빈을 비활성화한다.
public class EmailService {

    private final EmailSender emailSender;

    public void sendPurchaseOrderMail(PurchaseOrder order) throws MessagingException {
        String to = "tipsyboy2025@gmail.com";
        String subject = "[발주서 승인] " + order.getOrderCode();
        String body = EmailBodyBuilder.buildPurchaseOrderBody(order);

        emailSender.send(to, subject, body);
    }
}
