package Modelo;

public class Usuario {
    
    // Atributos
    private int idUsu;
    private String nombreUsu;
    private String emailUsu;
    private String password;
    private int rolUsu;  // 1: Admin, 2: Vendedor u otro

    // Constructor vacío
    public Usuario() {
    }

    // Constructor completo (opcional)
    public Usuario(int idUsu, String nombreUsu, String emailUsu, String password, int rolUsu) {
        this.idUsu = idUsu;
        this.nombreUsu = nombreUsu;
        this.emailUsu = emailUsu;
        this.password = password;
        this.rolUsu = rolUsu;
    }

    // Getters y Setters
    public int getIdUsu() {
        return idUsu;
    }

    public void setIdUsu(int idUsu) {
        this.idUsu = idUsu;
    }

    public String getNombreUsu() {
        return nombreUsu;
    }

    public void setNombreUsu(String nombreUsu) {
        this.nombreUsu = nombreUsu;
    }

    public String getEmailUsu() {
        return emailUsu;
    }

    public void setEmailUsu(String emailUsu) {
        this.emailUsu = emailUsu;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public int getRolUsu() {
        return rolUsu;
    }

    public void setRolUsu(int rolUsu) {
        this.rolUsu = rolUsu;
    }
}
