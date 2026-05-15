package com.fourweekdays.fourweekdays.inventory.domain;

import com.fourweekdays.fourweekdays.global.response.BaseEntity;
import com.fourweekdays.fourweekdays.inbound.domain.Inbound;
import com.fourweekdays.fourweekdays.inventory.exception.InventoryException;
import com.fourweekdays.fourweekdays.location.domain.Location;
import com.fourweekdays.fourweekdays.product.domain.Product;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Index;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import java.time.LocalDateTime;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import static com.fourweekdays.fourweekdays.inventory.exception.InventoryExceptionType.INSUFFICIENT_INVENTORY;
import static com.fourweekdays.fourweekdays.inventory.exception.InventoryExceptionType.INVALID_QUANTITY;

@Table(
        name = "inventory",
        indexes = {
                @Index(
                        name = "idx_inv_prod_loc_inb_qty_created",
                        columnList = "product_id, location_id, inbound_id, quantity, created_at"
                ),
                @Index(
                        name = "idx_inv_prod_created",
                        columnList = "product_id, created_at"
                )
        }
)
@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Inventory extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "product_id")
    private Product product;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "location_id")
    private Location location;

    @Column(length = 50)
    private String lotNumber;

    @Column(nullable = false)
    private Integer quantity;

    @Column(nullable = false)
    private Integer availableQuantity;

    @Column(nullable = false)
    private Integer holdQuantity;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "inbound_id")
    private Inbound lastInbound;

    private LocalDateTime lastInboundAt;

    @Column(length = 1000)
    private String description;

    @Builder
    public Inventory(
            Product product,
            Location location,
            String lotNumber,
            Integer quantity,
            Integer availableQuantity,
            Integer holdQuantity,
            Inbound lastInbound,
            LocalDateTime lastInboundAt,
            String description
    ) {
        this.product = product;
        this.location = location;
        this.lotNumber = lotNumber;
        this.quantity = quantity != null ? quantity : 0;
        this.availableQuantity = availableQuantity != null ? availableQuantity : this.quantity;
        this.holdQuantity = holdQuantity != null ? holdQuantity : 0;
        this.lastInbound = lastInbound;
        this.lastInboundAt = lastInboundAt;
        this.description = description;
    }

    public void increase(Integer receivedQuantity, Integer defectQuantity, Inbound inbound, LocalDateTime inboundAt) {
        int received = receivedQuantity != null ? receivedQuantity : 0;
        int defect = defectQuantity != null ? defectQuantity : 0;
        int available = Math.max(received - defect, 0);

        if (received < 0 || defect < 0) {
            throw new InventoryException(INVALID_QUANTITY);
        }

        this.location.increaseUsedCapacity(received);
        this.quantity += received;
        this.availableQuantity += available;
        this.holdQuantity += defect;
        this.lastInbound = inbound;
        this.lastInboundAt = inboundAt;
    }

    public void increaseQuantity(int amount) {
        if (amount <= 0) {
            throw new InventoryException(INVALID_QUANTITY);
        }
        this.location.increaseUsedCapacity(amount);
        this.quantity += amount;
        this.availableQuantity += amount;
    }

    public void decreaseQuantity(int amount) {
        if (amount <= 0) {
            throw new InventoryException(INVALID_QUANTITY);
        }
        if (this.quantity < amount || this.availableQuantity < amount) {
            throw new InventoryException(INSUFFICIENT_INVENTORY);
        }
        this.quantity -= amount;
        this.availableQuantity -= amount;
        this.location.decreaseUsedCapacity(amount);
    }

    public void decrease(int deducted) {
        if (deducted < 0) {
            throw new InventoryException(INVALID_QUANTITY);
        }
        if (this.quantity < deducted || this.availableQuantity < deducted) {
            throw new InventoryException(INSUFFICIENT_INVENTORY);
        }
        this.quantity -= deducted;
        this.availableQuantity -= deducted;
    }

    public void increase(int quantity) {
        if (quantity < 0) {
            throw new InventoryException(INVALID_QUANTITY);
        }
        this.quantity += quantity;
        this.availableQuantity += quantity;
    }

    public Integer getAvailableQuantity() {
        if (availableQuantity != null) {
            if (availableQuantity > 0 || quantity == null || quantity <= 0 || getHoldQuantity() > 0) {
                return availableQuantity;
            }
        }
        return quantity != null ? quantity : 0;
    }

    public Integer getHoldQuantity() {
        return holdQuantity != null ? holdQuantity : 0;
    }

    public Inbound getInbound() {
        return lastInbound;
    }
}
