package com.mlb.product.dto;

public class TeamDto {
    private String tm_id;
    private String tm_name;

    public TeamDto() {
    }

    public TeamDto(String tm_id, String tm_name) {
        this.tm_id = tm_id;
        this.tm_name = tm_name;
    }

    public String getTm_id() {
        return tm_id;
    }

    public void setTm_id(String tm_id) {
        this.tm_id = tm_id;
    }

    public String getTm_name() {
        return tm_name;
    }

    public void setTm_name(String tm_name) {
        this.tm_name = tm_name;
    }

    @Override
    public String toString() {
        return "TeamDto{" +
                "tm_id='" + tm_id + '\'' +
                ", tm_name='" + tm_name + '\'' +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        TeamDto teamDto = (TeamDto) o;

        if (tm_id != null ? !tm_id.equals(teamDto.tm_id) : teamDto.tm_id != null) return false;
        return tm_name != null ? tm_name.equals(teamDto.tm_name) : teamDto.tm_name == null;
    }
}
