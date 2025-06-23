<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
        <style>
            /* Reset và base styles */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            body {
                font-family: 'Noto Sans', sans-serif;
                background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
                min-height: 100vh;
            }

            /* Main container */
            .main-container {
                padding: 40px 20px;
                min-height: 100vh;
            }

            /* Header section */
            .header {
                text-align: center;
                margin-bottom: 60px;
                padding: 0 20px;
            }

            .main-title {
                font-size: 3.5rem;
                font-weight: 700;
                background: linear-gradient(135deg, #2c2c2c 0%, #1a1a1a 100%);
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                background-clip: text;
                margin-bottom: 1rem;
                letter-spacing: -2px;
            }

            .subtitle {
                font-size: 1.2rem;
                color: #666;
                margin-bottom: 2rem;
                line-height: 1.6;
                max-width: 600px;
                margin-left: auto;
                margin-right: auto;
            }

            /* Search container */
            .search-container {
                position: relative;
                max-width: 500px;
                margin: 0 auto;
            }

            .search-input {
                width: 100%;
                padding: 15px 20px 15px 50px;
                border: 2px solid #ddd;
                border-radius: 30px;
                font-size: 1.1rem;
                color: #333;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
                transition: all 0.3s ease;
            }

            .search-input:focus {
                border-color: #d4a017;
                box-shadow: 0 6px 15px rgba(212, 160, 23, 0.2);
                outline: none;
            }

            .search-icon {
                position: absolute;
                left: 20px;
                top: 50%;
                transform: translateY(-50%);
                font-size: 1.2rem;
                color: #999;
            }

            /* Service section */
            .service-section {
                max-width: 1200px;
                margin: 60px auto;
                padding: 0 20px;
            }

            .section-header {
                text-align: center;
                margin-bottom: 40px;
            }

            .section-title {
                font-size: 2.5rem;
                font-weight: 700;
                color: #2c2c2c;
                margin-bottom: 1rem;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 15px;
            }

            .section-description {
                font-size: 1.1rem;
                color: #666;
                line-height: 1.6;
                max-width: 700px;
                margin: 0 auto;
            }

            /* Services grid */
            .services-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
                gap: 40px;
            }

            /* Service card */
            .service-card {
                background: linear-gradient(145deg, #ffffff 0%, #f9f9f9 100%);
                border-radius: 20px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                transition: transform 0.4s ease, box-shadow 0.4s ease;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                min-height: 450px; /* Ensures consistent height */
            }

            .service-card:hover {
                transform: translateY(-10px);
                box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
            }

            .service-header-section {
                padding: 25px;
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                flex-wrap: wrap;
                gap: 15px;
            }

            .service-info {
                flex-grow: 1;
            }

            .service-title {
                font-size: 1.8rem;
                font-weight: 700;
                color: #333;
                margin-bottom: 0.8rem;
                line-height: 1.3;
            }

            .service-description {
                font-size: 0.95rem;
                color: #777;
                line-height: 1.5;
                min-height: 60px; /* Ensure description space */
            }

            .service-price {
                font-size: 1.6rem;
                font-weight: 700;
                color: #d4a017;
                white-space: nowrap; /* Prevent price from wrapping */
            }

            .service-images {
                display: grid;
                grid-template-columns: repeat(3, 1fr);
                gap: 5px;
                padding: 0 25px 15px;
            }

            .service-image {
                width: 100%;
                padding-bottom: 75%; /* 4:3 aspect ratio */
                position: relative;
                overflow: hidden;
                border-radius: 10px;
            }

            .service-image img {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.3s ease;
            }

            .service-card:hover .service-image img {
                transform: scale(1.05);
            }

            .service-duration {
                font-size: 0.9rem;
                color: #888;
                text-align: right;
                padding: 0 25px 15px;
            }

            .add-to-cart {
                width: calc(100% - 50px); /* Adjust for padding */
                padding: 12px 20px;
                margin: 0 25px 25px;
                background: #d4a017;
                color: white;
                border: none;
                border-radius: 10px;
                font-weight: 600;
                font-size: 1.1em;
                cursor: pointer;
                transition: background 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
                box-shadow: 0 4px 15px rgba(212, 160, 23, 0.3);
            }

            .add-to-cart:hover {
                background: #b88f14;
                transform: translateY(-3px);
                box-shadow: 0 6px 20px rgba(212, 160, 23, 0.4);
            }

            .add-to-cart:active {
                transform: translateY(0);
                box-shadow: 0 2px 8px rgba(212, 160, 23, 0.2);
            }

            .add-to-cart.in-cart {
                background: #28a745; /* Green for "In Cart" */
                box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
            }

            .add-to-cart.in-cart:hover {
                background: #218838;
                box-shadow: 0 6px 20px rgba(40, 167, 69, 0.4);
            }
            .cart-summary {
                position: sticky;
                bottom: 20px;
                left: 50%;
                transform: translateX(-50%);
                width: 80%;
                max-width: 900px;
                background: linear-gradient(135deg, #2c2c2c 0%, #1a1a1a 100%);
                border-top: 3px solid #d4a017;
                padding: 15px 30px;
                box-shadow: 0 -4px 15px rgba(0, 0, 0, 0.25);
                z-index: 1000;
                display: flex;
                justify-content: space-between;
                align-items: center;
                font-family: 'Noto Sans', sans-serif;
                min-height: 60px;
                border-radius: 12px;
            }

            .cart-title {
                font-weight: 700;
                color: #fff;
                font-size: 1.3em;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .cart-item-count {
                background: #d4a017;
                color: white;
                border-radius: 50%;
                padding: 6px 12px;
                font-size: 0.95em;
                font-weight: 600;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                transition: transform 0.2s ease;
            }

            .cart-item-count:hover {
                transform: scale(1.1);
            }

            .cart-total {
                font-weight: 700;
                color: #d4a017;
                font-size: 1.3em;
                letter-spacing: 0.5px;
            }

            .checkout-btn {
                padding: 12px 30px;
                background: #d4a017;
                color: white;
                border: none;
                border-radius: 8px;
                font-weight: 600;
                font-size: 1.1em;
                cursor: pointer;
                transition: background 0.3s ease, transform 0.2s ease, box-shadow 0.3s ease;
                box-shadow: 0 2px 8px rgba(212, 160, 23, 0.3);
            }

            .checkout-btn:hover {
                background: #b88f14;
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(212, 160, 23, 0.5);
            }

            .checkout-btn:active {
                transform: translateY(0);
                box-shadow: 0 2px 6px rgba(212, 160, 23, 0.3);
            }

            .footer {
                background: #1a1a1a;
                color: #fff;
                padding: 40px 0;
                margin-top: 0;
            }

            .footer-container {
                display: flex;
                justify-content: space-around;
                flex-wrap: wrap;
                max-width: 1200px;
                margin: 0 auto;
                padding: 0 20px;
            }

            .footer-logo-section img {
                width: 150px;
            }

            .Links-section, .footer-contact-section {
                margin: 10px 0;
            }

            .footer-title {
                font-size: 1.2em;
                margin-bottom: 15px;
            }

            .footer-links ul {
                list-style: none;
                padding: 0;
            }

            .footer-links li {
                margin-bottom: 10px;
            }

            .footer-links a {
                color: #ccc;
                text-decoration: none;
            }

            .footer-links a:hover {
                color: #d4a017;
            }

            .footer-contact p {
                margin: 5px 0;
                display: flex;
                align-items: center;
            }

            .footer-contact i {
                margin-right: 10px;
            }

            .footer-bottom {
                text-align: center;
                padding: 10px 0;
                border-top: 1px solid #333;
                margin-top: 20px;
            }

            .main-container {
                padding-bottom: 120px; /* Add padding to accommodate sticky cart */
            }
        </style>
    </head>
    <body>
        <%@ include file="/views/common/navbar.jsp" %>

        <div class="main-container">
            <div class="header">
                <h1 class="main-title">Chọn Dịch Vụ Cao Cấp</h1>
                <p class="subtitle">Trải nghiệm dịch vụ chăm sóc nam giới đẳng cấp với công nghệ hiện đại tại Cut&Styles Barber</p>
                <div class="search-container">
                    <span class="search-icon">🔍</span>
                    <input type="text" class="search-input" placeholder="Tìm kiếm dịch vụ..." id="searchInput">
                </div>
            </div>

            <section class="service-section">
                <div class="section-header">
                    <h2 class="section-title">✂️ Cắt Tóc Chuyên Nghiệp</h2>
                    <p class="section-description">Dịch vụ cắt tóc cao cấp với kỹ thuật tinh tế, phong cách hiện đại</p>
                </div>
                <div class="services-grid">
                    <c:choose>
                        <c:when test="${not empty services}">
                            <c:forEach var="service" items="${services}">
                                <div class="service-card">
                                    <div class="service-header-section">
                                        <div class="service-info">
                                            <h3 class="service-title"><c:out value="${service.name}" /></h3>
                                            <p class="service-description"><c:out value="${service.description}" /></p>
                                        </div>
                                        <div class="service-price">
                                            <fmt:formatNumber value="${service.price != null ? service.price : 0}" type="number" groupingUsed="true" /> VNĐ
                                        </div>
                                    </div>
                                    <div class="service-images">
                                        <div class="service-image">
                                            <img src="${not empty service.image[0] ? pageContext.request.contextPath.concat(service.image[0]) : pageContext.request.contextPath.concat('/image/image_service/default_haircut.png')}" alt="${service.name}">
                                        </div>
                                        <div class="service-image">
                                            <img src="${not empty service.image[1] ? pageContext.request.contextPath.concat(service.image[1]) : pageContext.request.contextPath.concat('/image/image_service/default_haircut_sub1.png')}" alt="${service.name}">
                                        </div>
                                        <div class="service-image">
                                            <img src="${not empty service.image[2] ? pageContext.request.contextPath.concat(service.image[2]) : pageContext.request.contextPath.concat('/image/image_service/default_haircut_sub2.png')}" alt="${service.name}">
                                        </div>
                                    </div>
                                    <div class="service-duration">${service.duration} Phút</div>
                                    <button class="add-to-cart" data-service-id="${service.id}" data-service-name="${fn:escapeXml(service.name)}" data-service-price="${service.price != null ? service.price : 0}" data-service-type="haircut">Thêm Vào Đơn</button>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <p style="color: red;">Không có dịch vụ cắt tóc nào khả dụng.</p>
                        </c:otherwise>
                    </c:choose>
                </div>
            </section>

            <%-- IMPORTANT: Ideally, all service sections should be dynamic from the database, not hardcoded.
                 For now, I'm keeping the hardcoded sections as they were, but you should aim to make them dynamic
                 by adding a 'category' or 'type' column to your Service model and fetching/grouping them in the Servlet. --%>
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
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/uon_tieu_chuan.jpg" alt="Cắt tóc"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/uon_tieu_chuan_sub1.jpg" alt="Cắt tóc"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/uon_tieu_chuan_sub2.png" alt="Tạo kiểu"></div>
                        </div>
                        <div class="service-duration">90 Phút</div>
                        <button class="add-to-cart" data-service-id="-1" data-service-name="Uốn tiêu chuẩn" data-service-price="379000" data-service-type="perm">Thêm Vào Đơn</button>
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
                        <button class="add-to-cart" data-service-id="-2" data-service-name="Uốn cao cấp" data-service-price="499000" data-service-type="perm">Thêm Vào Đơn</button>
                    </div>
                </div>
            </section>

            <section class="service-section">
                <div class="section-header">
                    <h2 class="section-title">✂️ Thay Đổi Màu Tóc</h2>
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
                        <button class="add-to-cart" data-service-id="-3" data-service-name="Nhuộm tiêu chuẩn" data-service-price="199000" data-service-type="color">Thêm Vào Đơn</button>
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
                        <button class="add-to-cart" data-service-id="-4" data-service-name="Nhuộm cao cấp" data-service-price="329000" data-service-type="color">Thêm Vào Đơn</button>
                    </div>
                </div>
            </section>

            <section class="service-section">
                <div class="section-header">
                    <h2 class="section-title">🧘 Spa & Thư Giãn</h2>
                    <p class="section-description">Dịch vụ spa và thư giãn giúp bạn tái tạo năng lượng và chăm sóc toàn diện</p>
                </div>
                <div class="services-grid">
                    <div class="service-card">
                        <div class="service-header-section">
                            <div class="service-info">
                                <h3 class="service-title">Gội Combo 1</h3>
                                <p class="service-description">Massage thư giãn cổ vai gáy, giảm căng thẳng, cải thiện tuần hoàn máu</p>
                            </div>
                            <div class="service-price">50,000 VNĐ</div>
                        </div>
                        <div class="service-images">
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/massageCombo1_main.png" alt="Massage"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/massageCombo1_sub1.png" alt="Massage"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/massageCombo1_sub2.png" alt="Massage"></div>
                        </div>
                        <div class="service-duration">20 Phút</div>
                        <button class="add-to-cart" data-service-id="-5" data-service-name="Gội Combo 1" data-service-price="50000" data-service-type="spa">Thêm Vào Đơn</button>
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
                        <button class="add-to-cart" data-service-id="-6" data-service-name="Gội Combo 2" data-service-price="159000" data-service-type="spa">Thêm Vào Đơn</button>
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
                        <button class="add-to-cart" data-service-id="-7" data-service-name="Gội Combo 3" data-service-price="219000" data-service-type="spa">Thêm Vào Đơn</button>
                    </div>
                </div>
            </section>

            <section class="service-section">
                <div class="section-header">
                    <h2 class="section-title">👂 Dịch Vụ Lấy Ráy Tai</h2>
                    <p class="section-description">Dịch vụ lấy ráy tai an toàn, sạch sẽ, mang lại cảm giác thoải mái và dễ chịu</p>
                </div>
                <div class="services-grid">
                    <div class="service-card">
                        <div class="service-header-section">
                            <div class="service-info">
                                <h3 class="service-title">Lấy Ráy Tai Combo</h3>
                                <p class="service-description">Lấy ráy tai chuyên sâu, kết hợp massage tai nhẹ nhàng, mang lại cảm giác thư giãn</p>
                            </div>
                            <div class="service-price">70,000 VNĐ</div>
                        </div>
                        <div class="service-images">
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/layRayTai_main.png" alt="Ear Cleaning"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/layRayTai_sub1.png" alt="Ear Cleaning"></div>
                            <div class="service-image"><img src="${pageContext.request.contextPath}/image/image_service/layRayTai_sub2.png" alt="Ear Cleaning"></div>
                        </div>
                        <div class="service-duration">30 Phút</div>
                        <button class="add-to-cart" data-service-id="-8" data-service-name="Lấy Ráy Tai Combo" data-service-price="70000" data-service-type="earcleaning">Thêm Vào Đơn</button>
                    </div>
                </div>
            </section>

            <footer class="footer">
                <div class="footer-container">
                    <div class="footer-logo-section">
                        <img src="${pageContext.request.contextPath}/image/image_logo/Logo.png" alt="Cut&Styles Logo" class="footer-logo">
                    </div>
                    <div class="Links-section">
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

        <div class="cart-summary">
            <div class="cart-title">Tổng Hóa Đơn<span class="cart-item-count" id="cartItemCount">0</span></div>
            <div class="cart-total" id="cartTotal">0 VNĐ</div>
            <button class="checkout-btn" onclick="checkout()">Xong</button>
        </div>

        <%-- Form gửi dữ liệu dịch vụ đã chọn về ChooseServiceServlet (hoặc BookingServlet) --%>
        <form id="serviceSelectionForm" action="${pageContext.request.contextPath}/ChooseServiceServlet" method="POST" style="display: none;">
            <input type="hidden" name="serviceNames" id="serviceNamesInput">
            <input type="hidden" name="totalPrice" id="totalPriceInput">
        </form>

        <script>
            let cart = [];

            // Function to load cart from session storage (if available)
            function loadCartFromSession() {
                const storedCart = sessionStorage.getItem('selectedServicesCart');
                if (storedCart) {
                    try {
                        cart = JSON.parse(storedCart);
                        // Ensure buttons reflect current cart state
                        cart.forEach(item => {
                            const button = document.querySelector(`.add-to-cart[data-service-name='${item.name}`); // Use escape for single quote
                            if (button) {
                                button.classList.add('in-cart');
                                button.textContent = 'Đã Thêm';
                            }
                        });
                        updateCartSummary();
                    } catch (e) {
                        console.error("Failed to parse cart from session storage:", e);
                        cart = []; // Reset cart if parsing fails
                    }
                }
            }

            // Function to save cart to session storage
            function saveCartToSession() {
                sessionStorage.setItem('selectedServicesCart', JSON.stringify(cart));
            }

            function addToCart(serviceId, serviceName, servicePrice, serviceType) {
                const button = event.target;
                // Use serviceId and serviceName for uniqueness, as serviceId might be 0 for hardcoded ones
                const isInCart = cart.some(item => item.name === serviceName);

                if (isInCart) {
                    cart = cart.filter(item => item.name !== serviceName);
                    button.classList.remove('in-cart');
                    button.textContent = 'Thêm Vào Đơn';
                } else {
                    // It's better to get the actual ID from the database for hardcoded services.
                    // For now, if serviceId is 0 (hardcoded default), you might use serviceName as the primary identifier.
                    // If your backend assigns unique IDs to all services, ensure those IDs are passed to data-service-id.
                    cart.push({ id: serviceId, name: serviceName, price: servicePrice, type: serviceType });
                    button.classList.add('in-cart');
                    button.textContent = 'Đã Thêm';
                }

                updateCartSummary();
                saveCartToSession(); // Save cart to session storage after every change
                console.log('Cart updated:', cart);
            }

            function updateCartSummary() {
                const cartItemCount = document.getElementById('cartItemCount');
                const cartTotal = document.getElementById('cartTotal');
                const totalPrice = cart.reduce((sum, item) => sum + item.price, 0);

                cartItemCount.textContent = cart.length > 0 ? cart.length : 0;
                cartTotal.textContent = totalPrice.toLocaleString('vi-VN') + ' VNĐ';
            }

            function checkout() {
                if (cart.length === 0) {
                    alert('Giỏ hàng trống! Vui lòng chọn ít nhất một dịch vụ.');
                    return;
                }

                const serviceNames = cart.map(item => item.name);
                const totalPrice = cart.reduce((sum, item) => sum + item.price, 0);

                // Gán dữ liệu vào form ẩn
                document.getElementById('serviceNamesInput').value = serviceNames.join(',');
                document.getElementById('totalPriceInput').value = totalPrice;

                console.log('Sending data to ChooseServiceServlet POST:');
                console.log('serviceNames:', serviceNames.join(','));
                console.log('totalPrice:', totalPrice);

                // Gửi form tới ChooseServiceServlet (sẽ xử lý và redirect về BookingServlet)
                document.getElementById('serviceSelectionForm').submit();
            }

            // Khởi tạo event listeners
            document.addEventListener('DOMContentLoaded', () => {
                loadCartFromSession(); // Load cart on page load

                document.querySelectorAll('.add-to-cart').forEach(button => {
                    button.addEventListener('click', (event) => { // Pass event to addToCart
                        const serviceId = parseInt(button.getAttribute('data-service-id'));
                        const serviceName = button.getAttribute('data-service-name');
                        const servicePrice = parseInt(button.getAttribute('data-service-price'));
                        const serviceType = button.getAttribute('data-service-type');
                        addToCart(serviceId, serviceName, servicePrice, serviceType);
                    });
                });
                
                // Live search functionality
                const searchInput = document.getElementById('searchInput');
                searchInput.addEventListener('keyup', () => {
                    const searchTerm = searchInput.value.toLowerCase();
                    document.querySelectorAll('.service-card').forEach(card => {
                        const serviceTitle = card.querySelector('.service-title').textContent.toLowerCase();
                        if (serviceTitle.includes(searchTerm)) {
                            card.style.display = 'block';
                        } else {
                            card.style.display = 'none';
                        }
                    });
                });

                 // Ensure image paths are correct for dynamically loaded images (from backend)
                document.querySelectorAll('.service-image img').forEach(img => {
                    if (img.src.includes('null') || img.src.trim() === '') {
                        img.src = '${pageContext.request.contextPath}/image/image_service/default_haircut.png';
                    }
                });
            });
        </script>
    </body>
</html>