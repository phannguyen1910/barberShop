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
    

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans:wght@300;400;500;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-icons/1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet"> <%-- Required for fas icons --%>
    <style>
        /* Your existing CSS variables and styles */
       /* Navbar */
.custom-navbar {
    background-color: #201E15 !important;
}

/* Logo: nổi bật và rõ */
.custom-navbar .navbar-brand {
    color: #ffffff !important;
    font-weight: 700;
    font-size: 1.4rem;
    letter-spacing: 1px;
}

/* Các item ở giữa (menu) rõ hơn, đẹp hơn */
.custom-navbar .nav-link {
    color: #f5f5f5 !important;
    font-weight: 500;
    font-size: 1.05rem;
    letter-spacing: 0.5px;
    position: relative;
    padding-bottom: 6px;
    transition: color 0.2s ease;
}

/* Gạch chân nhỏ khi hover (nhẹ nhàng sang trọng) */
.custom-navbar .nav-link::after {
    content: "";
    position: absolute;
    width: 0%;
    height: 2px;
    left: 0;
    bottom: 0;
    background-color: #d4af37; /* vàng sang */
    transition: width 0.3s ease-in-out;
}

.custom-navbar .nav-link:hover::after,
.custom-navbar .nav-link:focus::after {
    width: 100%;
}

.custom-navbar .nav-link:hover {
    color: #ffe58a !important;
}

/* Nút đăng nhập / đăng ký: màu tinh tế hơn */
.custom-navbar .btn-outline-primary {
    border: 1px solid #d4af37;
    color: #d4af37;
    font-weight: 500;
    padding: 6px 16px;
    transition: all 0.3s ease;
}

.custom-navbar .btn-outline-primary:hover {
    background-color: #d4af37;
    color: #201E15;
}

/* Responsive chỉnh nhẹ khoảng cách */
@media (max-width: 992px) {
    .custom-navbar .btn-outline-primary {
        padding: 5px 12px;
        font-size: 0.9rem;
    }
}

/* khung carousel */
.carousel-item {
    aspect-ratio: 18 / 5; /* Giảm tỉ lệ chiều cao để không quá dày */
    overflow: hidden;
    border-radius: 16px;
}

.carousel-item img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    border-radius: 16px;
}

@media (max-width: 768px) {
    .carousel-item {
        aspect-ratio: 4 / 3; /* Tỉ lệ cao hơn chút cho màn nhỏ */
    }
}

.carousel-container {
    margin-top: 20px;
    margin-bottom: 30px; /* Giảm khoảng cách dưới carousel */
}

:root {
    --primary-gold: #D4AF37;
    --dark-charcoal: #2D2D2D;
    --light-gray: #f8f9fa;
    --text-muted: #8B8B8B;
    --shadow-luxury: 0 12px 25px rgba(0, 0, 0, 0.1);
    --shadow-soft: 0 8px 25px rgba(212, 175, 55, 0.15);
    --glass-bg: rgba(255, 255, 255, 0.15);
    --glass-border: rgba(255, 255, 255, 0.2);
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

html, body {
    min-height: 100vh;
    overflow-x: hidden;
    font-family: 'Inter', sans-serif;
    line-height: 1.4; /* Giảm line-height */
    color: var(--dark-charcoal);
    background: linear-gradient(135deg, rgba(32, 30, 21, 0.9), rgba(212, 175, 55, 0.1)),
        url('https://images.unsplash.com/photo-1585747860715-2ba37e788b70?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1374&q=80');
    background-size: cover;
    background-position: center;
    background-attachment: fixed;
    background-repeat: no-repeat;
}

        :root {
            /* Color Palette - Luxury & Premium */
            --primary-gold: #D4AF37;
            --primary-dark: #1a1a1a;
            --secondary-dark: #2c2c2c;
            --accent-bronze: #CD7F32;
            --text-light: #f5f5f5;
            --text-gray: #cccccc;
            --text-muted: #999999;
            --background-dark: #0f0f0f;
            --card-background: #1e1e1e;
            --border-gold: rgba(212, 175, 55, 0.3);
            --hover-gold: rgba(212, 175, 55, 0.1);
            --shadow-dark: rgba(0, 0, 0, 0.5);
            --gradient-gold: linear-gradient(135deg, #D4AF37 0%, #CD7F32 100%);
            --gradient-dark: linear-gradient(135deg, #1a1a1a 0%, #2c2c2c 100%);

            /* Typography */
            --font-primary: 'Noto Sans', sans-serif;
            --font-weight-light: 300;
            --font-weight-normal: 400;
            --font-weight-medium: 500;
            --font-weight-bold: 700;

            /* Spacing */
            --spacing-xs: 0.5rem;
            --spacing-sm: 1rem;
            --spacing-md: 1.5rem;
            --spacing-lg: 2rem;
            --spacing-xl: 3rem;

            /* Border Radius */
            --radius-sm: 8px;
            --radius-md: 12px;
            --radius-lg: 16px;
            --radius-xl: 20px;

            /* Shadows */
            --shadow-sm: 0 2px 8px rgba(0, 0, 0, 0.15);
            --shadow-md: 0 4px 20px rgba(0, 0, 0, 0.25);
            --shadow-lg: 0 8px 32px rgba(0, 0, 0, 0.35);
            --shadow-gold: 0 4px 20px rgba(212, 175, 55, 0.2);
        }

        /* Body và Layout Chính */
        body {
            font-family: var(--font-primary);
            font-weight: var(--font-weight-normal);
            background-image: url('https://images.unsplash.com/photo-1585747860715-2ba37e788b70?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1374&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            background-repeat: no-repeat;
            color: var(--text-light);
            line-height: 1.6;
            overflow-x: hidden;
            min-height: 100vh;
            /* FIXED: Tăng padding-bottom để tránh che dịch vụ */
            padding-bottom: 100px;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.4);
            pointer-events: none;
            z-index: -1;
        }

        .main-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: var(--spacing-lg);
            min-height: 100vh;
            position: relative;
            background: rgba(255, 255, 255, 0.1);

            border-radius: var(--radius-xl);
            border: 1px solid rgba(255, 255, 255, 0.2);
            /* FIXED: Thêm margin-bottom để tránh bị che */
            margin-bottom: 80px;
        }

        /* Header Section */
        .header {
            text-align: center;
            margin-bottom: var(--spacing-xl);
            padding: var(--spacing-xl) 0;
            position: relative;
            padding-top: calc(var(--spacing-xl) + 60px); /* Add space for fixed navbar */
        }

        .header::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 2px;
            background: var(--gradient-gold);
            border-radius: 1px;
        }

        .main-title {
            font-family: 'Playfair Display', serif; /* Assuming this font is available or imported */
            font-size: 3rem;
            font-weight: 700;
            color: #fff;
            margin-bottom: 1rem;
            text-shadow: 3px 3px 6px rgba(0,0,0,0.7);
        }

        .subtitle {
            font-size: 1.25rem;
            color: var(--text-gray);
            font-weight: var(--font-weight-light);
            max-width: 800px;
            margin: 0 auto var(--spacing-lg) auto;
            line-height: 1.8;
        }

        /* Search Container */
        .search-container {
            position: relative;
            max-width: 500px;
            margin: 0 auto;
        }

        .search-container::before {
            content: '';
            position: absolute;
            top: -2px;
            left: -2px;
            right: -2px;
            bottom: -2px;
            background: var(--gradient-gold);
            border-radius: var(--radius-lg);
            z-index: -1;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .search-container:focus-within::before {
            opacity: 1;
        }

        .search-input {
            width: 100%;
            padding: var(--spacing-md) var(--spacing-md) var(--spacing-md) 3.5rem;
            font-size: 1.1rem;
            background: var(--card-background);
            border: 1px solid var(--border-gold);
            border-radius: var(--radius-lg);
            color: var(--text-light);
            transition: all 0.3s ease;
            font-family: var(--font-primary);
        }

        .search-input:focus {
            outline: none;
            background: var(--secondary-dark);
            box-shadow: var(--shadow-gold);
            border-color: var(--primary-gold);
        }

        .search-input::placeholder {
            color: var(--text-muted);
            font-weight: var(--font-weight-light);
        }

        .search-icon {
            position: absolute;
            left: var(--spacing-md);
            top: 50%;
            transform: translateY(-50%);
            font-size: 1.2rem;
            color: var(--primary-gold);
            z-index: 1;
        }

        /* Service Sections */
        .service-section {
            margin-bottom: var(--spacing-xl);
            padding: var(--spacing-xl);
            background: rgba(255, 255, 255, 0.05);
            border-radius: var(--radius-xl);
            border: 1px solid var(--border-gold);
            position: relative;
            overflow: hidden;
            backdrop-filter: blur(10px);
        }

        .service-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 1px;
            background: var(--gradient-gold);
            opacity: 0.6;
        }

        .section-header {
            text-align: center;
            margin-bottom: var(--spacing-xl);
            padding-bottom: var(--spacing-lg);
            border-bottom: 1px solid var(--border-gold);
        }

        .section-title {
            font-size: 2.5rem;
            font-weight: var(--font-weight-bold);
            color: var(--primary-gold);
            margin-bottom: var(--spacing-md);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: var(--spacing-md);
        }

        .section-title i {
            font-size: 2rem;
            filter: drop-shadow(0 2px 4px var(--shadow-dark));
        }

        .section-description {
            font-size: 1.1rem;
            color: var(--text-gray);
            font-weight: var(--font-weight-light);
            max-width: 600px;
            margin: 0 auto;
            line-height: 1.7;
        }

        /* Services Grid */
        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(350px, 1fr));
            gap: var(--spacing-lg);
            padding: var(--spacing-md) 0;
        }

        /* Service Cards */
        .service-card {
            background: var(--card-background);
            border-radius: var(--radius-lg);
            border: 1px solid var(--border-gold);
            padding: var(--spacing-lg);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            cursor: pointer;
            display: flex;
            flex-direction: column;
            height: 100%;
        }

        .service-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(212, 175, 55, 0.03), transparent);
            transition: left 0.6s ease;
        }

        .service-card:hover::before {
            left: 100%;
        }

        .service-card:hover {
            transform: translateY(-8px);
            box-shadow: var(--shadow-lg), var(--shadow-gold);
            border-color: var(--primary-gold);
        }

        .service-info {
            margin-bottom: var(--spacing-md);
        }

        .service-title {
            font-size: 1.4rem;
            font-weight: var(--font-weight-bold);
            color: var(--text-light);
            margin-bottom: var(--spacing-sm);
            line-height: 1.3;
        }

        .service-description {
            color: var(--text-gray);
            font-size: 0.95rem;
            line-height: 1.6;
            font-weight: var(--font-weight-light);
            margin-bottom: var(--spacing-md);
        }

        .service-images {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: var(--spacing-sm);
            margin-bottom: var(--spacing-md);
            border-radius: var(--radius-md);
            overflow: hidden;
            flex-shrink: 0;
        }

        .service-image {
            aspect-ratio: 1;
            border-radius: var(--radius-sm);
            overflow: hidden;
            position: relative;
        }

        .service-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.4s ease;
            filter: brightness(0.9) contrast(1.1);
        }

        .service-image:hover img {
            transform: scale(1.1);
        }

        .service-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: var(--spacing-md);
            gap: var(--spacing-md);
        }

        .service-duration {
            display: inline-flex;
            align-items: center;
            gap: var(--spacing-xs);
            background: var(--secondary-dark);
            color: var(--primary-gold);
            padding: var(--spacing-xs) var(--spacing-md);
            border-radius: var(--radius-sm);
            font-size: 0.85rem;
            font-weight: var(--font-weight-medium);
            border: 1px solid var(--border-gold);
            white-space: nowrap;
        }

        .service-duration::before {
            content: '⏱';
            font-size: 0.9rem;
        }

        .service-price {
            background: var(--gradient-gold);
            color: var(--primary-dark);
            padding: var(--spacing-xs) var(--spacing-md);
            border-radius: var(--radius-sm);
            font-weight: var(--font-weight-bold);
            font-size: 0.95rem;
            white-space: nowrap;
            box-shadow: var(--shadow-sm);
        }

        .add-to-cart {
            width: 100%;
            padding: var(--spacing-md);
            background: var(--gradient-gold);
            color: var(--primary-dark);
            border: none;
            border-radius: var(--radius-md);
            font-size: 1.1rem;
            font-weight: var(--font-weight-bold);
            font-family: var(--font-primary);
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-top: auto;
        }

        .add-to-cart::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.6s ease;
        }

        .add-to-cart:hover::before {
            left: 100%;
        }

        .add-to-cart:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-md);
            filter: brightness(1.1);
        }

        .add-to-cart:active {
            transform: translateY(0);
        }

        .add-to-cart.in-cart {
            background: var(--secondary-dark);
            color: var(--primary-gold);
            border: 2px solid var(--primary-gold);
        }

        /* ===== CART SUMMARY STYLING - FIXED ===== */
        .cart-summary {
            position: fixed;
            bottom: 20px; /* FIXED: Thay đổi từ bottom: 0 thành bottom: 20px */
            right: 20px;  /* FIXED: Thêm right: 20px để đặt ở góc phải */
            left: auto;   /* FIXED: Gỡ bỏ left: 0 */
            width: auto;  /* FIXED: Thay đổi từ full width */
            max-width: 400px; /* FIXED: Giới hạn độ rộng tối đa */
            max-height:  200px; /* FIXED: Giới hạn độ rộng tối đa */
            background: var(--gradient-dark);
            border: 2px solid var(--primary-gold);
            padding: var(--spacing-md);
            backdrop-filter: blur(15px);
            z-index: 1000;
            box-shadow: var(--shadow-lg);
            border-radius: var(--radius-lg); /* FIXED: Thêm bo góc */
            transition: all 0.3s ease;
        }

        .cart-summary.hidden {
            transform: translateY(150%) translateX(20px); /* FIXED: Ẩn về góc dưới phải */
            opacity: 0;
        }

        .cart-summary-content {
            display: flex;
            flex-direction: column; /* FIXED: Thay đổi layout thành dọc */
            gap: var(--spacing-sm);
            align-items: stretch;
        }

        .cart-info {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: var(--spacing-md);
        }

        .cart-title {
            font-size: 1rem; /* FIXED: Giảm font size */
            font-weight: var(--font-weight-bold);
            color: var(--text-light);
            display: flex;
            align-items: center;
            gap: var(--spacing-xs);
        }

        .cart-item-count {
            background: var(--primary-gold);
            color: var(--primary-dark);
            border-radius: 50%;
            width: 20px; /* FIXED: Giảm kích thước */
            height: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 0.75rem; /* FIXED: Giảm font size */
            font-weight: var(--font-weight-bold);
            margin-left: var(--spacing-xs);
        }

        .cart-total {
            font-size: 1.2rem; /* FIXED: Giảm font size */
            font-weight: var(--font-weight-bold);
            color: var(--primary-gold);
            text-shadow: 0 2px 4px var(--shadow-dark);
        }

        .checkout-btn {
            padding: var(--spacing-sm) var(--spacing-md); /* FIXED: Giảm padding */
            background: var(--gradient-gold);
            color: var(--primary-dark);
            border: none;
            border-radius: var(--radius-md);
            font-size: 0.95rem; /* FIXED: Giảm font size */
            font-weight: var(--font-weight-bold);
            font-family: var(--font-primary);
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            box-shadow: var(--shadow-md);
            white-space: nowrap;
        }

        .checkout-btn:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
            filter: brightness(1.1);
        }

        .checkout-btn:active {
            transform: translateY(0);
        }

        .checkout-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
            transform: none;
        }

        /* Footer Styling */
        .footer {
            margin-top: var(--spacing-xl);
            padding: var(--spacing-xl) 0;
            background: var(--gradient-dark);
            border-top: 1px solid var(--border-gold);
            border-radius: var(--radius-xl) var(--radius-xl) 0 0;
        }

        .footer-container {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: var(--spacing-lg);
            margin-bottom: var(--spacing-lg);
        }

        .footer-logo-section {
            text-align: center;
        }

        .footer-logo {
            max-width: 150px;
            height: auto;
            filter: brightness(1.1);
        }

        .footer-title {
            font-size: 1.2rem;
            font-weight: var(--font-weight-bold);
            color: var(--primary-gold);
            margin-bottom: var(--spacing-md);
        }

        .footer-links {
            list-style: none;
        }

        .footer-links li {
            margin-bottom: var(--spacing-xs);
        }

        .footer-links a {
            color: var(--text-gray);
            text-decoration: none;
            transition: color 0.3s ease;
        }

        .footer-links a:hover {
            color: var(--primary-gold);
        }

        .footer-contact p {
            color: var(--text-gray);
            margin-bottom: var(--spacing-xs);
            display: flex;
            align-items: center;
            gap: var(--spacing-xs);
        }

        .footer-contact i {
            color: var(--primary-gold);
            width: 16px;
        }

        .footer-bottom {
            text-align: center;
            padding-top: var(--spacing-lg);
            border-top: 1px solid var(--border-gold);
            color: var(--text-muted);
            font-size: 0.9rem;
        }

        /* Responsive Design Updates */
        @media (max-width: 768px) {
            body {
                padding-bottom: 120px; /* FIXED: Tăng padding cho mobile */
            }

            .main-container {
                padding: var(--spacing-md);
                margin-bottom: 100px; /* FIXED: Tăng margin cho mobile */
            }

            .services-grid {
                grid-template-columns: 1fr;
                gap: var(--spacing-md);
            }

            .service-meta {
                flex-direction: column;
                align-items: flex-start;
                gap: var(--spacing-sm);
            }

            /* FIXED: Cập nhật cart summary cho mobile */
            .cart-summary {
                bottom: 10px;
                right: 10px;
                left: 10px;
                max-width: none;
                width: auto;
            }

            .cart-summary-content {
                flex-direction: row;
                justify-content: space-between;
                align-items: center;
            }

            .checkout-btn {
                flex-shrink: 0;
                min-width: 100px;
            }

            .main-title {
                font-size: 2.5rem;
            }

            .section-title {
                font-size: 2rem;
                flex-direction: column;
                gap: var(--spacing-sm);
            }
        }

        @media (max-width: 480px) {
            body {
                padding-bottom: 130px; /* FIXED: Tăng thêm padding cho mobile nhỏ */
            }

            .main-container {
                margin-bottom: 110px; /* FIXED: Tăng margin cho mobile nhỏ */
            }

            .cart-summary {
                padding: var(--spacing-sm);
            }

            .cart-title {
                font-size: 0.9rem;
            }

            .cart-total {
                font-size: 1rem;
            }

            .checkout-btn {
                font-size: 0.85rem;
                padding: var(--spacing-xs) var(--spacing-sm);
            }
        }

        /* Animation và Effects */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes slideInFromRight {
            from {
                transform: translateX(150%) translateY(0); /* Adjusted for bottom-right start */
                opacity: 0;
            }
            to {
                transform: translateX(0) translateY(0);
                opacity: 1;
            }
        }


        .service-card {
            animation: fadeInUp 0.6s ease forwards;
        }

        .cart-summary {
            animation: slideInFromRight 0.5s ease forwards;
        }

        /* Custom Scrollbar */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: var(--secondary-dark);
        }

        ::-webkit-scrollbar-thumb {
            background: var(--gradient-gold);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--primary-gold);
        }

        /* Selection Color */
        ::selection {
            background: var(--primary-gold);
            color: var(--primary-dark);
        }

        ::-moz-selection {
            background: var(--primary-gold);
            color: var(--primary-dark);
        }

        /* CSS for the fixed navbar to ensure content doesn't hide behind it */
        .fixed-navbar-padding {
            padding-top: 70px; /* Adjust this value based on your actual navbar height */
            /* This class will be added to .main-container or <body> */
        }
    </style>
</head>
<body>
    <%-- Include the navbar.jsp. Ensure navbar.jsp itself does NOT include Bootstrap CSS/JS --%>
    <jsp:include page="/views/common/navbar.jsp"/>

    <div class="main-container">
        <div class="header">
            <h1 class="main-title">Chọn Dịch Vụ Cao Cấp</h1>
            <p class="subtitle">Trải nghiệm dịch vụ chăm sóc nam giới đẳng cấp với công nghệ hiện đại tại Cut&Styles Barber</p>
            <div class="search-container">
                <span class="search-icon">🔍</span>
                <input type="text" class="search-input" placeholder="Tìm kiếm dịch vụ..." id="searchInput">
            </div>
        </div>

        <%-- Section: Cắt Tóc Chuyên Nghiệp (categoryId = 1) --%>
        <section class="service-section">
            <div class="section-header">
                <h2 class="section-title"><i class="fas fa-scissors"></i> Cắt Tóc Chuyên Nghiệp</h2>
                <p class="section-description">Dịch vụ cắt tóc cao cấp với kỹ thuật tinh tế, phong cách hiện đại.</p>
            </div>
            <div class="services-grid">
                <c:set var="hasServicesInThisCategory" value="false" />
                <c:forEach var="service" items="${services}"> <%-- Loop through all services --%>
                    <c:if test="${service.categoryId == 1}"> <%-- Filter by categoryId --%>
                        <c:set var="hasServicesInThisCategory" value="true" />
                        <div class="service-card" data-service-id="${service.id}" data-service-name="${service.name}" data-service-price="${service.price != null ? service.price : 0}" data-service-type="${service.categoryId}">
                            <div class="service-info">
                                <h3 class="service-title"><c:out value="${service.name}" /></h3>
                                <p class="service-description"><c:out value="${service.description}" /></p>
                            </div>

                            <div class="service-images">
                                <c:forEach var="imagePath" items="${service.image}" varStatus="imgLoop">
                                    <c:if test="${not empty imagePath && imgLoop.index < 3}">
                                        <div class="service-image">
                                            <img src="${pageContext.request.contextPath}/${imagePath}" alt="${service.name} ${imgLoop.index + 1}" onerror="this.src='${pageContext.request.contextPath}/image/image_service/default_service_image.png'"/>
                                        </div>
                                    </c:if>
                                </c:forEach>
                                <c:set var="actualImagesLoaded" value="0" />
                                <c:forEach var="path" items="${service.image}">
                                    <c:if test="${not empty path}">
                                        <c:set var="actualImagesLoaded" value="${actualImagesLoaded + 1}" />
                                    </c:if>
                                </c:forEach>
                                <c:if test="${actualImagesLoaded < 3}">
                                    <c:forEach begin="${actualImagesLoaded}" end="2">
                                        <div class="service-image">
                                            <img src="${pageContext.request.contextPath}/image/image_service/default_service_image.png" alt="Default service image"/>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>

                            <div class="service-meta">
                                <div class="service-duration">${service.duration} Phút</div>
                                <div class="service-price">
                                    <fmt:formatNumber value="${service.price != null ? service.price : 0}" type="number" groupingUsed="true" /> VNĐ
                                </div>
                            </div>

                            <button class="add-to-cart"
                                    data-service-id="${service.id}"
                                    data-service-name="${service.name}"
                                    data-service-price="${service.price != null ? service.price : 0}"
                                    data-service-type="${service.categoryId}">
                                Thêm Vào Đơn
                            </button>
                        </div>
                    </c:if>
                </c:forEach>
                <c:if test="${not hasServicesInThisCategory}">
                    <p style="color: var(--text-muted); width: 100%; text-align: center; font-style: italic;">Không có dịch vụ nào trong danh mục này.</p>
                </c:if>
            </div>
        </section>

        <%-- Section: Uốn Định Hình Nếp Tóc (categoryId = 2) --%>
        <section class="service-section">
            <div class="section-header">
                <h2 class="section-title"><i class="fas fa-magic"></i> Uốn Định Hình Nếp Tóc</h2>
                <p class="section-description">Uốn định hình nếp tóc bền đẹp, giữ form lâu dài với công nghệ tiên tiến.</p>
            </div>
            <div class="services-grid">
                <c:set var="hasServicesInThisCategory" value="false" />
                <c:forEach var="service" items="${services}">
                    <c:if test="${service.categoryId == 2}">
                        <c:set var="hasServicesInThisCategory" value="true" />
                        <div class="service-card" data-service-id="${service.id}" data-service-name="${service.name}" data-service-price="${service.price != null ? service.price : 0}" data-service-type="${service.categoryId}">
                            <div class="service-info"> <%-- Changed from service-header-section as it's not a common Bootstrap class --%>
                                <h3 class="service-title"><c:out value="${service.name}" /></h3>
                                <p class="service-description"><c:out value="${service.description}" /></p>
                            </div>
                            <div class="service-images">
                                <c:forEach var="imagePath" items="${service.image}" varStatus="imgLoop">
                                    <c:if test="${not empty imagePath && imgLoop.index < 3}">
                                        <div class="service-image">
                                            <img src="${pageContext.request.contextPath}/${imagePath}" alt="${service.name} ${imgLoop.index + 1}" onerror="this.src='${pageContext.request.contextPath}/image/image_service/default_service_image.png'"/>
                                        </div>
                                    </c:if>
                                </c:forEach>
                                <c:set var="actualImagesLoaded" value="0" />
                                <c:forEach var="path" items="${service.image}">
                                    <c:if test="${not empty path}">
                                        <c:set var="actualImagesLoaded" value="${actualImagesLoaded + 1}" />
                                    </c:if>
                                </c:forEach>
                                <c:if test="${actualImagesLoaded < 3}">
                                    <c:forEach begin="${actualImagesLoaded}" end="2">
                                        <div class="service-image">
                                            <img src="${pageContext.request.contextPath}/image/image_service/default_service_image.png" alt="Default service image"/>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                            <div class="service-meta">
                                <div class="service-duration">${service.duration} Phút</div>
                                <div class="service-price">
                                    <fmt:formatNumber value="${service.price != null ? service.price : 0}" type="number" groupingUsed="true" /> VNĐ
                                </div>
                            </div>
                            <button class="add-to-cart"
                                    data-service-id="${service.id}"
                                    data-service-name="${service.name}"
                                    data-service-price="${service.price != null ? service.price : 0}"
                                    data-service-type="${service.categoryId}">
                                Thêm Vào Đơn
                            </button>
                        </div>
                    </c:if>
                </c:forEach>
                <c:if test="${not hasServicesInThisCategory}">
                    <p style="color: var(--text-muted); width: 100%; text-align: center; font-style: italic;">Không có dịch vụ nào trong danh mục này.</p>
                </c:if>
            </div>
        </section>

        <%-- Section: Thay Đổi Màu Tóc (categoryId = 3) --%>
        <section class="service-section">
            <div class="section-header">
                <h2 class="section-title"><i class="fas fa-palette"></i> Thay Đổi Màu Tóc</h2>
                <p class="section-description">Thay đổi màu tóc với bảng màu đa dạng, an toàn và chuyên nghiệp.</p>
            </div>
            <div class="services-grid">
                <c:set var="hasServicesInThisCategory" value="false" />
                <c:forEach var="service" items="${services}">
                    <c:if test="${service.categoryId == 3}">
                        <c:set var="hasServicesInThisCategory" value="true" />
                        <div class="service-card" data-service-id="${service.id}" data-service-name="${service.name}" data-service-price="${service.price != null ? service.price : 0}" data-service-type="${service.categoryId}">
                            <div class="service-info">
                                <h3 class="service-title"><c:out value="${service.name}" /></h3>
                                <p class="service-description"><c:out value="${service.description}" /></p>
                            </div>
                            <div class="service-images">
                                <c:forEach var="imagePath" items="${service.image}" varStatus="imgLoop">
                                    <c:if test="${not empty imagePath && imgLoop.index < 3}">
                                        <div class="service-image">
                                            <img src="${pageContext.request.contextPath}/${imagePath}" alt="${service.name} ${imgLoop.index + 1}" onerror="this.src='${pageContext.request.contextPath}/image/image_service/default_service_image.png'"/>
                                        </div>
                                    </c:if>
                                </c:forEach>
                                <c:set var="actualImagesLoaded" value="0" />
                                <c:forEach var="path" items="${service.image}">
                                    <c:if test="${not empty path}">
                                        <c:set var="actualImagesLoaded" value="${actualImagesLoaded + 1}" />
                                    </c:if>
                                </c:forEach>
                                <c:if test="${actualImagesLoaded < 3}">
                                    <c:forEach begin="${actualImagesLoaded}" end="2">
                                        <div class="service-image">
                                            <img src="${pageContext.request.contextPath}/image/image_service/default_service_image.png" alt="Default service image"/>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                            <div class="service-meta">
                                <div class="service-duration">${service.duration} Phút</div>
                                <div class="service-price">
                                    <fmt:formatNumber value="${service.price != null ? service.price : 0}" type="number" groupingUsed="true" /> VNĐ
                                </div>
                            </div>
                            <button class="add-to-cart"
                                    data-service-id="${service.id}"
                                    data-service-name="${service.name}"
                                    data-service-price="${service.price != null ? service.price : 0}"
                                    data-service-type="${service.categoryId}">
                                Thêm Vào Đơn
                            </button>
                        </div>
                    </c:if>
                </c:forEach>
                <c:if test="${not hasServicesInThisCategory}">
                    <p style="color: var(--text-muted); width: 100%; text-align: center; font-style: italic;">Không có dịch vụ nào trong danh mục này.</p>
                </c:if>
            </div>
        </section>

        <%-- Section: Spa & Thư Giãn (categoryId = 4) --%>
        <section class="service-section">
            <div class="section-header">
                <h2 class="section-title"><i class="fas fa-spa"></i> Spa & Thư Giãn</h2>
                <p class="section-description">Dịch vụ spa và thư giãn giúp bạn tái tạo năng lượng và chăm sóc toàn diện.</p>
            </div>
            <div class="services-grid">
                <c:set var="hasServicesInThisCategory" value="false" />
                <c:forEach var="service" items="${services}">
                    <c:if test="${service.categoryId == 4}">
                        <c:set var="hasServicesInThisCategory" value="true" />
                        <div class="service-card" data-service-id="${service.id}" data-service-name="${service.name}" data-service-price="${service.price != null ? service.price : 0}" data-service-type="${service.categoryId}">
                            <div class="service-info">
                                <h3 class="service-title"><c:out value="${service.name}" /></h3>
                                <p class="service-description"><c:out value="${service.description}" /></p>
                            </div>
                            <div class="service-images">
                                <c:forEach var="imagePath" items="${service.image}" varStatus="imgLoop">
                                    <c:if test="${not empty imagePath && imgLoop.index < 3}">
                                        <div class="service-image">
                                            <img src="${pageContext.request.contextPath}/${imagePath}" alt="${service.name} ${imgLoop.index + 1}" onerror="this.src='${pageContext.request.contextPath}/image/image_service/default_service_image.png'"/>
                                        </div>
                                    </c:if>
                                </c:forEach>
                                <c:set var="actualImagesLoaded" value="0" />
                                <c:forEach var="path" items="${service.image}">
                                    <c:if test="${not empty path}">
                                        <c:set var="actualImagesLoaded" value="${actualImagesLoaded + 1}" />
                                    </c:if>
                                </c:forEach>
                                <c:if test="${actualImagesLoaded < 3}">
                                    <c:forEach begin="${actualImagesLoaded}" end="2">
                                        <div class="service-image">
                                            <img src="${pageContext.request.contextPath}/image/image_service/default_service_image.png" alt="Default service image"/>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                            <div class="service-meta">
                                <div class="service-duration">${service.duration} Phút</div>
                                <div class="service-price">
                                    <fmt:formatNumber value="${service.price != null ? service.price : 0}" type="number" groupingUsed="true" /> VNĐ
                                </div>
                            </div>
                            <button class="add-to-cart"
                                    data-service-id="${service.id}"
                                    data-service-name="${service.name}"
                                    data-service-price="${service.price != null ? service.price : 0}"
                                    data-service-type="${service.categoryId}">
                                Thêm Vào Đơn
                            </button>
                        </div>
                    </c:if>
                </c:forEach>
                <c:if test="${not hasServicesInThisCategory}">
                    <p style="color: var(--text-muted); width: 100%; text-align: center; font-style: italic;">Không có dịch vụ nào trong danh mục này.</p>
                </c:if>
            </div>
        </section>

        <%-- Section: Dịch Vụ Lấy Ráy Tai (categoryId = 5) --%>
        <section class="service-section">
            <div class="section-header">
                <h2 class="section-title"><i class="fas fa-ear-muffs"></i> Dịch Vụ Lấy Ráy Tai</h2>
                <p class="section-description">Dịch vụ lấy ráy tai an toàn, sạch sẽ, mang lại cảm giác thoải mái và dễ chịu.</p>
            </div>
            <div class="services-grid">
                <c:set var="hasServicesInThisCategory" value="false" />
                <c:forEach var="service" items="${services}">
                    <c:if test="${service.categoryId == 5}">
                        <c:set var="hasServicesInThisCategory" value="true" />
                        <div class="service-card" data-service-id="${service.id}" data-service-name="${service.name}" data-service-price="${service.price != null ? service.price : 0}" data-service-type="${service.categoryId}">
                            <div class="service-info">
                                <h3 class="service-title"><c:out value="${service.name}" /></h3>
                                <p class="service-description"><c:out value="${service.description}" /></p>
                            </div>
                            <div class="service-images">
                                <c:forEach var="imagePath" items="${service.image}" varStatus="imgLoop">
                                    <c:if test="${not empty imagePath && imgLoop.index < 3}">
                                        <div class="service-image">
                                            <img src="${pageContext.request.contextPath}/${imagePath}" alt="${service.name} ${imgLoop.index + 1}" onerror="this.src='${pageContext.request.contextPath}/image/image_service/default_service_image.png'"/>
                                        </div>
                                    </c:if>
                                </c:forEach>
                                <c:set var="actualImagesLoaded" value="0" />
                                <c:forEach var="path" items="${service.image}">
                                    <c:if test="${not empty path}">
                                        <c:set var="actualImagesLoaded" value="${actualImagesLoaded + 1}" />
                                    </c:if>
                                </c:forEach>
                                <c:if test="${actualImagesLoaded < 3}">
                                    <c:forEach begin="${actualImagesLoaded}" end="2">
                                        <div class="service-image">
                                            <img src="${pageContext.request.contextPath}/image/image_service/default_service_image.png" alt="Default service image"/>
                                        </div>
                                    </c:forEach>
                                </c:if>
                            </div>
                            <div class="service-meta">
                                <div class="service-duration">${service.duration} Phút</div>
                                <div class="service-price">
                                    <fmt:formatNumber value="${service.price != null ? service.price : 0}" type="number" groupingUsed="true" /> VNĐ
                                </div>
                            </div>
                            <button class="add-to-cart"
                                    data-service-id="${service.id}"
                                    data-service-name="${service.name}"
                                    data-service-price="${service.price != null ? service.price : 0}"
                                    data-service-type="${service.categoryId}">
                                Thêm Vào Đơn
                            </button>
                        </div>
                    </c:if>
                </c:forEach>
                <c:if test="${not hasServicesInThisCategory}">
                    <p style="color: var(--text-muted); width: 100%; text-align: center; font-style: italic;">Không có dịch vụ nào trong danh mục này.</p>
                </c:if>
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
        <div class="cart-info">
            <div class="cart-title">Tổng Hóa Đơn<span class="cart-item-count" id="cartItemCount">0</span></div>
            <div class="cart-total" id="cartTotal">0 VNĐ</div>
        </div>
        <button class="checkout-btn" onclick="checkout()">Xong</button>
    </div>

    <%-- Form gửi dữ liệu dịch vụ đã chọn về ChooseServiceServlet (hoặc BookingServlet) --%>
    <form id="serviceSelectionForm" action="${pageContext.request.contextPath}/ChooseServiceServlet" method="POST" style="display: none;">
        <input type="hidden" name="serviceNames" id="serviceNamesInput">
        <input type="hidden" name="totalPrice" id="totalPriceInput">
        <input type="hidden" name="serviceIds" id="serviceIdsInput"> <%-- Added for sending IDs --%>
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
                        // Fixed the selector - properly escape single quotes if needed, but often not with data-attributes
                        const button = document.querySelector(`.add-to-cart[data-service-id="${item.id}"]`); // Use ID for robust selection
                        if (button) {
                            button.classList.add('in-cart');
                            button.textContent = 'Đã Thêm';
                        }
                    });
                    updateCartSummary();
                } catch (e) {
                    console.error("Failed to parse cart from session storage:", e);
                    cart = []; // Reset cart if parsing fails
                    updateCartSummary(); // Still update to show empty cart
                }
            } else {
                // Initialize empty cart display
                updateCartSummary();
            }
        }

        // Function to save cart to session storage
        function saveCartToSession() {
            try {
                sessionStorage.setItem('selectedServicesCart', JSON.stringify(cart));
            } catch (e) {
                console.error("Failed to save cart to session storage:", e);
            }
        }

        function addToCart(serviceId, serviceName, servicePrice, serviceType) {
            const button = event.target;
            // Use serviceId for uniqueness check to avoid issues with same names
            const itemIndex = cart.findIndex(item => item.id === serviceId);

            if (itemIndex > -1) { // If service is already in cart, remove it
                cart.splice(itemIndex, 1);
                button.classList.remove('in-cart');
                button.textContent = 'Thêm Vào Đơn';
            } else { // If service is not in cart, add it
                const price = parseInt(servicePrice) || 0; // Ensure price is an integer
                cart.push({
                    id: serviceId,
                    name: serviceName,
                    price: price,
                    type: serviceType
                });
                button.classList.add('in-cart');
                button.textContent = 'Đã Thêm';
            }

            updateCartSummary();
            saveCartToSession();
            console.log('Cart updated:', cart);
        }

        function updateCartSummary() {
            const cartItemCount = document.getElementById('cartItemCount');
            const cartTotal = document.getElementById('cartTotal');
            const cartSummary = document.querySelector('.cart-summary');
            const checkoutBtn = document.querySelector('.checkout-btn');

            // Check if elements exist
            if (!cartItemCount || !cartTotal || !cartSummary || !checkoutBtn) {
                console.error('Cart summary elements not found');
                return;
            }

            const totalPrice = cart.reduce((sum, item) => {
                const price = parseInt(item.price) || 0;
                return sum + price;
            }, 0);

            // Update cart display
            cartItemCount.textContent = cart.length;
            cartTotal.textContent = totalPrice.toLocaleString('vi-VN') + ' VNĐ';

            // Show/hide cart summary based on cart content
            if (cart.length > 0) {
                cartSummary.classList.remove('hidden');
                cartSummary.style.display = 'block'; // Ensure it's block
                checkoutBtn.disabled = false; // Enable checkout button
            } else {
                // Keep it visible but show empty state, disable button
                cartSummary.classList.remove('hidden'); // Ensure it remains visible even if empty
                cartSummary.style.display = 'block';
                checkoutBtn.disabled = true; // Disable checkout button
            }

            console.log('Cart summary updated - Items:', cart.length, 'Total:', totalPrice);
        }

        function checkout() {
            if (cart.length === 0) {
                alert('Giỏ hàng trống! Vui lòng chọn ít nhất một dịch vụ.');
                return;
            }

            const serviceNames = cart.map(item => item.name);
            const serviceIds = cart.map(item => item.id); // Get IDs
            const totalPrice = cart.reduce((sum, item) => {
                const price = parseInt(item.price) || 0;
                return sum + price;
            }, 0);

            // Gán dữ liệu vào form ẩn
            const serviceNamesInput = document.getElementById('serviceNamesInput');
            const totalPriceInput = document.getElementById('totalPriceInput');
            const serviceIdsInput = document.getElementById('serviceIdsInput'); // Get the new input

            if (serviceNamesInput && totalPriceInput && serviceIdsInput) {
                serviceNamesInput.value = serviceNames.join(',');
                totalPriceInput.value = totalPrice;
                serviceIdsInput.value = JSON.stringify(serviceIds); // Send IDs as a JSON string or comma-separated

                console.log('Sending data to ChooseServiceServlet POST:');
                console.log('serviceNames:', serviceNames.join(','));
                console.log('totalPrice:', totalPrice);
                console.log('serviceIds:', JSON.stringify(serviceIds));

                // Gửi form tới ChooseServiceServlet
                const form = document.getElementById('serviceSelectionForm');
                if (form) {
                    form.submit();
                } else {
                    console.error('Service selection form not found');
                }
            } else {
                console.error('Form inputs not found');
            }
        }

        // Khởi tạo event listeners
        document.addEventListener('DOMContentLoaded', () => {
            console.log('DOM loaded, initializing cart...');

            // Add Bootstrap CSS link here if you prefer a single source for it (already done above)
            // You had it in the <head>, which is ideal.

            // Ensure fixed navbar padding
            const mainContainer = document.querySelector('.main-container');
            if (mainContainer) {
                mainContainer.classList.add('fixed-navbar-padding');
            }

            // Force show cart summary initially
            const cartSummary = document.querySelector('.cart-summary');
            if (cartSummary) {
                cartSummary.style.display = 'block';
                cartSummary.classList.remove('hidden'); // Ensure it's not hidden by the class
            }

            loadCartFromSession(); // Load cart on page load

            // Add event listeners to all add-to-cart buttons
            const addToCartButtons = document.querySelectorAll('.add-to-cart');
            console.log('Found', addToCartButtons.length, 'add-to-cart buttons');

            addToCartButtons.forEach(button => {
                button.addEventListener('click', (event) => {
                    event.preventDefault(); // Prevent any default behavior

                    const serviceId = parseInt(button.getAttribute('data-service-id')) || 0;
                    const serviceName = button.getAttribute('data-service-name');
                    const servicePrice = parseInt(button.getAttribute('data-service-price')) || 0;
                    const serviceType = button.getAttribute('data-service-type');

                    console.log('Button clicked:', serviceName, servicePrice);
                    addToCart(serviceId, serviceName, servicePrice, serviceType);
                });
            });

            // Live search functionality
            const searchInput = document.getElementById('searchInput');
            if (searchInput) {
                searchInput.addEventListener('keyup', () => {
                    const searchTerm = searchInput.value.toLowerCase();
                    document.querySelectorAll('.service-card').forEach(card => {
                        const serviceTitle = card.querySelector('.service-title');
                        if (serviceTitle) {
                            const titleText = serviceTitle.textContent.toLowerCase();
                            if (titleText.includes(searchTerm)) {
                                card.style.display = 'flex'; // Use flex to maintain layout
                            } else {
                                card.style.display = 'none';
                            }
                        }
                    });
                });
            }

            // Ensure image paths are correct for dynamically loaded images
            document.querySelectorAll('.service-image img').forEach(img => {
                img.addEventListener('error', function () {
                    this.src = '${pageContext.request.contextPath}/image/image_service/default_service_image.png';
                });

                // Check if src contains null or is empty
                if (!img.src || img.src.includes('null') || img.src.trim() === '') {
                    img.src = '${pageContext.request.contextPath}/image/image_service/default_service_image.png';
                }
            });

            console.log('Cart initialization complete');
        });

        // Additional debugging - check if cart summary exists after page load
        window.addEventListener('load', () => {
            setTimeout(() => {
                const cartSummary = document.querySelector('.cart-summary');
                const cartItemCount = document.getElementById('cartItemCount');
                const cartTotal = document.getElementById('cartTotal');

                console.log('Page fully loaded - Cart summary elements check:');
                console.log('Cart summary exists:', !!cartSummary);
                console.log('Cart item count exists:', !!cartItemCount);
                console.log('Cart total exists:', !!cartTotal);

                if (cartSummary) {
                    console.log('Cart summary display style:', getComputedStyle(cartSummary).display);
                    console.log('Cart summary visibility:', getComputedStyle(cartSummary).visibility);
                }

                // Force update cart summary one more time
                updateCartSummary();
            }, 100);
        });
    </script>
</body>
</html>