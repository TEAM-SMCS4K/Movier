package cs.sookmyung.movier.config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

public class ConfigLoader {
    private static final Properties prop = new Properties();
    private static ConfigLoader instance;

    // private 생성자
    private ConfigLoader() {
        try (InputStream input = ConfigLoader.class.getClassLoader().getResourceAsStream("application.properties");) {
            prop.load(input);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public static synchronized ConfigLoader getInstance() {
        if (instance == null) {
            instance = new ConfigLoader();
        }
        return instance;
    }

    public String getKey(String key) {
        System.out.println(prop.getProperty(key));
        return prop.getProperty(key);
    }
}