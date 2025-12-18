package com.example.pcf;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class MessageController {

    @Value("${app.message:Hello from Kubernetes}")
    private String message;

    @GetMapping("/message")
    public String message() {
        return message;
    }
}

