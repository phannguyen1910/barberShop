<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<div class="container py-5 service-sections">
    <!-- DỊCH VỤ TÓC -->
    <h4 class="section-title">| DỊCH VỤ TÓC</h4>
    <div class="row mb-4">
        <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/views/service/cutHairService.jsp" class="service-card">
                <img src="${pageContext.request.contextPath}/image/image_service/cutHair.png" alt="Cắt tóc">
                <div class="service-info">
                    <h5>Cắt tóc</h5>
                    <p>Giá từ 75.000VNĐ</p>
                </div>
            </a>
        </div>
        <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/views/service/hairStylesService.jsp" class="service-card">
                <img src="${pageContext.request.contextPath}/image/image_service/uon.png" alt="Uốn định hình">
                <div class="service-info">
                    <h5>Uốn định hình</h5>
                    <p>Giá từ 379.000VNĐ</p>
                </div>
            </a>
        </div>
        <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/views/service/hairStylesService.jsp" class="service-card">
                <img src="${pageContext.request.contextPath}/image/image_service/nhuom.png" alt="Thay đổi màu tóc">
                <div class="service-info">
                    <h5>Thay đổi màu tóc</h5>
                    <p>Giá từ 199.000VNĐ</p>
                </div>
            </a>
        </div>
    </div>


    <!-- THƯ GIÃN VÀ CHĂM SÓC DA -->
    <h4 class="section-title">| THƯ GIÃN VÀ CHĂM SÓC DA</h4>
    <div class="row">
        <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/views/service/massageService.jsp" class="service-card">
                <img src="${pageContext.request.contextPath}/image/image_service/massage.png" alt="Gội dưỡng sinh thư giãn">
                <div class="service-info">
                    <h5>Gội dưỡng sinh thư giãn</h5>
                </div>
            </a>
        </div>
        <div class="col-md-4 mb-3">
            <a href="${pageContext.request.contextPath}/views/service/massageService.jsp" class="service-card">
                <img src="${pageContext.request.contextPath}/image/image_service/rayTai.png" alt="Lấy ráy tai êm">
                <div class="service-info">
                    <h5>Lấy ráy tai êm</h5>
                </div>
            </a>
        </div>
    </div>
</div>
<!-- Cam kết dịch vụ -->
<div class="commitment-section py-5">
    <div class="container">
        <div class="commitment-header">
            <h3 class="commitment-title">| CAM KẾT CUT&STYLES CARE</h3>
            <div class="subtitle-row">
                <p class="commitment-subtitle">Sự hài lòng của anh là ưu tiên hàng đầu của Cut&Styles</p>
                <a href="${pageContext.request.contextPath}/views/commit/details.jsp" class="commitment-link">Xem tất cả →</a>
            </div>
        </div>

        <div class="commitment-banner">
            <div class="commitment-banner-content">
                <h2 class="banner-title">VÌ CHẤT LƯỢNG PHỤC VỤ LÀ HÀNG ĐẦU</h2>
                <p class="banner-subtitle">Áp dụng tại salon bất kỳ toàn hệ thống Cut&Styles</p>
            </div>
        </div>

        <div class="row commitment-features">
            <div class="col-md-6 commitment-feature">
                <div class="feature-content">
                    <div class="feature-number">07</div>
                    <div class="feature-unit">ngày</div>
                    <div class="feature-description">Bảo hành tóc miễn phí</div>
                </div>
            </div>

            <div class="col-md-6 commitment-feature">
                <div class="feature-content">
                    <div class="feature-title">Chính sách<br>đặc biệt</div>
                    <div class="feature-description">Nếu khách chờ lâu</div>
                </div>
            </div>
        </div>
    </div>
</div>


<!-- AN TÂM & TIN TƯỞNG Section -->
<div class="antam-tintruong-section py-5">
    <div class="container">
        <div class="section-header">
            <h3 class="section-title">| AN TÂM & TIN TƯỞNG</h3>
            <p class="section-subtitle">Thấu hiểu nhu cầu, hỗ trợ nhiệt tình</p>
        </div>

        <div class="row service-row">
            <!-- Left service card -->
            <div class="col-md-6 mb-4">
                <a href="${pageContext.request.contextPath}/views/commit/support.jsp" class="card-link">
                    <div class="service-support-card">
                        <div class="service-support-img">
                            <img src="${pageContext.request.contextPath}/image/image_service/support1.png" alt="Người đang tư vấn">
                        </div>
                        <div class="service-support-info">
                            <h5>Những câu hỏi thường gặp</h5>
                        </div>
                    </div>
                </a>
            </div>

            <!-- Right service card -->
            <div class="col-md-6 mb-4">
                <a href="${pageContext.request.contextPath}/views/commit/storage.jsp" class="card-link">
                    <div class="service-support-card">
                        <div class="service-support-img">
                            <img src="${pageContext.request.contextPath}/image/image_service/support2.png" alt="Bảo quản xe">
                        </div>
                        <div class="service-support-info">
                            <h5>Bảo quản xe cộ, đồ đạc</h5>
                        </div>
                    </div>
                </a>
            </div>
        </div>
    </div>
</div>
