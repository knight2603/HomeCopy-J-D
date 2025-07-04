package Modelo;


public class DetalleVenta {
    
  private int idProducto, cantidad;
  private String nombre;
  private double precio_unitario;

    public int getIdProducto() {
        return idProducto;
    }

    public int getCantidad() {
        return cantidad;
    }

    public String getNombre() {
        return nombre;
    }

    public double getPrecio_unitario() {
        return precio_unitario;
    }

    public void setIdProducto(int idProducto) {
        this.idProducto = idProducto;
    }

    public void setCantidad(int cantidad) {
        this.cantidad = cantidad;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setPrecio_unitario(double precio_unitario) {
        this.precio_unitario = precio_unitario;
    }

    public void setIdDetalle(int aInt) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

private int idVenta;

public void setIdVenta(int idVenta) {
    this.idVenta = idVenta;
}

public int getIdVenta() {
    return idVenta;
}

  
}

