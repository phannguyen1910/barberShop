<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Cut&Styles Carousel</title>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/CSS/support.css">
        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Font Awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>
    <body>
        <!-- Navbar -->
        <%@ include file="/views/common/navbar.jsp" %>

        <!-- FAQ Section -->
        <section class="faq-section">
            <div class="container">
                <h2 class="faq-title">Các câu hỏi thường gặp</h2>

                <div class="faq-container">
                    <!-- FAQ Item 1 -->
                    <div class="faq-item">
                        <div class="faq-question" onclick="toggleFaq(this)">
                            <span>Anh không đặt lịch trước đến có được phục vụ không?</span>
                            <div class="faq-toggle">+</div>
                        </div>
                        <div class="faq-answer">
                            <p>Chúng tôi luôn ưu tiên phục vụ khách hàng đã đặt lịch trước. Tuy nhiên, nếu salon không quá đông và có thợ cắt tóc rảnh, chúng tôi vẫn có thể phục vụ quý khách. Để được phục vụ tốt nhất và không phải chờ đợi, chúng tôi khuyến khích đặt lịch trước qua website hoặc số điện thoại của salon.</p>
                        </div>
                    </div>
                    <!-- FAQ Item 3 -->
                    <div class="faq-item">
                        <div class="faq-question" onclick="toggleFaq(this)">
                            <span>Anh đã đặt lịch, đến salon anh sẽ phải làm gì tiếp theo, gặp ai, đưa lịch cho ai?</span>
                            <div class="faq-toggle">+</div>
                        </div>
                        <div class="faq-answer">
                            <p>Khi đến salon, quý khách chỉ cần thông báo với lễ tân tại quầy tiếp tân rằng quý khách đã đặt lịch trước. Nhân viên sẽ kiểm tra thông tin đặt lịch của quý khách trong hệ thống và hướng dẫn quý khách đến khu vực chờ. Thợ cắt tóc sẽ đón quý khách theo đúng giờ hẹn. Quý khách không cần phải xuất trình bất kỳ giấy tờ nào, chỉ cần cung cấp tên và số điện thoại đã dùng để đặt lịch.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 4 -->
                    <div class="faq-item">
                        <div class="faq-question" onclick="toggleFaq(this)">
                            <span>Anh đến đây có được tư vấn kiểu tóc kỹ không?</span>
                            <div class="faq-toggle">+</div>
                        </div>
                        <div class="faq-answer">
                            <p>Chắc chắn rồi! Đội ngũ thợ cắt tóc chuyên nghiệp của chúng tôi luôn sẵn sàng tư vấn kiểu tóc phù hợp nhất với hình dáng khuôn mặt, phong cách cá nhân và mong muốn của quý khách. Chúng tôi sẽ dành thời gian lắng nghe và tư vấn kỹ lưỡng trước khi thực hiện bất kỳ dịch vụ nào, đảm bảo quý khách hài lòng với kết quả cuối cùng.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 5 -->
                    <div class="faq-item">
                        <div class="faq-question" onclick="toggleFaq(this)">
                            <span>Anh cảm thấy kiểu tóc sau khi cắt chưa thật sự ưng ý, anh nên làm sao?</span>
                            <div class="faq-toggle">+</div>
                        </div>
                        <div class="faq-answer">
                            <p>Sự hài lòng của khách hàng luôn là ưu tiên hàng đầu của chúng tôi. Nếu quý khách không hoàn toàn hài lòng với kiểu tóc sau khi cắt, xin vui lòng thông báo ngay cho thợ cắt hoặc quản lý salon. Chúng tôi cam kết sẽ điều chỉnh miễn phí trong vòng 7 ngày sau khi cắt tóc. Đừng ngại chia sẻ ý kiến của mình, chúng tôi luôn mong muốn được lắng nghe và phục vụ quý khách tốt nhất.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 6 -->
                    <div class="faq-item">
                        <div class="faq-question" onclick="toggleFaq(this)">
                            <span>Thời gian cắt tóc Shine Combo có lâu không?</span>
                            <div class="faq-toggle">+</div>
                        </div>
                        <div class="faq-answer">
                            <p>Thời gian hoàn thành Cut&Styles Combo thường dao động từ 45-60 phút, tùy thuộc vào độ dài và phức tạp của kiểu tóc. Combo này bao gồm cắt tóc, gội đầu massage, sấy tạo kiểu và các bước dưỡng. Chúng tôi chú trọng vào chất lượng và sự tỉ mỉ trong từng bước, nên thời gian có thể dài hơn một chút so với dịch vụ cắt tóc thông thường.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 7 -->
                    <div class="faq-item">
                        <div class="faq-question" onclick="toggleFaq(this)">
                            <span>2 người đặt chung 1 số điện thoại được không?</span>
                            <div class="faq-toggle">+</div>
                        </div>
                        <div class="faq-answer">
                            <p>Có thể sử dụng chung một số điện thoại để đặt lịch cho 2 người, nhưng khi đặt lịch, quý khách vui lòng cung cấp đầy đủ tên của cả hai người để chúng tôi có thể phân biệt và sắp xếp lịch chính xác. Quý khách cũng nên đặt lịch vào các khung giờ liên tiếp nếu muốn được phục vụ cùng lúc hoặc gần nhau.</p>
                        </div>
                    </div>

       

                    <!-- FAQ Item 9 -->
                    <div class="faq-item">
                        <div class="faq-question" onclick="toggleFaq(this)">
                            <span>Anh có cần phải gội đầu trước khi đến không?</span>
                            <div class="faq-toggle">+</div>
                        </div>
                        <div class="faq-answer">
                            <p>Quý khách không cần gội đầu trước khi đến salon. Với hầu hết các dịch vụ của chúng tôi, đặc biệt là các gói combo, đều đã bao gồm bước gội đầu chuyên nghiệp với dầu gội chất lượng cao và massage da đầu thư giãn. Thực tế, tóc tự nhiên (không quá bẩn) sẽ giúp thợ cắt đánh giá tốt hơn về độ rụng, chất tóc và kiểu tóc phù hợp với quý khách.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 10 -->
                    <div class="faq-item">
                        <div class="faq-question" onclick="toggleFaq(this)">
                            <span>Anh muốn đến trước giờ đặt có được không?</span>
                            <div class="faq-toggle">+</div>
                        </div>
                        <div class="faq-answer">
                            <p>Quý khách có thể đến sớm hơn giờ hẹn khoảng 10-15 phút để làm thủ tục và thư giãn tại khu vực chờ của salon. Tuy nhiên, việc phục vụ sẽ được thực hiện theo đúng thời gian đã đặt trước, vì chúng tôi cần sắp xếp thời gian hợp lý cho tất cả khách hàng. Nếu quý khách đến quá sớm và salon có thợ rảnh, chúng tôi sẽ cố gắng sắp xếp phục vụ sớm hơn nếu có thể.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 11 -->
                    <div class="faq-item">
                        <div class="faq-question" onclick="toggleFaq(this)">
                            <span>Anh đã đặt lịch mà không qua được thì sao?</span>
                            <div class="faq-toggle">+</div>
                        </div>
                        <div class="faq-answer">
                            <p>Nếu quý khách không thể đến theo lịch đã đặt, vui lòng thông báo cho chúng tôi càng sớm càng tốt qua số điện thoại hoặc ứng dụng đặt lịch. Việc hủy lịch trước ít nhất 1 giờ sẽ giúp chúng tôi có thể sắp xếp phục vụ khách hàng khác và không ảnh hưởng đến lịch trình hoạt động của salon. Quý khách có thể đặt lại lịch vào thời gian khác phù hợp hơn.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 12 -->
                    <div class="faq-item">
                        <div class="faq-question" onclick="toggleFaq(this)">
                            <span>Anh không muốn thanh toán bằng tiền mặt có được không?</span>
                            <div class="faq-toggle">+</div>
                        </div>
                        <div class="faq-answer">
                            <p>Ngoài tiền mặt, salon chúng tôi cung cấp nhiều phương thức thanh toán không dùng tiền mặt để đáp ứng nhu cầu của quý khách. Quý khách có thể thanh toán bằng thẻ ngân hàng (ATM, tín dụng), chuyển khoản ngân hàng, hoặc các ví điện tử phổ biến như Momo, ZaloPay, VNPay, Shopeepay. Đội ngũ nhân viên sẽ hướng dẫn quý khách cách thức thanh toán thuận tiện nhất.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 13 -->
                    <div class="faq-item">
                        <div class="faq-question" onclick="toggleFaq(this)">
                            <span>Anh chỉ cắt tóc thôi bỏ qua các bước khác có được không?</span>
                            <div class="faq-toggle">+</div>
                        </div>
                        <div class="faq-answer">
                            <p>Chúng tôi hoàn toàn linh hoạt trong việc điều chỉnh dịch vụ theo nhu cầu của quý khách. Nếu quý khách chỉ muốn cắt tóc và bỏ qua các bước khác như gội đầu, massage hay sấy tạo kiểu, chúng tôi sẽ thực hiện theo yêu cầu và điều chỉnh giá dịch vụ tương ứng. Quý khách vui lòng thông báo ngay từ đầu khi đặt lịch hoặc khi đến salon để chúng tôi phục vụ đúng nhu cầu.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 14 -->
                    <div class="faq-item">
                        <div class="faq-question" onclick="toggleFaq(this)">
                            <span>Cut&Style có cắt tóc cho trẻ em không?</span>
                            <div class="faq-toggle">+</div>
                        </div>
                        <div class="faq-answer">
                            <p>Cut&Styles Barber có dịch vụ cắt tóc cho trẻ em từ 6 tuổi trở lên. Chúng tôi có những thợ cắt tóc giàu kinh nghiệm và kiên nhẫn trong việc phục vụ các bé. Tuy nhiên, phụ huynh vui lòng đồng hành cùng các bé trong suốt quá trình thực hiện dịch vụ. Chúng tôi cũng có các góc chờ thân thiện với trẻ em với sách, đồ chơi và các hoạt động giải trí phù hợp.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 15 -->
                    <div class="faq-item">
                        <div class="faq-question" onclick="toggleFaq(this)">
                            <span>Ở đây có phải tips cho nhân viên không?</span>
                            <div class="faq-toggle">+</div>
                        </div>
                        <div class="faq-answer">
                            <p>Việc tip cho nhân viên tại salon của chúng tôi là hoàn toàn tự nguyện. Nếu quý khách hài lòng với dịch vụ và muốn gửi lời cảm ơn bằng tiền tip, chúng tôi và nhân viên đều rất trân trọng. Tuy nhiên, chúng tôi không yêu cầu hay mong đợi khách hàng phải tip. Mục tiêu của chúng tôi là đảm bảo mọi khách hàng đều nhận được dịch vụ chất lượng cao nhất, dù có tip hay không.</p>
                        </div>
                    </div>

                    <!-- FAQ Item 16 -->
                    <div class="faq-item">
                        <div class="faq-question" onclick="toggleFaq(this)">
                            <span>Để xe ở đây có an toàn không?</span>
                            <div class="faq-toggle">+</div>
                        </div>
                        <div class="faq-answer">
                            <p>Cut&Styles Barber có bãi đỗ xe riêng với hệ thống camera giám sát 24/7 và nhân viên bảo vệ chuyên nghiệp đảm bảo an toàn cho phương tiện của quý khách. Chúng tôi cung cấp dịch vụ trông giữ xe miễn phí cho khách hàng sử dụng dịch vụ tại salon. Quý khách có thể yên tâm tận hưởng trải nghiệm làm đẹp mà không phải lo lắng về phương tiện của mình.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>


        <!-- Footer -->
        <footer class="footer">
            <div class="container">
                <div class="row">
                    <!-- Logo and About -->
                    <div class="col-lg-4 col-md-6 footer-col">
                        <img src="${pageContext.request.contextPath}/image/image_logo/LogoShop.png" alt="Cut&Styles Logo" class="footer-logo">                      
                    </div>

                    <!-- Links -->
                    <div class="col-lg-4 col-md-6 footer-col">
                        <h4 class="footer-title">Liên kết nhanh</h4>
                        <ul class="footer-links">
                           <li><a href="${pageContext.request.contextPath}/views/common/aboutUs.jsp">Về chúng tôi</a></li>
                            <li><a href="${pageContext.request.contextPath}/views/common/franchise.jsp">Liên hệ nhượng quyền</a></li>
                            <li><a href="${pageContext.request.contextPath}/views/commit/details.jsp">Chính sách cam kết</a></li>
                        </ul>
                    </div>

                    <!-- Contact -->
                    <div class="col-lg-4 col-md-6 footer-col">
                        <h4 class="footer-title">Thông tin liên hệ</h4>
                        <div class="footer-contact">
                            <p><i class="bi bi-geo-alt-fill"></i> <span>Khu đô thị FPT city, Hòa Hải, Ngũ Hành Sơn, Đà Nẵng</span></p>
                            <p><i class="bi bi-telephone-fill"></i> <span>Liên hệ học nghề tóc: 0774511941</span></p>
                            <p><i class="bi bi-clock-fill"></i> <span>Giờ phục vụ: Thứ 2 đến Chủ Nhật, 8h30 - 20h30</span></p>
                        </div>
                    </div>
                </div>

                <!-- Footer bottom -->
                <div class="row footer-bottom">
                    <div  class="col-12 text-center">
                        <p>&copy; 2025 Cut&Styles Barber. Tất cả quyền được bảo lưu.</p>
                    </div>
                </div>
            </div>
        </footer>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
                            // JavaScript to handle accordion functionality
                            function toggleFaq(element) {
                                // Toggle active class on the question
                                element.classList.toggle('active');

                                // Get the answer element (next sibling)
                                const answer = element.nextElementSibling;
                                answer.classList.toggle('active');

                                // Adjust aria attributes for accessibility
                                const expanded = element.classList.contains('active');
                                element.setAttribute('aria-expanded', expanded);
                            }
        </script>
    </body>
</html>