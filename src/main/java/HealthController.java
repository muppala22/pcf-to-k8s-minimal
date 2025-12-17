import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HealthController {

    @Value("${app.message:Hello from Kubernetes}")
    private String message;

    @GetMapping("/health")
    public String health() {
        return "OK - " + message;
    }
}
