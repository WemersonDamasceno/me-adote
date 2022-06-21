package br.com.meadote.meadote.models;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "pessoa")
public class Pessoa {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;

    @Column
    private String nome;

    @Column
    private String email;

    @OneToMany
    private List<Pet> petFavorites;

    @Column
    private String urlPerfil;

    public Pessoa() {

    }

    public Pessoa(String nome, String email, List<Pet> petFavorites, String urlPerfil) {
        this.nome = nome;
        this.email = email;
        this.petFavorites = petFavorites;
        this.urlPerfil = urlPerfil;
    }

    public String getNome() {
        return this.nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getEmail() {
        return this.email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public List<Pet> getPetFavorites() {
        return this.petFavorites;
    }

    public void setPetFavorites(List<Pet> petFavorites) {
        this.petFavorites = petFavorites;
    }

    public String getUrlPerfil() {
        return this.urlPerfil;
    }

    public void setUrlPerfil(String urlPerfil) {
        this.urlPerfil = urlPerfil;
    }

    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

}
