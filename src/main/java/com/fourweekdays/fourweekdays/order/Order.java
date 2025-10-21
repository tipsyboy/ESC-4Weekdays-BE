package com.fourweekdays.fourweekdays.order;

import com.fourweekdays.fourweekdays.common.BaseEntity;
import com.fourweekdays.fourweekdays.franchise.model.entity.FranchiseStore;
import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "orders")
@Builder
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@AllArgsConstructor
public class Order extends BaseEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long orderId; // 주문 ID

    @ManyToOne
    @JoinColumn(name = "franchise_store_id")
    private FranchiseStore franchiseStore;

    @Enumerated(EnumType.STRING)
    private OrderStatus status; // 주문 상태

    @Builder.Default
    @OneToMany(mappedBy = "order", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<OrderProductItem> items = new ArrayList<>();

    @Column(nullable = false)
    private LocalDateTime orderDate; // 주문일

    @Column(nullable = false)
    private LocalDateTime dueDate;   // 납기일

    @Column(nullable = false)
    private Long totalAmount; // 총 금액

    @Column(length = 1000)
    private String description; // 비고

}
