package com.fourweekdays.fourweekdays.asn.domain;

import com.fourweekdays.fourweekdays.global.response.BaseEntity;
import com.fourweekdays.fourweekdays.purchaseorder.domain.PurchaseOrder;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Asn extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "asn_code", nullable = false, unique = true, length = 50)
    private String asnNumber;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "purchase_order_id")
    private PurchaseOrder purchaseOrder;

    @Column(name = "expected_date", nullable = false)
    private LocalDateTime expectedArrivalAt;

    private LocalDateTime receivedAt;

    @Enumerated(EnumType.STRING)
    @Column(nullable = false, length = 20, columnDefinition = "varchar(20)")
    private AsnStatus status;

    @Column(length = 100)
    private String vehicleInfo;

    @Column(length = 100)
    private String contactName;

    @Column(length = 20)
    private String contactPhoneNumber;

    @Column(name = "description", length = 1000)
    private String note;

    @OneToMany(mappedBy = "asn", cascade = CascadeType.ALL, orphanRemoval = true)
    private final List<AsnItem> items = new ArrayList<>();

    @Builder
    public Asn(
            String asnNumber,
            PurchaseOrder purchaseOrder,
            LocalDateTime expectedArrivalAt,
            LocalDateTime receivedAt,
            AsnStatus status,
            String vehicleInfo,
            String contactName,
            String contactPhoneNumber,
            String note
    ) {
        this.asnNumber = asnNumber;
        this.purchaseOrder = purchaseOrder;
        this.expectedArrivalAt = expectedArrivalAt;
        this.receivedAt = receivedAt;
        this.status = status;
        this.vehicleInfo = vehicleInfo;
        this.contactName = contactName;
        this.contactPhoneNumber = contactPhoneNumber;
        this.note = note;
    }

    public void addItem(AsnItem item) {
        items.add(item);
        item.assignAsn(this);
    }

    public void markReceived(LocalDateTime receivedAt) {
        this.status = AsnStatus.RECEIVED;
        this.receivedAt = receivedAt;
    }

    public void markScheduled() {
        this.status = AsnStatus.SCHEDULED;
    }

    public void markRejected() {
        this.status = AsnStatus.REJECTED;
    }

    public AsnStatus getStatus() {
        if (status == AsnStatus.ACCEPTED) {
            return AsnStatus.SCHEDULED;
        }

        return status;
    }
}
