package br.com.meadote.meadote.models;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.transaction.Transactional;

@Entity
@Transactional
@Table(name = "pet")
public class Pet implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @Column
    private String nome;

    @Column
    private String peso;

    @Column
    private Integer id_dono;

    @Column
    private String urlImagem;

    @Column
    private String descricao;

    @Column
    private String raca;

    @Column
    private String genero;

    @Column
    private Integer idade;

    @Column
    private String categoria;

    public Pet() {
    }

    public Pet(int id, String nome, String peso, Integer id_dono, String urlImagem, String descricao, String raca,
            String genero, Integer idade, String categoria) {
        this.id = id;
        this.nome = nome;
        this.peso = peso;
        this.id_dono = id_dono;
        this.urlImagem = urlImagem;
        this.descricao = descricao;
        this.raca = raca;
        this.genero = genero;
        this.idade = idade;
        this.categoria = categoria;
    }

    public int getId() {
        return this.id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNome() {
        return this.nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getPeso() {
        return this.peso;
    }

    public void setPeso(String peso) {
        this.peso = peso;
    }

    public Integer getId_dono() {
        return this.id_dono;
    }

    public void setId_dono(Integer id_dono) {
        this.id_dono = id_dono;
    }

    public String getUrlImagem() {
        return this.urlImagem;
    }

    public void setUrlImagem(String urlImagem) {
        this.urlImagem = urlImagem;
    }

    public String getDescricao() {
        return this.descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getraca() {
        return this.raca;
    }

    public void setraca(String raca) {
        this.raca = raca;
    }

    public String getGenero() {
        return this.genero;
    }

    public void setGenero(String genero) {
        this.genero = genero;
    }

    public Integer getIdade() {
        return this.idade;
    }

    public void setIdade(Integer idade) {
        this.idade = idade;
    }

    public String getCategoria() {
        return this.categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

}
