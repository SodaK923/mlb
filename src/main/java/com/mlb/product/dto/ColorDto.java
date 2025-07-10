package com.mlb.product.dto;

public class ColorDto {
    private String cl_id;
    private String cl_name;
    private String cl_hexcode;

    public ColorDto() {
    }

    public ColorDto(String cl_id, String cl_name, String cl_hexcode) {
        this.cl_id = cl_id;
        this.cl_name = cl_name;
        this.cl_hexcode = cl_hexcode;
    }

    public String getCl_id() {
        return cl_id;
    }

    public void setCl_id(String cl_id) {
        this.cl_id = cl_id;
    }

    public String getCl_name() {
        return cl_name;
    }

    public void setCl_name(String cl_name) {
        this.cl_name = cl_name;
    }

    public String getCl_hexcode() {
        return cl_hexcode;
    }

    public void setCl_hexcode(String cl_hexcode) {
        this.cl_hexcode = cl_hexcode;
    }

    @Override
    public String toString() {
        return "ColorDto{" +
                "cl_id='" + cl_id + '\'' +
                ", cl_name='" + cl_name + '\'' +
                ", cl_hexcode='" + cl_hexcode + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ColorDto colorDto = (ColorDto) o;

        if (cl_id != null ? !cl_id.equals(colorDto.cl_id) : colorDto.cl_id != null) return false;
        if (cl_name != null ? !cl_name.equals(colorDto.cl_name) : colorDto.cl_name != null) return false;
        return cl_hexcode != null ? cl_hexcode.equals(colorDto.cl_hexcode) : colorDto.cl_hexcode == null;
    }

    @Override
    public int hashCode() {
        int result = cl_id != null ? cl_id.hashCode() : 0;
        result = 31 * result + (cl_name != null ? cl_name.hashCode() : 0);
        result = 31 * result + (cl_hexcode != null ? cl_hexcode.hashCode() : 0);
        return result;
    }
}
