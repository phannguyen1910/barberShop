/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author LENOVO
 */
public class Advise {

    private int id;
    private String question;
    private String answer;
    private int serviceId;
    private String type;
    private String targetAge;
    private String faceShape;
    private Integer minPrice;
    private Integer maxPrice;
    private Integer duration;
    private Integer colorFadeTime;
    private String image;
    private String serviceName;
    private float servicePrice;
    private String serviceDescription;

    // Constructors
    public Advise() {
    }

    public Advise(int id, String question, String answer, int serviceId, String type, String targetAge,
            String faceShape, Integer minPrice, Integer maxPrice, Integer duration, Integer colorFadeTime, String image) {
        this.id = id;
        this.question = question;
        this.answer = answer;
        this.serviceId = serviceId;
        this.type = type;
        this.targetAge = targetAge;
        this.faceShape = faceShape;
        this.minPrice = minPrice;
        this.maxPrice = maxPrice;
        this.duration = duration;
        this.colorFadeTime = colorFadeTime;
        this.image = image;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getTargetAge() {
        return targetAge;
    }

    public void setTargetAge(String targetAge) {
        this.targetAge = targetAge;
    }

    public String getFaceShape() {
        return faceShape;
    }

    public void setFaceShape(String faceShape) {
        this.faceShape = faceShape;
    }

    public Integer getMinPrice() {
        return minPrice;
    }

    public void setMinPrice(Integer minPrice) {
        this.minPrice = minPrice;
    }

    public Integer getMaxPrice() {
        return maxPrice;
    }

    public void setMaxPrice(Integer maxPrice) {
        this.maxPrice = maxPrice;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    public Integer getColorFadeTime() {
        return colorFadeTime;
    }

    public void setColorFadeTime(Integer colorFadeTime) {
        this.colorFadeTime = colorFadeTime;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public float getServicePrice() {
        return servicePrice;
    }

    public void setServicePrice(float servicePrice) {
        this.servicePrice = servicePrice;
    }

    public String getServiceDescription() {
        return serviceDescription;
    }

    public void setServiceDescription(String serviceDescription) {
        this.serviceDescription = serviceDescription;
    }
}
