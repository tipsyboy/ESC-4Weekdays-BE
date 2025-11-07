package com.fourweekdays.fourweekdays.common.email;

import com.fourweekdays.fourweekdays.product.model.entity.Product;
import com.fourweekdays.fourweekdays.purchaseorder.model.entity.PurchaseOrder;

public class EmailBodyBuilder {
    public static String buildPurchaseOrderBody(PurchaseOrder order) {
        StringBuilder itemsTable = new StringBuilder();

        order.getProducts().forEach(item -> {
            Product product = item.getProduct();
            itemsTable.append(String.format("""
            <tr>
                <td style="border:1px solid #ccc; padding:8px;">%s</td>
                <td style="border:1px solid #ccc; padding:8px;">%s</td>
                <td style="border:1px solid #ccc; padding:8px; text-align:right;">₩ %,d</td>
                <td style="border:1px solid #ccc; padding:8px; text-align:center;">%d</td>
                <td style="border:1px solid #ccc; padding:8px; text-align:right;">₩ %,d</td>
            </tr>
            """,
                    product.getName(),
                    product.getProductCode(),
                    product.getUnitPrice(),
                    item.getOrderedQuantity(),
                    item.calculateAmount()));
        });

        return """
        <html>
        <body style="font-family:'Pretendard', Arial, sans-serif; color:#333; line-height:1.6; font-size:14px;">
            <p>안녕하세요, <b>%s</b> 담당자님.</p>

            <p>
                당사에서 아래와 같이 제품을 발주드립니다.<br>
                확인 후 납기 일정 회신 부탁드립니다.
            </p>

            <table style="border-collapse:collapse; width:100%%; margin:20px 0; font-size:14px;">
                <tbody>
                    <tr style="background-color:#f5f5f5;">
                        <td style="border:1px solid #ccc; padding:8px; width:150px;">발주번호</td>
                        <td style="border:1px solid #ccc; padding:8px;">%s</td>
                    </tr>
                    <tr>
                        <td style="border:1px solid #ccc; padding:8px;">발주일자</td>
                        <td style="border:1px solid #ccc; padding:8px;">%s</td>
                    </tr>
                    <tr>
                        <td style="border:1px solid #ccc; padding:8px;">총 금액</td>
                        <td style="border:1px solid #ccc; padding:8px;">₩ %s</td>
                    </tr>
                </tbody>
            </table>

            <h4 style="margin-top:30px; font-size:15px;">📦 발주 품목 내역</h4>

            <table style="border-collapse:collapse; width:100%%; font-size:14px;">
                <thead>
                    <tr style="background-color:#f5f5f5;">
                        <th style="border:1px solid #ccc; padding:8px; text-align:left;">상품명</th>
                        <th style="border:1px solid #ccc; padding:8px; text-align:left;">상품코드</th>
                        <th style="border:1px solid #ccc; padding:8px; text-align:right;">단가</th>
                        <th style="border:1px solid #ccc; padding:8px; text-align:center;">수량</th>
                        <th style="border:1px solid #ccc; padding:8px; text-align:right;">합계</th>
                    </tr>
                </thead>
                <tbody>
                    %s
                </tbody>
            </table>

            <p style="margin-top:25px;">
                감사합니다.<br>
                <b>㈜포위크데이즈 담당자 드림</b>
            </p>

            <hr style="margin:30px 0; border:none; border-top:1px solid #ddd;">
            <p style="font-size:12px; color:#777;">
                ※ 본 메일은 시스템에 의해 자동 발송되었습니다. 문의사항은 담당자에게 직접 연락 부탁드립니다.
            </p>
        </body>
        </html>
        """.formatted(
                order.getVendor().getName(),
                order.getOrderCode(),
                order.getOrderDate().toLocalDate(),
                order.getTotalAmount(),
                itemsTable
        );
    }

}
