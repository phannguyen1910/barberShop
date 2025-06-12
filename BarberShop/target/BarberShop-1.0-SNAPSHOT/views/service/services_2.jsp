<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Chọn Dịch Vụ - CUT & STYLES | Premium Barber Services</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/services.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    </head>
    <body>
        <%@ include file="/views/common/navbar.jsp" %>

        <!-- Main Content -->
        <div class="main-container">
            <!-- Header -->
            <div class="header">
                <h1 class="main-title">Chọn Dịch Vụ Cao Cấp</h1>
                <p class="subtitle">Trải nghiệm dịch vụ chăm sóc nam giới đẳng cấp với công nghệ hiện đại tại Cut&Styles Barber</p>
                <div class="search-container">
                    <span class="search-icon">🔍</span>
                    <input type="text" class="search-input" placeholder="Tìm kiếm dịch vụ..." id="searchInput">
                </div>
            </div>

            <!-- Hair Cutting Services -->
            <section class="service-section">
                <div class="section-header">
                    <h2 class="section-title">✂️ Cắt Tóc Chuyên Nghiệp</h2>
                    <p class="section-description">Dịch vụ cắt tóc cao cấp với kỹ thuật tinh tế, phong cách hiện đại</p>
                </div>
                <div class="services-grid">
                    <div class="service-card">
                        <div class="service-header-section">
                            <div class="service-info">
                                <h3 class="service-title">Cắt gội thương gia</h3>
                                <p class="service-description">Cắt tóc cơ bản với kỹ thuật chuyên nghiệp, phù hợp mọi lứa tuổi, tạo kiểu tự nhiên</p>
                            </div>
                            <div class="service-price">499,000 VNĐ</div>
                        </div>
                        <div class="service-images">
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/thuongGia1.png" alt="Cắt tóc"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/thuongGia.png" alt="Cắt tóc"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/hutMun.png" alt="Tạo kiểu"></div>
                        </div>
                        <div class="service-duration">90 Phút</div>
                        <button class="add-to-cart" onclick="addToCart('Cắt gội khoang thương gia', 390000, 'haircut')">Thêm Vào Đơn</button>
                    </div>
                    <div class="service-card">
                        <div class="service-header-section">
                            <div class="service-info">
                                <h3 class="service-title">Cắt gội Combo 1</h3>
                                <p class="service-description">Cắt tóc cao cấp với tư vấn phong cách và tạo kiểu chuyên nghiệp, phù hợp với xu hướng</p>
                            </div>
                            <div class="service-price">99,000 VNĐ</div>
                        </div>
                        <div class="service-images">
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/catToc.png" alt="Cắt tóc"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/doiNuoc.png" alt="Cắt tóc"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/hutMun.png" alt="Tạo kiểu"></div>
                        </div>
                        <div class="service-duration">45 Phút</div>
                        <button class="add-to-cart" onclick="addToCart('Cắt gội Combo 1', 99000, 'haircut')">Thêm Vào Đơn</button>
                    </div>
                    <div class="service-card">
                        <div class="service-header-section">
                            <div class="service-info">
                                <h3 class="service-title">Cắt gội Combo 2</h3>
                                <p class="service-description">Cắt tóc bởi thợ chính với kỹ thuật cao cấp, phong cách độc quyền, tạo ấn tượng mạnh</p>
                            </div>
                            <div class="service-price">199,000 VNĐ</div>
                        </div>
                        <div class="service-images">
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/combo2.2.png" alt="Cắt tóc"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/combo2.1.png" alt="Cắt tóc"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/combo2.png" alt="Tạo kiểu"></div>
                        </div>
                        <div class="service-duration">55 Phút</div>
                        <button class="add-to-cart" onclick="addToCart('Cắt gội Combo 2', 199000, 'haircut')">Thêm Vào Đơn</button>
                    </div>
                    <div class="service-card">
                        <div class="service-header-section">
                            <div class="service-info">
                                <h3 class="service-title">Cắt gội Combo 3</h3>
                                <p class="service-description">Cắt tóc bởi thợ chính với kỹ thuật cao cấp, phong cách độc quyền, tạo ấn tượng mạnh</p>
                            </div>
                            <div class="service-price">299,000 VNĐ</div>
                        </div>
                        <div class="service-images">
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/combo3_main.png" alt="Cắt tóc"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/combo3_sub1.png" alt="Cắt tóc"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/combo3_sub2.png" alt="Tạo kiểu"></div>
                        </div>
                        <div class="service-duration">65 Phút</div>
                        <button class="add-to-cart" onclick="addToCart('Cắt gội Combo 3', 299000, 'haircut')">Thêm Vào Đơn</button>
                    </div>
                    <div class="service-card">
                        <div class="service-header-section">
                            <div class="service-info">
                                <h3 class="service-title">Cắt gội Combo 4</h3>
                                <p class="service-description">Cắt tóc bởi thợ chính với kỹ thuật cao cấp, phong cách độc quyền, tạo ấn tượng mạnh</p>
                            </div>
                            <div class="service-price">399,000 VNĐ</div>
                        </div>
                        <div class="service-images">
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/combo4_main.png" alt="Cắt tóc"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/combo4_sub1.png" alt="Cắt tóc"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/catToc.png" alt="Tạo kiểu"></div>
                        </div>
                        <div class="service-duration">75 Phút</div>
                        <button class="add-to-cart" onclick="addToCart('Cắt gội Combo 4', 399000, 'haircut')">Thêm Vào Đơn</button>
                    </div>
                </div>
            </section>

            <!--<!-- Uon toc -->
            <section class="service-section">
                <div class="section-header">
                    <h2 class="section-title">✂️ Uốn Định Hình Nếp Tóc</h2>
                    <p class="section-description">Dịch vụ uốn tóc cao cấp với kỹ thuật tinh tế, phong cách hiện đại</p>
                </div>
                <div class="services-grid">
                    <div class="service-card">
                        <div class="service-header-section">
                            <div class="service-info">
                                <h3 class="service-title">Uốn tiêu chuẩn</h3>
                                <p class="service-description">Uốn tóc cơ bản với kỹ thuật chuyên nghiệp, phù hợp mọi lứa tuổi, tạo kiểu tự nhiên</p>
                            </div>
                            <div class="service-price">379,000 VNĐ</div>
                        </div>
                        <div class="service-images">
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/uon_tieu_chuan_main.png" alt="Cắt tóc"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/uon_tieu_chuan_sub1.png" alt="Cắt tóc"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/uon_tieu_chuan_sub2.png" alt="Tạo kiểu"></div>
                        </div>
                        <div class="service-duration">90 Phút</div>
                        <button class="add-to-cart" onclick="addToCart('Uon tieu chuan', 37900, 'haircut')">Thêm Vào Đơn</button>
                    </div>
                    <div class="service-card">
                        <div class="service-header-section">
                            <div class="service-info">
                                <h3 class="service-title">Uốn cao cấp</h3>
                                <p class="service-description">Uốn tóc cao cấp với tư vấn phong cách và tạo kiểu chuyên nghiệp, phù hợp với xu hướng</p>
                            </div>
                            <div class="service-price">499,000 VNĐ</div>
                        </div>
                        <div class="service-images">
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/uon_cao_cap_main.png" alt="Cắt tóc"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/uon_cao_cap_sub1.png" alt="Cắt tóc"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/uon_cao_cap_sub2.png" alt="Tạo kiểu"></div>
                        </div>
                        <div class="service-duration">120 Phút</div>
                        <button class="add-to-cart" onclick="addToCart('Uon cao cap', 499000, 'haircut')">Thêm Vào Đơn</button>
                    </div>
                </div>
            </section>


            <!--nhuom toc -->

            <section class="service-section">
                <div class="section-header">
                    <h2 class="section-title">✂️Thay Đổi Màu Tóc</h2>
                    <p class="section-description">Dịch vụ nhuộm tóc cao cấp với kỹ thuật tinh tế, phong cách hiện đại</p>
                </div>
                <div class="services-grid">
                    <div class="service-card">
                        <div class="service-header-section">
                            <div class="service-info">
                                <h3 class="service-title">Nhuộm tiêu chuẩn</h3>
                                <p class="service-description">Nhuộm tóc cơ bản với kỹ thuật chuyên nghiệp, phù hợp mọi lứa tuổi, tạo kiểu tự nhiên</p>
                            </div>
                            <div class="service-price">199,000 VNĐ</div>
                        </div>
                        <div class="service-images">
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/nhuom_tieu_chuan_main.png" alt="Cắt tóc"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/nhuom_tieu_chuan_sub1.png" alt="Cắt tóc"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/nhuom_tieu_chuan_sub2.png" alt="Tạo kiểu"></div>
                        </div>
                        <div class="service-duration">30 Phút</div>
                        <button class="add-to-cart" onclick="addToCart('Nhuom tieu chuan', 199000, 'haircut')">Thêm Vào Đơn</button>
                    </div>
                    <div class="service-card">
                        <div class="service-header-section">
                            <div class="service-info">
                                <h3 class="service-title">Nhuộm cao cấp</h3>
                                <p class="service-description">Nhuộm tóc cao cấp với tư vấn phong cách và tạo kiểu chuyên nghiệp, phù hợp với xu hướng</p>
                            </div>
                            <div class="service-price">329,000 VNĐ</div>
                        </div>
                        <div class="service-images">
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/nhuom_cao_cap_main.png" alt="Cắt tóc"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/nhuom_cao_cap_sub1.png" alt="Cắt tóc"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/nhuom_cao_cap_sub2.png" alt="Tạo kiểu"></div>
                        </div>
                        <div class="service-duration">45 Phút</div>
                        <button class="add-to-cart" onclick="addToCart('Nhuom cao cap', 329000, 'haircut')">Thêm Vào Đơn</button>
                    </div>
                </div>
            </section>

            <!-- Spa & Relaxation Services -->
            <section class="service-section">
                <div class="section-header">
                    <h2 class="section-title">🧘 Spa & Thư Giãn</h2>
                    <p class="section-description">Dịch vụ spa và thư giãn giúp bạn tái tạo năng lượng và chăm sóc toàn diện</p>
                </div>
                <div class="services-grid">
                    <div class="service-card">
                        <div class="service-header-section">
                            <div class="service-info">
                                <h3 class="service-title">Gội Combo 1 </h3>
                                <p class="service-description">Massage thư giãn cổ vai gáy, giảm căng thẳng, cải thiện tuần hoàn máu</p>
                            </div>
                            <div class="service-price">50,000 VNĐ</div>
                        </div>
                        <div class="service-images">
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/massageCombo1_main.png" alt="Massage"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/massageCombo1_sub1.png" alt="Massage"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/massageCombo1_sub2.png"  alt="Massage"></div>
                        </div>
                        <div class="service-duration">20 Phút</div>
                        <button class="add-to-cart" onclick="addToCart('Goi COmbo 1', 50000, 'spa')">Thêm Vào Đơn</button>
                    </div>
                    <div class="service-card">
                        <div class="service-header-section">
                            <div class="service-info">
                                <h3 class="service-title">Gội Combo 2</h3>
                                <p class="service-description">Chăm sóc da mặt chuyên sâu, làm sạch và dưỡng da, mang lại làn da tươi sáng</p>
                            </div>
                            <div class="service-price">159,000 VNĐ</div>
                        </div>
                        <div class="service-images">
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/massageCombo2_main.png" alt="Spa mặt"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/massageCombo2_sub1.png" alt="Spa mặt"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/massageCombo1_main.png" alt="Spa mặt"></div>
                        </div>
                        <div class="service-duration">30 Phút</div>
                        <button class="add-to-cart" onclick="addToCart('Goi COmbo 2', 159000, 'spa')">Thêm Vào Đơn</button>
                    </div>
                    <div class="service-card">
                        <div class="service-header-section">
                            <div class="service-info">
                                <h3 class="service-title">Gội Combo 3</h3>
                                <p class="service-description">Chăm sóc da mặt chuyên sâu, làm sạch và dưỡng da, mang lại làn da tươi sáng</p>
                            </div>
                            <div class="service-price">219,000 VNĐ</div>
                        </div>
                        <div class="service-images">
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/massageCombo3_main.png" alt="Spa mặt"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/massageCombo3_sub1.png" alt="Spa mặt"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/massageCombo3_sub2.png" alt="Spa mặt"></div>
                        </div>
                        <div class="service-duration">35 Phút</div>
                        <button class="add-to-cart" onclick="addToCart('Goi COmbo 3', 219000, 'spa')">Thêm Vào Đơn</button>
                    </div>
                </div>
            </section>

            <!-- Ear Cleaning Services -->
            <section class="service-section">
                <div class="section-header">
                    <h2 class="section-title">👂 Dịch Vụ Lấy Ráy Tai</h2>
                    <p class="section-description">Dịch vụ lấy ráy tai an toàn, sạch sẽ, mang lại cảm giác thoải mái và dễ chịu</p>
                </div>
                <div class="service-card">
                    <div class="service-header-section">
                        <div class="service-info">
                            <h3 class="service-title">Lấy Ráy Tai Combo</h3>
                            <p class="service-description">Lấy ráy tai chuyên sâu, kết hợp massage tai nhẹ nhàng, mang lại cảm giác thư giãn</p>
                        </div>
                        <div class="service-price">70,000 VNĐ</div>
                    </div>
                    <div class="service-images">
                        <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/layRayTai_main.png"  alt="Ear Cleaning"></div>
                        <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/layRayTai_sub1.png" alt="Ear Cleaning"></div>
                        <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/layRayTai_sub2.png" alt="Ear Cleaning"></div>
                    </div>
                    <div class="service-duration">30 Phút</div>
                    <button class="add-to-cart" onclick="addToCart('Lấy Ráy Tai Combo', 70000, 'earcleaning')">Thêm Vào Đơn</button>
                </div>
            </section>

            <!-- Footer -->
            <footer class="footer">
                <div class="footer-container">
                    <div class="footer-logo-section">
                        <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png"  alt="Cut&Styles Logo" class="footer-logo">
                    </div>
                    <div class="footer-links-section">
                        <h4 class="footer-title">Liên kết nhanh</h4>
                        <ul class="footer-links">
                            <li><a href="${pageContext.request.contextPath}/views/common/aboutUs.jsp">Về chúng tôi</a></li>
                            <li><a href="${pageContext.request.contextPath}/views/common/franchise.jsp">Liên hệ nhượng quyền</a></li>
                            <li><a href="${pageContext.request.contextPath}/views/commit/support.jsp">Chính sách cam kết</a></li>
                        </ul>
                    </div>
                    <div class="footer-contact-section">
                        <h4 class="footer-title">Thông tin liên hệ</h4>
                        <div class="footer-contact">
                            <p><i class="bi bi-geo-alt-fill"></i> Khu đô thị FPT city, Hòa Hải, Ngũ Hành Sơn, Đà Nẵng</p>
                            <p><i class="bi bi-telephone-fill"></i> 0774511941</p>
                            <p><i class="bi bi-clock-fill"></i> Thứ 2 đến Chủ Nhật, 8h30 - 20h30</p>
                        </div>
                    </div>
                </div>
                <div class="footer-bottom">
                    <p>© 2025 Cut&Styles Barber. Tất cả quyền được bảo lưu.</p>
                </div>
            </footer>
        </div>

        <!-- Cart Summary -->
        <div class="cart-summary" id="cartSummary">
            <div class="cart-header" onclick="toggleCart(event)">
                <span class="cart-title">Đơn Đặt Dịch Vụ</span>
                <span class="cart-count" id="cartCount">0</span>
            </div>
            <div class="cart-items" id="cartItems"></div>
            <div class="cart-total" id="cartTotal">Tổng: 0 VNĐ</div>
            <button class="checkout-btn" onclick="checkout(event)">Đặt Lịch Ngay</button>
        </div>

        <script>
            let cart = [];
            let isCartOpen = false;

            // Initialize cart on page load
            window.onload = function () {
                const savedCart = sessionStorage.getItem("selectedServices");
                if (savedCart) {
                    cart = JSON.parse(savedCart);
                }
                updateCart();
            };

            function addToCart(serviceName, price, category) {
                const service = {name: serviceName, price: price, category: category};
                cart.push(service);
                sessionStorage.setItem("selectedServices", JSON.stringify(cart));
                updateCart();

                // Update button state
                const button = event.currentTarget;
                button.classList.add('added');
                button.textContent = 'Đã Thêm ✓';
                setTimeout(() => {
                    button.classList.remove('added');
                    button.textContent = 'Thêm Vào Đơn';
                }, 2000);
            }

            function updateCart() {
                const cartItems = document.getElementById('cartItems');
                const cartCount = document.getElementById('cartCount');
                const cartTotal = document.getElementById('cartTotal');
                const cartSummary = document.getElementById('cartSummary');

                cartItems.innerHTML = '';
                let total = 0;

                if (cart.length > 0) {
                    cart.forEach((item) => {
                        total += item.price;
                        const cartItem = document.createElement('div');
                        cartItem.className = 'cart-item';
                        cartItem.innerHTML = `<span>${item.name}</span><span>${item.price.toLocaleString('vi-VN')} VNĐ</span>`;
                        cartItems.appendChild(cartItem);
                    });
                    cartItems.style.borderTop = '1px solid rgba(212, 175, 55, 0.2)';
                    cartItems.style.paddingTop = '0.5rem';
                } else {
                    cartItems.innerHTML = '<span style="color: #d1d5db;">Chưa có dịch vụ nào được chọn.</span>';
                }

                cartCount.textContent = cart.length;
                cartTotal.textContent = `Tổng: ${total.toLocaleString('vi-VN')} VNĐ`;

                if (cart.length > 0) {
                    cartSummary.classList.add('active');
                } else {
                    cartSummary.classList.remove('active');
                    isCartOpen = false;
                }
            }

            function toggleCart(event) {
                event.stopPropagation();
                const cartSummary = document.getElementById('cartSummary');
                isCartOpen = !isCartOpen;
                if (isCartOpen) {
                    cartSummary.classList.add('active');
                } else {
                    cartSummary.classList.remove('active');
                }
            }

            function checkout(event) {
                event.stopPropagation();
                if (cart.length === 0) {
                    alert('Vui lòng chọn ít nhất một dịch vụ!');
                    return;
                }
                sessionStorage.setItem('selectedServices', JSON.stringify(cart));
                window.location.href = "${pageContext.request.contextPath}/views/booking/booking.jsp";
            }

            document.getElementById('searchInput').addEventListener('input', function (e) {
                const searchTerm = e.target.value.toLowerCase();
                const serviceCards = document.querySelectorAll('.service-card, .combo-card');

                serviceCards.forEach(card => {
                    const title = card.querySelector('.service-title').textContent.toLowerCase();
                    const description = card.querySelector('.service-description').textContent.toLowerCase();

                    if (title.includes(searchTerm) || description.includes(searchTerm)) {
                        card.style.display = '';
                        card.style.opacity = '1';
                    } else {
                        card.style.display = 'none';
                        card.style.opacity = '0';
                    }
                });
            });
        </script>
    </body>
</html>