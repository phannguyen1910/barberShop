<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<div class="main-content-wrapper">
    <!-- Carousel -->
    <div class="container carousel-container">
        <div id="mainCarousel"
             class="carousel slide"
             data-bs-ride="carousel"
             data-bs-interval="2000"
             data-bs-wrap="true">
            <!-- Slides -->
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="${pageContext.request.contextPath}/image/image_banner/banner1.png" class="d-block w-100" alt="Ảnh 1">
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/image/image_banner/banner2.png" class="d-block w-100" alt="Ảnh 2">
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/image/image_banner/banner3.png" class="d-block w-100" alt="Ảnh 3">
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/image/image_banner/banner4.png" class="d-block w-100" alt="Ảnh 4">
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/image/image_banner/banner5.png" class="d-block w-100" alt="Ảnh 5">
                </div>
            </div>

            <!-- Controls -->
            <button class="carousel-control-prev" type="button" data-bs-target="#mainCarousel" data-bs-slide="prev">
                <span class="visually-hidden">Trước</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#mainCarousel" data-bs-slide="next">
                <span class="visually-hidden">Tiếp</span>
            </button>
            <!-- Indicators -->
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
                <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="3" aria-label="Slide 4"></button>
                <button type="button" data-bs-target="#mainCarousel" data-bs-slide-to="4" aria-label="Slide 5"></button>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
